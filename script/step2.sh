#!/bin/sh

if test ! -s data/label.res
then
    echo "warning: please provide data/label.res"
    exit 1
fi

cat data/res.tmp.a |awk -F"/dhpic/" '{split($0,a,"\t"); p=a[1]; OFS="\t"; print p, $2}' | awk -F"\"" 'length($0)>1{print $1}' | awk -F"\t" 'NR==FNR{d[$1]=$6}NR!=FNR{OFS="\t"; print $0, d[$2]}' data/label.res - | awk -F"\t" '$3!=""{print}' | awk -F"\t" '{OFS="\t"; $1=substr($1,1,9); print}' >data/final.res.tmp.a

if test -s conf/delete_those_words_in_result.conf
then
    cat conf/delete_those_words_in_result.conf | awk -F"\t" 'ARGIND==1{
        if ($1 != "") {
            wd[$1] = 1
        }
    }ARGIND==2{
        w = $3
        donot_save = 0
        if (w != "") {
            for (i in wd) {
                if (match(w, i)) {
                    donot_save = 1
                }
            }
        }
        OFS = "\t"
        if (donot_save == 0) {
            print $0
        }
    }' - data/final.res.tmp.a >data/final.res.tmp.b
else
    cp data/final.res.tmp.a data/final.res.tmp.b
fi

cp data/final.res.tmp.b data/final.txt
echo "please excute [sz data/final.txt]"

exit 0

