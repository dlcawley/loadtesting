#!/usr/local/bin/ruby -w

# Copyright (c) 2007 Topfunky Corporation
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require "rubygems"
require "production_log/analyzer"
require "gruff"
require 'yaml'

##
# Parses a logfile of results from httperf and generates a graph.
#
# See http://peepcode.com/products/benchmarking-with-httperf
#
# USAGE:
#
#   parse_httperf_log.rb sample-log.txt
#
# AUTHOR: Geoffrey Grosenbach http://peepcode.com
#

class ParseHttperfLog

  def self.run
    new(ARGV.first || usage()).run
  end

  def usage
    puts <<-USAGE
    USAGE:
    #{$0} logfile_name

    The logfile should have the "Reply rate" line from several httperf runs:

    Reply rate [replies/s]: min 548.8 avg 602.5 max 705.4 stddev 89.1 (3 samples)
    USAGE
  end

  def initialize(logfile_name)
    @logfile_name = logfile_name
    @counts = []
    @sections = []
    @skipped = 0
  end

  def run
    parse_log
    generate_graph
    print_stats
  end

  def parse_log
    total_time=0
    File.open(@logfile_name).readlines.each do |line|
      if line =~ /#(.+)/
        @sections << {
          :name => $1,
          :stats => {
            :reqrate =>[],
            :replyrate => [],
            :droprate => [],
            :failrate => [],
            :stddev => []
          }
        }
      elsif line =~ /Total: connections [0-9.]+ requests ([0-9]+) replies ([0-9]+) test-duration ([0-9.]+) s/
        total_time = $3.to_f
        @sections.last[:stats][:droprate] << ($1.to_f-$2.to_f)/total_time
      elsif line =~ /Request rate: ([0-9.]+) req\/s \(([0-9.]+) ms\/req\)/
        @sections.last[:stats][:reqrate] << $1.to_f
      elsif line =~ /Reply rate \[replies\/s\]: min ([0-9.]+) avg ([0-9.]+) max ([0-9.]+) stddev ([0-9.]+)/
        @sections.last[:stats][:stddev] << $4.to_f
      elsif line =~ /Reply status: 1xx=0 2xx=([0-9]+) 3xx=0 4xx=0 5xx=([0-9]+)/
        @sections.last[:stats][:replyrate] << $1.to_f/total_time
        @sections.last[:stats][:failrate] << $2.to_f/total_time
      end
    end
  end

  def generate_graph
    @sections.each do |section|
      g = Gruff::Line.new
      g.title = "#{section[:name]} Stats"
      g.theme = {
        :background_colors => ["#e6e6e6", "#e6e6e6"],
        :colors => ["black", 'green', 'orange', 'red', 'blue'],
        :marker_color => "white"
      }
      count=0
      section[:stats][:reqrate].each do |req|
        g.labels[count] = req.to_s
        count+=1
      end
      [:reqrate, :replyrate, :droprate, :failrate, :stddev].each do |stat|
        g.data stat, section[:stats][stat]
      end
      g.minimum_value = 0
      
      if section[:stats][:droprate].count < 2
        @skipped+=1
      else
        g.write "httperf_#{section[:name]}.png"
      end
    end
  end

  def print_stats
    puts "done with #{@sections.count-@skipped} sections, skipped #{@skipped}"
  end

  def format_float(value)
    "%0.1f" % value
  end

end

ParseHttperfLog.run