#!/bin/bash
if [ $# -eq 0 ];then
echo -e  "请输入参数"
	exit 0;
elif [ $# -eq 3 ];then
	echo $3 > tmpfile
	http_load -p $1 -s $2 tmpfile 2>&1
elif [ $# -eq 2 ];then
	cat /dev/null > p$1s$2httpload$(date +%F).out
	for url in `cat url.txt `;do
		echo "$url" > tmpfile
		echo "$(date +%F" "%T) http_load -p $1 -s $2 $url"
		echo  -e "$(date +%F" "%T) \n\033[31mTestURL\033[31m \e[0m $url" >> p$1s$2httpload$(date +%F).out
		echo -e "\033[31m`http_load -p $1 -s $2 tmpfile 2>&1` \033[31m \e[0m" >> p$1s$2httpload$(date +%F).out
		avg1=`ssh tj1 'cat /proc/loadavg'`
		avg2=`ssh tj2 'cat /proc/loadavg'`
		echo -e "tj1 load average: $avg1 tj2 load average: $avg2" >> p$1s$2httpload$(date +%F).out
		sleep 3
	done
	cat p$1s$2httpload$(date +%F).out |grep  "tj1"|awk '{print $1" "$4"/"$9" "$12}'
	cat p$1s$2httpload$(date +%F).out |grep  "fetches/sec"|awk '{print $1"\t"$2}'
else
	case "$1" in
		h|-h|help|-help|--help)
		echo -e "请在程序后输入'线程'和'时间'参数并使用空格隔开\n正确示例：./hlt.sh 20 10 或 ./hlt.sh 50 60 http://url/\n请将需要测试的url地址存放于url.txt中。"
		;;
		*)
		echo -e "参数格式有误"
		;;
	esac
	exit 1;
fi
exit 0
