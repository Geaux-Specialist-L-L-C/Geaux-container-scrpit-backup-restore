#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

# Output directory for backups
BACKUP_DIR="./docker_backups"
mkdir -p $BACKUP_DIR

echo "Starting Docker container backup..."

# List all running containers
CONTAINERS=$(docker ps -q)

if [ -z "$CONTAINERS" ]; then
  echo "No running containers found. Exiting."
  exit 0
fi

for CONTAINER_ID in $CONTAINERS; do
  # Get container details
  CONTAINER_NAME=$(docker inspect --format='{{.Name}}' $CONTAINER_ID | sed 's|/||g')
  IMAGE_NAME=$(docker inspect --format='{{.Config.Image}}' $CONTAINER_ID)
  
  echo "Backing up container: $CONTAINER_NAME ($CONTAINER_ID)"

  # Export container data
  CONTAINER_EXPORT="$BACKUP_DIR/${CONTAINER_NAME}_container.tar"
  echo "  - Exporting container filesystem to $CONTAINER_EXPORT"
  docker export $CONTAINER_ID > $CONTAINER_EXPORT

  # Save container image
  IMAGE_EXPORT="$BACKUP_DIR/${CONTAINER_NAME}_image.tar"
  echo "  - Saving container image to $IMAGE_EXPORT"
  docker save -o $IMAGE_EXPORT $IMAGE_NAME

  # Backup volumes
  VOLUMES=$(docker inspect --format='{{range .Mounts}}{{.Source}} {{end}}' $CONTAINER_ID)
  for VOLUME in $VOLUMES; do
    if [ -d "$VOLUME" ]; then
      VOLUME_NAME=$(basename $VOLUME)
      VOLUME_BACKUP="$BACKUP_DIR/${CONTAINER_NAME}_${VOLUME_NAME}_volume.tar.gz"
      echo "  - Backing up volume $VOLUME to $VOLUME_BACKUP"
      tar -czvf $VOLUME_BACKUP -C $VOLUME .
    fi
  done
done

echo "Backup complete. Files saved in $BACKUP_DIR"

