#!/bin/sh

LOG="/var/log/smb-flexvol-installer.log"
VER="1.0.2"
target_dir="${TARGET_DIR}"
echo "begin to install smb FlexVolume driver ${VER} ..." >> $LOG

if [[ -z "${target_dir}" ]]; then
  target_dir="/etc/kubernetes/volumeplugins"
fi

smb_vol_dir="${target_dir}/microsoft.com~smb"
mkdir -p ${smb_vol_dir} >> $LOG 2>&1

#copy smb script
cp /bin/smb ${smb_vol_dir}/smb >> $LOG 2>&1
chmod a+x ${smb_vol_dir}/smb >> $LOG 2>&1

echo "install smb FlexVolume driver completed." >> $LOG

#https://github.com/kubernetes/kubernetes/issues/17182
# if we are running on kubernetes cluster as a daemon set we should
# not exit otherwise, container will restart and goes into crashloop (even if exit code is 0)
while true; do echo "install done, daemonset sleeping" && sleep 3600; done
