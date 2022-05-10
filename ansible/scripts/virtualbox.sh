sudo apt install build-essential dkms linux-headers-$(uname -r) -y
sudo mkdir -p /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom
sudo sh /mnt/cdrom/VBoxLinuxAdditions.run --nox11
