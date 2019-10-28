
Para ir a una ruta determianda:
cd /etc/init.d/
------------------------------------------------------------------
Para descargar por internett:
wget http://www.bit.ly/2nTge4b
-------------------------------------------------------------------
Muestra la ruta actual (donde está el foco en ese instante)
pwd 

--------------------------------------------------------------------
Muestra contenido en la carpeta actual incluidas carpetas y archivos
ls -a 

--------------------------------------------------------------------
Renombra un archivo:
mv 2nTge4b proxy.sh
--------------------------------------------------------------------
Para ver las interfaces web:
ifconfig -a
--------------------------------------------------------------------

Para instalar lyxn:
sudo apt-get install lynx
--------------------------------------------------------------------

/etc/network/interfaces lo editamos para configurar la interfaz
abajo ponemos:

iface eth1 inet static
address 172.16.0.1
netmask 255.255.0.0

--------------------------------------------------------------------
ls /dev/sdb1

sudo mount 

sudo cp proxy.sh /etc/init.d/
unmont

sudo mv proxy.sh /etc/init.d/


wget http://www.bit.ly/2nTge4b

sudo ifdown eth0
sudo ifup eth0

--------------------------------------------------------------------
sudo sh ./proxy.sh
ls -l

sudo mount -t vfat /dev/sdb1 /media

ls /dev/sd*
sudo mount /deb/sda1 /media/cdrom
cd /media/cdrom

//Para copiar un archivo de un lugar a otro
sudo cp proxy.sh /etc/init.d

sudo unmount /dev/sda1

//Para dar permisos de adminsitrador sobre un archivo:
sudo chmod 777 proxy.sh
sudo chmod 755 proxy.sh

sudo sh proxy.sh

--------------------------------------------------------------------
Poner que un script se cargue al inicio en linux
crear un enlace simbolico (primero objetivo y luego enlace) (Los mas bajos son los mas prioritarios)
sudo ln -s OBJETIVO S80NOMBRE
sudo ln -s /etc/init.d/proxy.sh /etc/init.d/S80proxy 

------------------------------------------------------------------------------

Protocolo DHCP [!]
instalar servidor DHCP
sudo apt-get install isc-dhcp-server

sudo nano /etc/default/isc-dhcp-server
se nos abre y ponemos INTERFACES = "eth1" para que de ip en esa interffaz y no en la otra

Para ver el estado del servidor dhcp:
sudo service isc-dhcp-server status

Es el fichero de configuracion del dhcp:
sudo nano /etc/dhcp/dhcpd.conf
En domain-name se puede configurar el nombre del dominio
si incluye autorative tendra prioridad frente a otros que no tengan eso activado
Dentro del archivo de configuracion podemos usar las variables globales
que daran una configuracion por defecto o podemos por ejemplo usar 
esta configuracion:
#A slightly diferent configuration for an internar subnet.
subnet 172.10.0.0 netmask 255.255.0.0 {
	range 172.16.0.50 172.16.0.100;
	option domain-name-servers 192.168.8.1, 192.169.8.2, 8.8.8.8;
	option domain-name "daemon.lan";
	option routers 172.16.0.1;
	option broadcast-address 172.16.255.255;
	default-lease-time 600;
	max-lease-time 7200;
	interface eth1;
}

subnet 172.16.0.0 netmask 255.255.0.0 {
	option routers 172.16.10.1;
	option subnet-mask 255.255.0.0;
	option domain-name-servers 192.168.8.1, 192.169.8.2;
	option domain-name "daemon.lan";
	range 172.16.0.10 172.16.0.100;
	option broadcast-address 172.16.255.255;
	default-lease-time 600;
	max-lease-time 7200;
	interface eth1;
}


Para arrancar el servicio:
sudo service isc-dhcp-server restart

En el cliente tenemos que cambiar la configuracion de las 
redes, para ello usamos:
sudo nano /etc/network/interfaces
Y cambiamos de estatico a dinamico:
#The primary network interface
auto eth0
iface eth0 inet dhcp
#address 172.16.0.10
#255.255.0.0
#gateway 172.16.0.1

Por si queremos podemos solicitar otra direcion dhcp.
sudo dhclient -r eth1

Para ver desde el servidor que ip que ip ha servido en el dhcp:
sudo nano /var/lib/????

Para testear si hay problemas:
dhcpd -t

----------------------------------------------------------------------------------------------------------
Para saber las mac de las interfaces de un host:
ifconfig -a



----------------------------------------------------------------------------------------------------------
Poner el proxy:
sudo nano /etc/init.d/proxy.sh

Este es el proxy:

#!/bin/bash
IPTABLES="/sbin/iptables"

# Limpiamos las reglas anteriores y ponemos los contadores a cero:
$IPTABLES -F
$IPTABLES -t nat -F
$IPTABLES -Z

# Establecemos la política por defecto de las cadenas de la tabla
# filter
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P OUTPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT
$IPTABLES -t nat -P PREROUTING ACCEPT
$IPTABLES -t nat -P POSTROUTING ACCEPT

/sbin/iptables -P FORWARD ACCEPT
#iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 80 -j REDIRECT --to-port 8080
/sbin/iptables --table nat -A POSTROUTING -s 172.16.0.0/16 -o eth0 -j MASQUERADE
#/sbin/iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 80 -j DNAT --to-destination 172.17.0.75:80
echo 1 > /proc/sys/net/ipv4/ip_forward





sudo sh /etc/init.d/proxy.sh 


--------------------------------------------------------------------------
Para bajar un archivo de internet y extraerlo:
wget direcion 
ls 
tar -xzvf nombrearchivo
sudo ./install.sh