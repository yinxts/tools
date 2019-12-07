#!/bin/sh
#for each in `ls *.patch`;do num=`grep -m 1 -n "\-\-\-" $each | awk -F : '{print$1}'`;
#sed "$num i\[Original patch taken from" -i $each;
#sed "$num a\Signed-off-by: Meng Li <Meng.Li@windriver.com>" -i $each;
#sed "$num a\QorIQ-SDK-V1.8-SOURCE-20150619-yocto.iso]" -i $each; 
#done

patches_from=/buildarea4/workspace/cn96xx/org-511-patches
patches_to=/buildarea4/workspace/cn96xx/new-cn96xx-bsp/build/tmp-glibc/work-shared/marvell-cn96xx/kernel-source
patches_filtered=/buildarea4/workspace/cn96xx/org-511-patches/filtered
BASE_SH1=e40a826a6cbc23e63a769e50dc71eb34ba6ddabf
cd $patches_to
pwd

for each in `ls $patches_from/*.patch`; do title=`grep -m 1 -n "Subject" $each`;
len=`echo $title | wc -L`;
echo $len
titleIndex=`expr index "$title" ]`;
titleIndex=`expr $titleIndex + 2`
title1=`echo $title | cut -c $titleIndex-$len`;
echo $title1

len1=`echo $title1 | wc -L`;
echo $len1
titleIndex1=`expr index "$title1" :`;
titleIndex1=`expr $titleIndex1 + 2`
title2=`echo $title1 | cut -c $titleIndex1-$len1`;
echo $title2
#cd $patches_to
#4.14 To 4.18
logstring=$(git log --grep="$title1" $BASE_SH1..HEAD)
echo ${#logstring}
if [ ${#logstring} -ge 1 ]; then
  echo "matched";
  mv $each $patches_filtered 
else
  echo "no match";
fi
#cd -
done
