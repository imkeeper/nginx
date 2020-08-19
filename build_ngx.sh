#!/bin/bash  
#nginx auto-deploy script by junyi     2020-08-19  
path=/usr/local/src  
vers=1.19.2  
user=nginx

yum install gcc gcc-c++ automake zlip     zlib-devel  pcre pcre-devel openssl wget openssl-devel -y  
if [ $? -ne 0 ];then  
  echo "yum failed"  
else  
  id $user  &>/dev/null
  [ $? -eq 0 ] && : || useradd  $user  -s /sbin/nologin -M  
  [ -d $path ] && : || mkdir -p $path    
  cd $path  
  [ -f nginx-${vers}.tar.gz ] && : ||   wget http://nginx.org/download/nginx-${vers}.tar.gz  
  if [ $? -ne 0 ];then    
      echo "download nginx false" && exit 1 
  else  
      tar xf nginx-$vers.tar.gz 
      cd $path/nginx-$vers     
      ./configure     --prefix=/usr/local/nginx-$vers  --user=$user --group=$user --with-http_stub_status_module   --with-http_ssl_module --with-http_gzip_static_module  --with-http_sub_module --with-pcre 
      make && make   install  
      [ $? -eq 0 ] && echo "nginx install success" || echo "nginx  install make error"
      ln -sf   /usr/local/nginx-$vers   /usr/local/nginx   
  fi
fi
mkdir -p /usr/local/nginx/conf/extra
