#!/bin/bash

output="all_httperf_results_`date +%D_%R`"
output=${output//\//_}
server=""

rm $output
echo "#Program Search" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=4 --timeout=5 --uri="/programs/result?search%5Bkeywords%5D=tech" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=6 --timeout=5 --uri="/programs/result?search%5Bkeywords%5D=tech" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=10 --timeout=5 --uri="/programs/result?search%5Bkeywords%5D=tech" >> $output
echo "==============" >> $output
echo "#Ladder Search" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=3 --timeout=5 --uri="/occupations/1/ladder?filter%5Bonet_soc_code%5D=15-1099.04&amp;search%5Bfilter%5D=LadderFilter" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=5 --timeout=5 --uri="/occupations/1/ladder?filter%5Bonet_soc_code%5D=15-1099.04&amp;search%5Bfilter%5D=LadderFilter" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=7 --timeout=5 --uri="/occupations/1/ladder?filter%5Bonet_soc_code%5D=15-1099.04&amp;search%5Bfilter%5D=LadderFilter" >> $output
echo "==============" >> $output
echo "#Lattice Search" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=2 --timeout=5 --uri="/occupations/1/lattice?filter%5Bonet_soc_code%5D=15-1099.04&amp;filter%5Bsetnumber%5D=7&amp;search%5Bfilter%5D=LatticeFilter&amp;sort=skill" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=5 --timeout=5 --uri="/occupations/1/lattice?filter%5Bonet_soc_code%5D=15-1099.04&amp;filter%5Bsetnumber%5D=7&amp;search%5Bfilter%5D=LatticeFilter&amp;sort=skill" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=7 --timeout=5 --uri="/occupations/1/lattice?filter%5Bonet_soc_code%5D=15-1099.04&amp;filter%5Bsetnumber%5D=7&amp;search%5Bfilter%5D=LatticeFilter&amp;sort=skill" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=8 --timeout=5 --uri="/occupations/1/lattice?filter%5Bonet_soc_code%5D=15-1099.04&amp;filter%5Bsetnumber%5D=7&amp;search%5Bfilter%5D=LatticeFilter&amp;sort=skill" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=10 --timeout=5 --uri="/occupations/1/lattice?filter%5Bonet_soc_code%5D=15-1099.04&amp;filter%5Bsetnumber%5D=7&amp;search%5Bfilter%5D=LatticeFilter&amp;sort=skill" >> $output
echo "==============" >> $output
echo "#Community Show" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=10 --timeout=5 --uri="/communities/1" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=12 --timeout=5 --uri="/communities/1" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=14 --timeout=5 --uri="/communities/1" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=15 --timeout=5 --uri="/communities/1" >> $output
echo "==============" >> $output
echo "#Occupation Search" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=4 --timeout=5 --uri="/occupations/result?search%5Bjobs_now_ind%5D=1" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=5 --timeout=5 --uri="/occupations/result?search%5Bjobs_now_ind%5D=1" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=8 --timeout=5 --uri="/occupations/result?search%5Bjobs_now_ind%5D=1" >> $output
echo "==============" >> $output
echo "#Candidate Search" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=2 --timeout=5 --uri="/candidates/result?search%5Bkeywords%5D=tech" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=3 --timeout=5 --uri="/candidates/result?search%5Bkeywords%5D=tech" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=10 --timeout=5 --uri="/candidates/result?search%5Bkeywords%5D=tech" >> $output
echo "==============" >> $output
echo "#Occupation Search Criteria" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=10 --timeout=5 --uri="/occupations/search" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=15 --timeout=5 --uri="/occupations/search" >> $output
echo "==============" >> $output
echo "#Assessment" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=15 --timeout=5 --uri="/assessment" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=20 --timeout=5 --uri="/assessment" >> $output
echo "==============" >> $output
echo "#Job Search" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=3 --timeout=5 --uri="/job_posts/result?search%5Bkeywords%5D=sales" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=4 --timeout=5 --uri="/job_posts/result?search%5Bkeywords%5D=sales" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=5 --timeout=5 --uri="/job_posts/result?search%5Bkeywords%5D=sales" >> $output
echo "==============" >> $output
echo "#Communities Index" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=10 --timeout=5 --uri="/communities" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=15 --timeout=5 --uri="/communities" >> $output
echo "==============" >> $output
echo "#Welcome" >> $output
httperf --hog --server=$server --num-conns=1000 --rate=10 --timeout=5 >> $output
httperf --hog --server=$server --num-conns=1000 --rate=12 --timeout=5 >> $output
httperf --hog --server=$server --num-conns=1000 --rate=14 --timeout=5 >> $output
httperf --hog --server=$server --num-conns=1000 --rate=15 --timeout=5 >> $output
httperf --hog --server=$server --num-conns=1000 --rate=20 --timeout=5 >> $output
httperf --hog --server=$server --num-conns=1000 --rate=30 --timeout=5 >> $output
echo "==============" >> $output