#!/bin/bash
#auth: redface-ts
#addtime: 2017-08-08
#function: inform when the password expires

inform_list='aaa@aaa.com'
expires_month=`chage -l root|grep 'Password expires'|awk '{print $4}'` 
expires_date=`chage -l root|grep 'Password expires'|awk '{print $5}'|cut -d ',' -f1`
now_month=`date +%c -d tomorrow|awk '{print $3}'`
now_date=`date +%c -d tomorrow|awk '{print $2}'`


function diff_date {
    if [ ${expires_month}x == ${now_month}x -a ${expires_date}x == ${now_date}x ];then
        echo 200
    else
        echo 403
    fi 
}

function send_message {
    for i in ${inform_list}
    do
        echo "192.168.100.22 password for root will expires tommorrow,please reset it!"| mail -s 'password expires notification' $i
    done
}
diff_code=`diff_date`
if [ ${diff_code} -eq 200 ];then
   send_message
fi
