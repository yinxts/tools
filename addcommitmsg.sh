#!/bin/sh
#Author: xiaotao.yin(yinxts@gmail.com)
#This script created based on meng.li's patch filter script.
#Create one subfolder under your SDK, and copy your patches to there
#BASE_SH1 is the base of your SDK used to format-patch

#Step1: get the title of your patch
BASE_SH1=a9da8725b7a744be3ff0ff44cab2547e4d1e6675
for each in `ls *.patch`; do title=`grep -m 1 -n "Subject" $each`;
len=`echo $title | wc -L`;
#echo $len
titleIndex=`expr index "$title" ]`;
titleIndex=`expr $titleIndex + 2`
title1=`echo $title | cut -c $titleIndex-$len`;
echo $title1

len1=`echo $title1 | wc -L`;
#echo $len1
titleIndex1=`expr index "$title1" :`;
titleIndex1=`expr $titleIndex1 + 2`
title2=`echo $title1 | cut -c $titleIndex1-$len1`;
#echo $title2

#Step2: get this patch's original SHA1 from SDK
logstring=$(git log --grep="$title1" $BASE_SH1..HEAD|awk 'NR==1'|awk '{print $2}')
echo $logstring

#Step3: write back to your patch
#the length:  #logstring >= 1
if [ ${#logstring} -ge 1 ]; then
  #find the first blank line
  pline=`grep -n ^$ $each|awk 'NR==1'|cut -d ':' -f 1`;
  #calc the insert position
  pline1=`expr $pline + 1`
  pline2=`expr $pline + 2`
  echo $pline1
  echo $pline2
  sed -i "$pline1 i commit $logstring from" $each
  sed -i "$pline2 i git@git.assembla.com:cavium/WindRiver.linux.git\n" $each
else
  echo "no reference sha1"
fi

done
