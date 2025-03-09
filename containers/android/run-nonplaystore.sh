#!/bin/sh

mkdir -p $HOME/Android/Sdk/cmdline-tools
cd $HOME/Android/Sdk/cmdline-tools
# wget https://dl.google.com/android/repository/commandlinetools-linux-11076708.zip
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-*.zip
rm commandlinetools-linux-*.zip
mv cmdline-tools latest
cd -

echo reset your shell

# Define the VM name
VM_NAME="Pixel-8a-API-35-x86"

# Check if the VM already exists
if avdmanager list avd | grep -q "^Name: $VM_NAME$"; then
  echo "The VM '$VM_NAME' already exists. Skipping creation."
else
  echo "The VM '$VM_NAME' does not exist. Creating it now..."
  # Create the VM
  avdmanager create avd -n "$VM_NAME" -k "system-images;android-35;google_apis;x86_64" -d "pixel_8a"
  if [ $? -eq 0 ]; then
    echo "The VM '$VM_NAME' was successfully created."
  else
    echo "Failed to create the VM '$VM_NAME'. Exiting."
    exit 1
  fi
fi

echo "Press Enter to continue..."
read

# Start the VM
echo "Starting the VM '$VM_NAME'..."
emulator -avd "$VM_NAME" -writable-system -http-proxy 192.168.10.40:8081


exit 0

#!/bin/sh

VM_NAME=Pixel-8a-API-35-x86

avdmanager list avd

avdmanager create avd -n Pixel-8a-API-35-x86 -k "system-images;android-35;google_apis;x86_64" -d "pixel_8a"

emulator -avd Pixel-8a-API-35-x86 -writable-system -http-proxy 192.168.10.40:8081

echo adb root
echo emulator -list-avds

exit 0
