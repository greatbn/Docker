Chạy lệnh sau

```
docker run -it -p 80:80 \
--env="DB_PASSWD=root_passwd"  \
--env="WP_DB_USER=db_user" \
--env="WP_DB_PASSWD=password" \
--e ="WP_DB_NAME=your_db_name" saphi/wordpress 
```
Sau khi lauch lên nhập password root cho DB như lúc bạn truyền vào
nếu 4 biến môi trường này không truyền vào thì  các giá trị mặc định là 

DB_PASSWD="toor" 
WP_DB_USER="wordpress" 
WP_DB_PASSWD="wordpress"
WP_DB_NAME="wordpress"

Sau khi nhập password xong nhấn Ctrl + P và Crtl + Q để ẩn container 

Truy cập  vào IP của Docker host cài đặt wordpress
