#!/bin/bash
ports=(12091 12089 10486 12094 12090 10454 12093 10455 12088 12080 12081 10294 9090 46900 12082 12083 12084 12085 12086 9090 12093 10295 8002 10110 10191 10354 10449 10486 10090 10198 12094 10447 10105 10279 10211 10102 10103 10106 10107 10454 10204 10104 10208 10301 10455 10095 10091 10189 10452 10294 10099 10108 10192 10096 10080 10092 10108 10194 10295 10109 10097 10195 10092 10197 10196 10101 10450 )
sum_mem=0
for port in ${ports[@]}
do
	pid=$(lsof -i:$port|grep LISTEN|awk '{print $2}')
	pid=${pid:=0}
	if [ $pid -eq 0 ];then
		echo "port:$port == pid:$pid"
	else
		mem=$(ps aux|grep $pid|grep -v grep|awk '{print $6}')
		mem=${mem:=0}
		sum_mem=$[sum_mem+mem]
		echo "port:$port == pid:$pid == mem:$mem"
	fi
done 
echo
echo "sum_mem:$sum_mem KB"
echo "sum_mem:$[sum_mem/1024] MB "
echo "sum_mem:$[sum_mem/1024/1024] GB"
