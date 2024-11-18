# Geaux-container-scrpit-backup-restore
# Docker Backup and Restore Scripts

These scripts automate the process of backing up and restoring Docker containers, their images, and associated volumes. They are designed to work dynamically with any group of Docker containers on a host system, ensuring a comprehensive and reliable backup and recovery process.

---

## Features
- **Backup Script** (`backup_containers.sh`):
  - Backs up running Docker containers.
  - Saves container filesystems as `.tar` files.
  - Saves container images as `.tar` files.
  - Archives and compresses associated volumes.
  
- **Restore Script** (`restore_containers.sh`):
  - Restores containers from their filesystem backups.
  - Reloads container images.
  - Recreates and restores associated volumes.

---

## Requirements
- Linux/Unix system with Docker installed.
- Root or sudo privileges to run the scripts.

---

## Usage

### **Backup Containers**
1. Run the `backup_containers.sh` script:
   ```bash
   sudo ./backup_containers.sh
