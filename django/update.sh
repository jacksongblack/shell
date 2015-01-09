#encoding=utf-8
root_path=$PWD"/"
dxshop_path=$root_path
config_dir=$root_path"configFile"
dxcrm_ini=$root_path"dxcrm.ini"
dxcrm_path=$root_path"dx_crm"
echo "杀死正在运行的进程"
sudo killall -9 uwsgi
echo "删除源代码"
#rm -rf $dxshop_path
#rm -rf $dxusers_path
echo "进程被杀死，现在开始更新代码"
#svn checkout http://192.168.0.210/usvn/svn/shop/trunk/server/trunk/dxshop --username=songyuchao --password=songyuchao
#svn checkout http://192.168.0.210/usvn/svn/shop/trunk/server/trunk/dxusers --username=songyuchao --password=songyuchao
#cp $config_dir/dxshop_config.py $dxshop_path/config.py
#cp $config_dir/dxusers_config.py $dxusers_path/config.py
svn up $dxcrm_path
echo "代码更新完成,现在开始启动服务"
uwsgi $dxcrm_ini
sleep 3s
ps aux |grep uwsgi

