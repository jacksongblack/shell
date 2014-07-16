#!/bin/bash
#program
# This ruby on rails deployment script
FILE_PATH="$PWD"
function check {
echo "run $1"
command -v $1
if [[ "$?" -ne 0 ]]; then
echo " Execute the $1  fails "
$2
fi	
}

function install_rvm {
sudo yum update 
sudo yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel
echo 'installing rvm ....'
curl https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer | bash -s stable
cp $FILE_PATH/ruby/ruby-1.9.3-p484.tar.bz2 ~/.rvm/archives/
cp $FILE_PATH/ruby/rubygems-2.2.2.tgz   ~/.rvm/archives/ 
source ~/.profile
echo 'install over'
}
function add_scripts_to_bashrc {
echo -e $1 >> ~/.bashrc
}
function install_ruby {
sed -i 's!cache.ruby-lang.org/pub/ruby!ruby.taobao.org/mirrors/ruby!' ~/.rvm/config/db
rvm install 1.9.3
source ~/.bashrc
rvm use 1.9.3 --default
gem sources --remove https://rubygems.org/
gem sources -a http://ruby.taobao.org/
check "rails -v" "gem install rails"
}

check "rvm -v" "install_rvm"
add_scripts_to_bashrc 'if test -f ~/.rvm/scripts/rvm; then\n
 ["$(type -t rvm)"= "function"] || source ~/.rvm/scripts/rvm \n
fi'
source ~/.bashrc
check "ruby -v" "install_ruby"
sudo reboot

