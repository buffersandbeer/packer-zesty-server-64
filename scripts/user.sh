#!/bin/bash

# Root User Script Config
ROOT_PW='RootChangeMe!'
ROOT_SSH=''

# Otto User Script Config
OTTO_PW='OttoChangeMe!'
OTTO_SSH='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjFCswTyByJKuznnQxI6bqmV9X9jj4ATVs6mrUaQp4NEm/XnOcF8Y8k4vOgK9xsWmFpIFLdypXdE8GHOxXRocszMdDvXGikSblgeFL6ruiEXkYaqOjljLDL0mwDeDnA1tSfHVhnvqWICV+B88RdoGfHhVYuYldvKyd6HfesqU5r9NJpTyif5sjiTWGSPkHSgtp9l39tvzqEnUMnacGA7JIYrSczKBH8U1u64fyvcGwZcttrY7Vpow1gMqTk94NpPGffNNEAkQzFciMeLklVFhiI5H+GASNO64gCvDd6tawk0JFsOtmc/ZBNtKXnGzUWNjtM2859ti+XcmOHR9FBOuYaJhx5WlzBV6VsWT1Ol1hKmYvT+Nofq41zwnsxNc7xNNhA+nr9ijQz4dYdbJtQhiPTcFJsqObx9IRtbnlEinWw3U5gOU1XxACYXWZ3XP1HikZy0NIJeQf87zQgTmynX+VnXc/v5BE92EUMIuMlQaDZ5/BAJkl4D7Wz1/Y04WTqWpxojJbaq8f9PZPrtZMUQ0EL5Hk69hjAHrUC3Yi0XGR8nVIRtbbe7AkEja/Q7vCr+Yub6IpevoGtAv2HwoQ8pXmCWCQm/m5gb/s3TIPC9X62UGV2Pv3HEstVpE+PSWuTHPQtvSk+xPo4NwgQZ+8/X7V2peNuikEMn0lO2+7+Oz4jQ== agleason@AGLEASON-M-14RC'

# Root Configuration
mkdir -p /root/.ssh/
echo $ROOT_SSH >> /root/.ssh/authorized_keys
echo root:$ROOT_PW | /usr/sbin/chpasswd

# Otto Configuration
mkdir -p /home/otto/.ssh/
chown otto:otto /home/otto/.ssh
echo $OTTO_SSH >> /home/otto/.ssh/authorized_keys
chown otto:otto /home/otto/.ssh/authorized_keys
echo otto:$OTTO_PW | /usr/sbin/chpasswd
rm /home/otto/linux.iso

# System Config
apt-get -y -qq update

# OpenSSH Config
mkdir /etc/ssh/old_keys
mv /etc/ssh/ssh_host_* /etc/ssh/old_keys
dpkg-reconfigure openssh-server
sed -i 's/*PermitRootLogin*/PermitRootLogin\ without-password/g' /etc/ssh/sshd_config
