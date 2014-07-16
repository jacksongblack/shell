#!/bin/bash
#Program:
#       is's run test scrict
# History
# 2014/3/4

function run {
echo $1
while :
do
 $1   
done
} 

source baisc_test.sh 
echo '输入1进入单次测试模式'
echo '输入2进入稳定性测试模式'
echo '输入具体方法名将会被执行'

read command
if [ $command -eq '1' ]; 
then
test_cpu
test_hard_disk_ready
test_hard_disk
test_hard_disk_clear
test_threads
test_memory

elif [ $command -eq '2' ];
then
test_hard_disk_ready
 command=(test_hard_disk test_cpu test_threads test_memory)
 i=0  
 num=${#command[@]} 
 while [[ $i -le num ]]; do
 ${command[$i]}
   echo ${command[$i]}
   run ${command[$i]} >> test.out 2>&1 &
  : $[ i++ ]
done
else
$command
fi 
