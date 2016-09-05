#!/bin/sh

echo $0 $$

if test ! -s conf/area_number_list.conf
then
    echo "conf/area_number_list.conf is empty"
    exit 1
fi

:> data/res.tmp.a

cat conf/area_number_list.conf | while read line
do
    echo "debug: start to traverse area number $line, please wait 2 or 3 hours"
    echo "debug: running ..."
    echo "DO NOT ctrl+c, just wait it out."
    python script/traverse.py $line >> data/res.tmp.a
    echo "debug: end traverse area number $line"
done

echo "start to generate data/label.txt"
cat data/res.tmp.a | awk -F"/dhpic/" '{split($0,a,"\t"); p=a[1]; OFS="\t"; print p, $2}' | awk -F"\"" 'length($0)>1{print $1}' | awk -F"\t" '{g[$2]+=1; p[$2]=$1}END{OFS="\t"; for(i in g)print i, g[i], p[i]}' | sort -k2,2nr  |awk -F"\t" '{OFS="\t"; print $0, "http://www.114best.com/dh/114.aspx?w="$3, "http://www.114best.com/dhpic/"$1}' >data/res.tmp.b

cat data/res.tmp.b | awk -F"\t" 'BEGIN{
    OFS="\t"; print "Í¼Æ¬", "´ÊÊý", "ºÅÂë¾ÙÀý", "ºÅÂëurl", "Í¼Æ¬url", "LABEL";
    }{print $0, "";
}' >data/res.tmp.c
cp data/res.tmp.c data/label.txt
echo "generate data/label.txt ok"

exit 0
