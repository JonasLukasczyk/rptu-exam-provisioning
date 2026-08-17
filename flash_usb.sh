sudo dd \
  if=./iso/proxmox-exam-0.1.0.iso \
  of=/dev/sdc \
  bs=4M \
  status=progress \
  oflag=direct \
  conv=fsync

sync
