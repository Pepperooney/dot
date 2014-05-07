#!/usr/bin/zsh

atv="/etc/nginx/sites-enabled/appletv"
ip="$1"

hog_ip="22c9:d0ff:fe8a:640d"
hog_key="3hum3KnQEzWGAtTt"

range="$(echo "$ip" | cut -d: -f-4)"

# nginx
sed -i "s/^.*HOME$/  allow                 $range::\/64; # HOME/" "$atv"
sudo service nginx restart

# hog
curl -6kso /dev/null "https://hog.erde.lu:$hog_key@dyn.dns.he.net/nic/update?hostname=hog.erde.lu&myip=$range:$hog_ip"
