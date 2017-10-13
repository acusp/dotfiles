free -m | grep -i mem | awk '{if($4 < 3000){ printf("3") > "/proc/sys/vm/drop_caches"}}';
