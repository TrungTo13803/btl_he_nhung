#!/bin/bash

# Navigate to the project root
cd $(dirname $(dirname $0)) || exit 1

# Check if the MQTT container is running
container_name="mqtt_broker"
if ! docker ps --format "{{.Names}}" | grep -q "^$container_name\$"; then
  echo "Container $container_name is not running."
  exit 1
fi

# Prompt for user input
read -p "Enter MQTT Username: " username
read -s -p "Enter MQTT Password: " password
echo

# Create or update the MQTT user inside the container
docker exec -i $container_name sh -c "
  mosquitto_passwd -b /mosquitto/config/pwfile $username \"$password\"
"

# Check if the command succeeded
if [ $? -eq 0 ]; then
  echo "User $username created or updated successfully."
else
  echo "Failed to create or update user $username."
  exit 1
fi

# Restart the container to apply changes
docker restart $container_name
