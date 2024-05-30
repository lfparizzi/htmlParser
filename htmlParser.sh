#!/bin/bash
if ["$1" == ""]
then
        echo "SCRIPT PARSER - HTML MODIFICADO"
        echo "Modo de uso: sudo $0 IP PORTA" #usar com sudo
else
#abrindo a porta 1337:
#### antiga parte do código para realizar um port knocking
#portas_secretas_acesso=('13' '37' '30000' '3000')
#for porta in "${portas_secretas_acesso[@]}"
#do
#        echo "knocking na porta: "$porta" do IP: "$1
#        hping3 -c 1 -p $porta -S $1 1> /dev/null
#done

#puxa o index.html
wget $1:$2
chown kali:kali index.html
sleep 2
grep "href" index.html | grep "//" | cut -d "/" -f 3 | cut -d '"' -f 1 > dominios.txt
chown kali:kali dominios.txt

#verifica os ips de cada referência da página
for url in $(cat dominios.txt)
do
        host $url | grep "has address" #aqui ele vai puxar o IP de cada subdomínio
done
fi
