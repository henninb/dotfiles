#!/bin/sh

# Define backup directory and VM IDs
BACKUP_DIR="/local-240"
VM_IDS="100 101 102 103 106 200"

# Loop through each VM ID and run vzdump
for VM_ID in $VM_IDS; do
    echo "Starting backup for VM $VM_ID..."
    vzdump $VM_ID --dumpdir $BACKUP_DIR --mode stop
    echo "Backup completed for VM $VM_ID."
done

cd "$BACKUP_DIR" || exit
rm *.log
scp *.vma henninb@192.168.10.40:/mnt/external/proxmox-backups/

echo "All backups completed successfully."

exit 0
