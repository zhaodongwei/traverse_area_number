#!/bin/sh:

cmd=$1

function usage() {
    echo "----------------------------------------------------------------------"
    echo "$0 is a control script, just run step1~step2 in sequence and generate the output."
    echo "please notice that, between step1 and step2, a manualy labeled file MUST be pasted in this env"
    echo ""
    echo ""

    echo "prepare:"
    echo "    vim conf/area_number_list.conf, put each area number in each line and save&exit"
    echo "step1:"
    echo "    execute cmd([] NOT included): [sh $0 step1]"
    echo "prepareA in step1-2:"
    echo "    execute cmd([] NOT included): [sz data/label.txt], open it in excel and put manually labeled value in col LABEL"
    echo "prepareB in step1-2:"
    echo "    choose all content in excel and CMD+C, [vim data/label.res], paste choosed content and save&exit."
    echo "step2:"
    echo "    execute cmd([] NOT included): [sh $0 step2]"
    echo "prepare after step2:"
    echo "    execute cmd([] NOT included): [sz data/final.txt], open it in excel and you'll get the final result"
    echo ""
    echo "Any question, please contact zhaodw@outlook.com at any time."
    echo ""
    echo "----------------------------------------------------------------------"
}

if test "x$cmd" == "x"
then
    echo "I need a cmd, maybe step1/step2, but you cmd is empty"
    usage
    exit 1
fi

if test $cmd == "help" -o $cmd == "HELP" -o $cmd == "-h" -o $cmd == "-H"
then
    usage
    exit 0
fi

if test $cmd != "step1" -a $cmd != "step2"
then
    echo "I need a cmd, maybe step1/step2, but you cmd is $cmd"
    usage
    exit 1
fi

if test $cmd == "step1"
then
    s=`date +%s`
    mkdir -p history_job/data.$s/
    cp data/* history_job/data.$s/
    cp conf/* history_job/data.$s/
    rm -rf data/*
fi

sh script/${cmd}.sh
ret=$?

if test $ret -ne 0
then
    echo "execute $cmd failed"
    exit 1
fi

exit 0
