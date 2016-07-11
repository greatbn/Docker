#Docker-Registry

###Hướng dẫn triển khai docker-registry để lưu trữ image private

###Môi trường thực hiện
```
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.3 LTS
Release:	14.04
Codename:	trusty

```

###Các bước triển khai
####1.Cài đặt docker-registry

- Thành phần index bao gồm apache-utils và nginx cho việc xác thực tính password và tính năng SSL cho HTTPS.

- Người dùng cần lưu ý rằng phiên bản hiện tại của Docker registry chỉ hỗ trọ HTTPS để kết nối tới registry.Vì vậy Nó bắt buộc user triển khai và sử dụng SSL để bảo vệ dữ liệu. SSL tạo 1 kết nối mã hóa giữa 1 web server và client.

- Cài đặt các gói cần thiết

`apt-get install –y build-essential python-dev libevent-dev python-pip liblzma-dev swig libssl-dev`

- Cài đặt Docker registry

`pip install docker-registry`

####2. Cấu hình cho docker-registry

- Copy file cấu hình

`cp /usr/local/lib/python2.7/dist-packages/config/config_sample.yml /usr/local/lib/python2.7/dist-packages/config/config.yml`

- Tạo thư mục cho docker-registry

`mkdir /var/docker-registry`

- Tìm và sửa file config.yml như sau:

```
sqlalchemy_index_database:
_env:SQLALCHEMY_INDEX_DATABASE:sqlite:////var/dockerregistry/docker-registry.db

```

- Và

```
local: &local
storage: local
storage_path: _env:STORAGE_PATH:/var/docker-registry/registry
```

- Tạo thư mục log cho docker-registry

`mkdir  /var/log/docker-registry`

- Tạo file init docker-registry để start và stop service docke-registry
- Tạo file /etc/init/docker-registry.conf

```
cat  << EOF > /etc/init/docker-registry
description "Docker Registry"
start on runlevel [2345]
stop on runlevel [016]
respawn
respawn limit 10 5
script
exec gunicorn --access-logfile /var/log/docker-registry/access.log --error-logfile /var/log/docker-registry/server.log -k gevent --max-requests 100 --graceful-timeout 3600 -t 3600 -b localhost:5000 -w 8 docker_registry.wsgi:application
end script
EOF
```

- Lưu và thoát. Chạy câu lệnh sau để chạy dịch vụ Docker registry

`service docker-registry start`

####3. Cài đặt nginx và apache2-utils

`apt-get install –y nginx apache2-utils`

- User tạo login ID và password để truy cập vào Docker registry

`htpasswd –c /etc/nginx/docker-registry.htpasswd saphi`

- Nhập password, lúc này chúng ta có login ID và passwd để truy cập vào Docker registry

####4. Cấu hình nginx với Docker registry
- Tạo file cấu hình nginx /etc/nginx/sites-available/docker-registry 

```
cat << EOF > /etc/nginx/sites-available/docker-registry
upstream docker-registry {
server localhost:5000;
}
server {
listen 8080;
server_name saphi-docker.com;
#ssl on;
#ssl_certificate /etc/ssl/certs/docker-registry;
#ssl_certificate_key /etc/ssl/private/docker-registry;
proxy_set_header Host       $http_host;
proxy_set_header X-Real-IP  $remote_addr;
client_max_body_size 0;
chunked_transfer_encoding on;
location / {
auth_basic              "Restricted";
auth_basic_user_file    docker-registry.htpasswd;
proxy_pass http://docker-registry;
}
location /_ping {
auth_basic off;
proxy_pass http://docker-registry;
}
location /v1/_ping {
auth_basic off;
proxy_pass http://docker-registry;
}
}

EOF

```
- Link file cấu hình và restart nginx

`ln -s /etc/nginx/sites-available/docker-registry /etc/nginx/sites-enabled/docker-registry`

- Restart Nginx

`service nginx restart`

- Kiểm tra bằng cách sử dụng lệnh sau

`curl localhost:5000`

- Nếu trả về 
```
“\n”docker-registry server\””
```
- Docker Registry đã chạy. Tiếp theo chúng ta sẽ check nginx đã hoạt động chưa. Sử dụng câu lệnh sau

`curl locahost:8080`

- Nếu trả về Authorization Reqired thì chạy lệnh

```
curl saphi:passwd@localhost:8080
"\"docker-registry server\""root@docker-registry:~#
```

- Việc xác thực user và passwd chính xác.

####5. Cài đặt SSL trên web server

- Xóa comment 3 dòng sau trong file /etc/sites-available/docker-registry

```
ssl on;
ssl_certificate /etc/ssl/certs/docker-registry;
ssl_certificate_key /etc/ssl/private/docker-registry;

```

- Đăng kí ssl và copy file certs vào thư mục /etc/ssl/certs và /etc/ssl/private/ và private key vào thư mục /etc/ssl/private/ đổi tên thành docker-registry

- Hoặc bạn có thể tự tạo certs và key để test thực hiện các bước sau đây
```

mkdir ~/certs
cd ~/certs

```

- Generate root key mới

`openssl genrsa -out devdockerCA.key 2048`

- Generate root certificate

`openssl req -x509 -new -nodes -key devdockerCA.key -days 10000 -out devdockerCA.crt`

- Generate key cho server

`openssl genrsa -out dev-docker-registry.com.key 2048`

- Tạo 1 certificate signing request.

- Lưu ý: Sau khi gõ câu lệnh này Nhập bất cứ điều gì bạn muốn nhưng khi OpenSSL hỏi bạn “Common Name” thì chắc chắn rằng domain của server bạn. Ví dụ ở đây mình sẽ nhập saphi-docker.com.

- Không nhập password challenge

`openssl req -new -key dev-docker-registry.com.key -out dev-docker-registry.com.csr`

- Tiếp theo chúng ta cần sign certificate request

`openssl x509 -req -in dev-docker-registry.com.csr -CA devdockerCA.crt -CAkey devdockerCA.key -CAcreateserial -out dev-docker-registry.com.crt -days 10000`

- Bây giờ chúng ta đã có đầy đủ các file tiến hành copy vào đúng thư mục

```

cp dev-docker-registry.com.crt /etc/ssl/certs/docker-registry
cp dev-docker-registry.com.key /etc/ssl/private/docker-registry

```
- Kiểm tra SSL

- Chúng ta cần nói với mỗi client rằng certificate này là hợp pháp
- Tạo thư mục sau tại máy client

`mkdir /usr/local/share/ca-certificates/docker-dev-cert`

- Copy file devdockerCA.crt đã tạo tại server vào folder docker-dev-cert

- Chạy lệnh sau để cập nhập certificates

`update-ca-certificates`

- Sau khi hoàn tất chạy lệnh sau
- Máy mình có IP là 10.10.10.30 vậy ta Thêm dòng sau vào file hosts
```
10.10.10.30 	saphi-docker.com
```
- Thực hiện

`curl https://saphi:passwd@saphi-docker.com:8080`

- Nếu trả về như này thì đã hoạt động

<img src="http://i.imgur.com/g9x4P6r.png">


###Push image vào Docker registry mới tạo

- Thực hiện login vào registry


`docker login https://saphi-docker.com:8080`


<img src="http://i.imgur.com/jLZawBs.png">


- Chạy 1 container

<img src="http://i.imgur.com/gvx171c.png">

- Commit container

<img src="http://i.imgur.com/J1YE76D.png">


- Tag và push lên docker registry


<img src="http://i.imgur.com/FHZEUI9.png">

- Xóa images và pull lại image từ registry

<img src="http://i.imgur.com/Z4aE36u.png">




Và Docker Registry đã hoạt động
