#!/bin/bash
yum install wget unzip httpd -y
systemctl start httpd
systemctl enable httpd

