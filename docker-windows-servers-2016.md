#Docker On Windows Server 2016

Như các bạn đã biết kể từ phiên bản Windows Server 2016 Microsoft đã chính thức hỗ trợ Docker
Và bản Windows server 2016 TP 4 đang được MS cho dùng thử Link download
Vì đây chưa phải là phiên bản chính thức nên Có nhiều tính năng của docker chưa được hỗ trợ (docker-compose, docker-swarm, docker-machine) và cũng chưa có nhiều images được phát triển
###Chuẩn bị

Một máy đã cài Windows Server 2016
Internet

###Cài đặt

####Step 1: Cài đặt Docker

Mở Windows Power Shell download script cài đặt của MS

`wget -uri http://aka.ms/setupcontainers -OutFile C:\SetupContainer.ps1`

Chạy Script

`C:\SetupContainer.ps1`

Sau khi chạy xong WS 2016 sẽ reboot

####Step 2: Cấu hình NAT, Download Images

Mở lại windows Power shell và chạy tiếp script lần 2

`C:\SetupContainer.ps1`

Lúc này script sẽ enable container networking , tạo các rules NAT và các thiết lập khác

Sau đó sẽ tự động download image base windowscore tại http://aka.ms/ContainerOSImage

*Note: Việc download khá lâu mình phải mất 1 tiếp mới có thể download được nó. Các bạn kiên nhẫn chờ đợi nhé*



####Step 3: Kiểm tra

Sau khi hoàn thành ta có thể kiểm tra version của docker bằng command
docker version



####Step 4 Tạo images chạy Webserver IIS

Ta chạy 1 container từ image windowsservercore

`docker run -it --name demo-iis windowsservercore powershell`

Cài đặt IIS cho Container

`Install-WindowsFeature web-server`

Thoát và commit

`exit`

`docker commit demo-iis webserver-iis`

Kiểm tra các images

`docker images`

####Step 5: Chạy containers IIS

Mở windows PowerShell chạy lệnh sau

`docker run -it -p 8080:80 -v C:\test:C:\inetpub\wwwroot\websitedemo --name iisdemo webserver-iis powershell`

Tạo file index.html tại thư mục C:\test\

`<h3> Docker on Windows Server </h3>`
Kiểm tra

`wget localhost:8080`
