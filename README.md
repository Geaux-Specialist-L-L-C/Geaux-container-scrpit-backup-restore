Geaux Container Backup and Restore
Geaux Container Backup and Restore is a comprehensive solution for managing Docker container backups and restores. It consists of two primary components:

Electron Desktop Application: A user-friendly graphical interface for non-technical users to interact with Docker backup and restore processes.
Shell Scripts: Automated scripts that perform the actual backup and restore operations.
This project is designed to simplify Docker container management and ensure reliable backup and recovery.

Features
Electron Desktop Application
Cross-Platform Support: Works on Windows, macOS, and Linux.
User-Friendly Interface: Simplifies the execution of backup and restore operations.
Real-Time Feedback: Progress bars and status updates during operations.
Error Reporting: Displays clear error messages for troubleshooting.
Backup Script (backup_containers.sh)
Backs up:
Running Docker containers' filesystems.
Container images as .tar files.
Associated volumes, archived and compressed.
Dynamic: Automatically detects and processes all running containers.
Restore Script (restore_containers.sh)
Restores:
Container filesystems from .tar backups.
Container images to Docker.
Associated volumes to their original state.
Flexible: Restores containers and their environments seamlessly.
Requirements
For Shell Scripts
Linux/Unix system with Docker installed.
Root or sudo privileges to execute scripts.
For the Desktop Application
Docker installed and running locally.
Node.js and npm installed for development purposes (not required for end-users).
Electron runtime for packaged applications.
Usage
1. Electron Desktop Application
Installation:

Download the latest release from the releases page.
Install the application for your operating system.
Running the Application:

Open the application.
Use the "Backup" button to back up all running Docker containers.
Use the "Restore" button to restore Docker containers from backups.
2. Shell Scripts
Backup Containers
Run the backup_containers.sh script:

bash
Copy code
sudo ./backup_containers.sh
Restore Containers
Run the restore_containers.sh script:

bash
Copy code
sudo ./restore_containers.sh
Development
The Electron application can be extended to include additional features such as:

Scheduled Backups: Automatically back up containers at predefined intervals.
Selective Backup/Restore: Allow users to choose specific containers or volumes for backup/restore.
Logs and Reports: Provide detailed logs for each operation.
Multi-Host Support: Manage Docker containers on multiple hosts from a single interface.
To contribute or enhance this project, refer to the CONTRIBUTING.md file.

Contributors
We welcome contributions from the community! Check out the CONTRIBUTING.md file for guidelines on how to contribute.

Feel free to open an issue if you encounter any bugs or have suggestions for improvement.