#/bin/sh

# # get mac address
# ifconfig en0 | grep ether

# # generate random mac address
# openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'

# # change mac address
# sudo ifconfig en0 ether #<mac-address>

echo "origin MAC address: " `sudo ifconfig en0 ether | grep ether`
sudo ifconfig en0 ether `openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`
echo "new MAC address: " `sudo ifconfig en0 ether | grep ether`