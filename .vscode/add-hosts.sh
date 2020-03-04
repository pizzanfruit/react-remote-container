#!/bin/sh

tmp=$(mktemp);

cat /etc/hosts > $tmp;

for hostpair in ${@}; do
    name=${hostpair%%:*}
    host=${hostpair##*:}

    ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $name)

    if [ -n "$ip" ]; then
        sed -i $tmp -e "/ $host\$/ d;"

        echo "${ip} ${host}" >> $tmp
    fi
done

cat $tmp > /etc/hosts;
rm $tmp;
