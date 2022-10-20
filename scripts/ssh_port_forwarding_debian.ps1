$wsl_ip = wsl.exe -d Debian -e sh -c "ifconfig eth0 | grep 'inet '"
$found = $wsl_ip -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';
$wsl_ip = $matches[0];
iex "netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0 listenport=2222"
iex "netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=2222 connectaddress=$wsl_ip connectport=2222"
iex "netsh advfirewall firewall add rule name='open port 2222 for wsl2 port fowarding' dir=in action=allow protocol=TCP localport=2222"