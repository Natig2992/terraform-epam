#!/usr/bin/env bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y 
sudo systemctl enable nginx
sudo systemctl start nginx

sudo chmod -R 777 /usr/share/nginx/html/index.html

myhostname=`curl http://169.254.169.254/latest/meta-data/hostname`

sudo cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
   <body bgcolor="black">
     <h2 align="center"><font color="white">Build by Terraform for my EPAM Terraform  mini task</h2><br><p align="center">
     <font color="white">Server Hostname: <font color="white">$myhostname<br><br>
     <font color="white">
     <h4 align="center">Created by Nagiev Natig</h4>
   </body>
</html>
EOF

sudo systemctl reload nginx
