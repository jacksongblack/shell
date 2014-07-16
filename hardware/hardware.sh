#!/bin/bash
#测试所有硬盘读的速度并输出到文档
CURRENT_DIR="${PWD}"

function dividing_line {
echo "-------------------------------------------------------" >> "${CURRENT_DIR}"/hardware.out
}

function disk_test   {
dividing_line
cd /dev
for d in $(ls|grep sd);
do
 echo "测试${d}的读写速度" 
 echo "测试${d}的读写速度" >> "${CURRENT_DIR}"/hardware.out
 sudo hdparm -Tt /dev/${d} >> "${CURRENT_DIR}"/hardware.out 
done
dividing_line
}

function chkError(){
	if [ $? != 0 ];then
         	echo $2
                exit 1
	fi
}
#检查输出文件是否存在
function chk_file () {
if [ -f "${CURRENT_DIR}"/hardware.out ];then
 rm "${CURRENT_DIR}"/hardware.out
fi
}

function hard_disk_info () {
dividing_line
echo "输出硬盘信息"
for d in  a b c d e f g h i j k l m n o p q r s t u v w ;
do
sudo  hdparm -i "/dev/sd${d}" >>  "${CURRENT_DIR}"/hardware.out 2> /dev/null
done
echo "输出完成"
dividing_line
}

function cpu_info {
echo "输出CPU信息"
dividing_line
echo " CPU信息" >> "${CURRENT_DIR}"/hardware.out
cat /proc/cpuinfo | grep "model name" | uniq |awk -F: '/model name/{printf $2}' >> "${CURRENT_DIR}"/hardware.out
echo "" >>  "${CURRENT_DIR}"/hardware.out
dividing_line
}

function memory_info {
echo "输出内存信息"
dividing_line
echo "内存信息" >> "${CURRENT_DIR}"/hardware.out
sudo dmidecode | grep -P -A 5 "Memory Device" | grep Size | grep -v Range >> "${CURRENT_DIR}"/hardware.out

sudo dmidecode | grep -P 'Maximum\s Capacity'
dividing_line
}

function system_infomation {
echo "输出主板信息"
dividing_line
echo "生产公司" >> "${CURRENT_DIR}"/hardware.out
sudo dmidecode |grep 'Manufacturer' | uniq |awk 'NR==1'|awk -F: '{printf $2}' >>"${CURRENT_DIR}"/hardware.out
echo "" >> "${CURRENT_DIR}"/hardware.out
echo "型号" >> "${CURRENT_DIR}"/hardware.out
sudo dmidecode |grep 'Product Name' | awk -F: '{printf $2}' >> "${CURRENT_DIR}"/hardware.out
echo "" >>"${CURRENT_DIR}"/hardware.out
dividing_line
}

chk_file    
disk_test
hard_disk_info   
cpu_info   
memory_info
system_infomation 
