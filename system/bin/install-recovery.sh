#!/system/bin/sh
  echo 1 > /sys/module/sec/parameters/recovery_done		#tony
if ! applypatch -c EMMC:recovery:5103616:1429cfd39700893f1dd360ca77671329dd1cd5b6; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:boot:4415488:66cc18999c028ed7309cea91e46164cab20c087b EMMC:recovery 1429cfd39700893f1dd360ca77671329dd1cd5b6 5103616 66cc18999c028ed7309cea91e46164cab20c087b:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  if applypatch -c EMMC:recovery:5103616:1429cfd39700893f1dd360ca77671329dd1cd5b6; then		#tony
	echo 0 > /sys/module/sec/parameters/recovery_done		#tony
        log -t recovery "Install new recovery image completed"
        
  if applysig /system/etc/recovery.sig recovery; then
    sync
    log -t recovery "Apply recovery image signature completed"
  else
    log -t recovery "Apply recovery image signature fail!!"
  fi

    
  else
	echo 2 > /sys/module/sec/parameters/recovery_done		#tony
        log -t recovery "Install new recovery image not completed"
  fi
else
  echo 0 > /sys/module/sec/parameters/recovery_done              #tony
  log -t recovery "Recovery image already installed"
fi
