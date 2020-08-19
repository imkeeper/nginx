#添加用户和组
groupadd www
useradd -g www www

#配置
./configure \
--user=www \
--group=www \
--prefix=/usr/local/nginx \
--with-debug \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_realip_module 


#编译
make -j8

#安装
make install
