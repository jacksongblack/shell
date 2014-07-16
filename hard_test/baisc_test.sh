#!/bin/bash
#Program
# This program Automatic test hardware and output to hard_test.out
FILE_NAME="/root/hard_test.out"
rm -f hard_test.out 
function write_file {
tee -a $FILE_NAME
}

function test_hard_disk  {
echo 'run test hard disk'
sysbench --test=fileio --num-threads=16 --file-total-size=1000M --file-test-mode=rndrw run | write_file
echo '--------------------------------------'| write_file
}

function test_hard_disk_ready {
echo 'ready to hard disk test'
sysbench --test=fileio --num-threads=16 --file-total-size=1000M --file-test-mode=rndrw prepare 
}

function test_hard_disk_clear {
echo 'Clear disk test environment'
sysbench --test=fileio --num-threads=16 --file-total-size=1000M --file-test-mode=rndrw cleanup
}

function test_cpu {
echo 'test CPU'
sysbench --test=cpu --cpu-max-prime=20000 run | write_file
echo '--------------------------------------'| write_file
}

function test_threads {
echo 'test threads'| write_file
sysbench --test=threads --num-threads=64 --thread-yields=100 --thread-locks=2 run | write_file
echo '--------------------------------------'| write_file
}


function test_memory {
echo 'test memory'| write_file
sysbench --test=memory --num-threads=16  --memory-block-size=8 --memory-total-size=16G run |write_file
sysbench --test=memory --num-threads=16  --memory-oper=read --memory-block-size=8 --memory-total-size=16G run |write_file
echo '-------------------------------------------'|write_file
}

test_memory >>out.out 2>&1 &

