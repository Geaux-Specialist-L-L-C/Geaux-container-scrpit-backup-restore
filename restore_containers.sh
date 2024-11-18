#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

# Directory containing backups
BACKUP_DIR="./docker_backups"

# Check if backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
  echo "Backup directory not found: $BACKUP_DIR"
  exit 1
fi

echo "Starting Docker container restore process..."

# Loop through container backups
for CONTAINER_BACKUP in $BACKUP_DIR/*_container.tar; do
  # Extract container name from backup filename
  CONTAINER_NAME=$(basename $CONTAINER_BACKUP _container.tar)

  echo "Restoring container: $CONTAINER_NAME"

  # Restore container image
  IMAGE_BACKUP="$BACKUP_DIR/${CONTAINER_NAME}_image.tar"
  if [ -f "$IMAGE_BACKUP" ]; then
    echo "  - Loading container image from $IMAGE_BACKUP"
    docker load -i $IMAGE_BACKUP
  else
    echo "  - Image backup not found for $CONTAINER_NAME. Skipping."
  fi

  # Restore container filesystem
  echo "  - Creating new container from filesystem backup"
  docker import $CONTAINER_BACKUP $CONTAINER_NAME:restored

  # Restore volumes
  VOLUME_BACKUPS=$(ls $BACKUP_DIR/${CONTAINER_NAME}_*_volume.tar.gz 2>/dev/null)
  if [ -z "$VOLUME_BACKUPS" ]; then
    echo "  - No volumes found for $CONTAINER_NAME."
  else
    for VOLUME_BACKUP in $VOLUME_BACKUPS; do
      VOLUME_NAME=$(basename $VOLUME_BACKUP _volume.tar.gz)
      RESTORE_PATH="/var/lib/docker/volumes/${VOLUME_NAME}/_data"
      echo "  - Restoring volume $VOLUME_NAME to $RESTORE_PATH"

      # Ensure destination directory exists
      mkdir -p $RESTORE_PATH

      # Extract volume backup
      tar -xzvf $VOLUME_BACKUP -C $RESTORE_PATH
    done
  fi

  # Start restored container
  echo "  - Starting restored container: $CONTAINER_NAME"
  docker run -d --name $CONTAINER_NAME $CONTAINER_NAME:restored
done

echo "Restore process complete."

