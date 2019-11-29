# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
#	COMANDOS GENERALES:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 


# - - - - - Para Apagar o reiniciar nuestro equipo:
	#	[!] Para apagar el equipo:
	sudo shutdown -h now
	#	[!] Para reiniciar el equipo:
	sudo reboot


# - - - - - Comandos para navegar por el explorador de archivos. Para moverse por las carpetas de nuestro equipo:
	#	[!] Para ir a una ruta determinada:
	cd /etc/init.d/
	#	[!] Muestra contenido en la carpeta actual 
	ls
	#	Muestra contenido en la carpeta actual (incluidas carpetas y archivos)
	ls -a 
	#	Muestra contenido en la carpeta actual en un listado
	ls -l
	#	Muestra contenido en la carpeta actual (incluyendo archivos ocultos)
	ls -laxo
	#   Muestra contenido en la carpeta actual pero filtrando por tipo de archivo que indiquemos
	ls *.txt
	#	[!] Muestra la ruta actual (donde está el foco en ese momento)
	pwd 


# - - - - - Para Crear, Copiar, Eliminar, Renombrar, Cortar archivos o carpetas:
	#   Para crear una carpeta en la ruta donde estamos:
	mkdir NombreCarpeta
	#   Para eliminar una carpeta y su contenido:
	rmdir NombreCarpeta
	#	[!] Para eliminar un archivo (pero no una carpeta) (Si necesita permiso añada "sudo" delante de "rm")
	rm nombrearchivo.extensionarchivo
	#	Para eliminar un archivo o carpeta y todas sus subcarpetas:
	rm -r nombrearchivo
	#	Renombra un archivo o moverlo a una ruta nueva:
	mv nombreantiguo.extension nuevonombre.extension
	mv nombreantiguo.extension ruta
	#	Para copiar un archivo de un lugar a otro:
	sudo cp proxy.sh /etc/init.d
	#	Para eliminar todos los archivos de la carpeta actual:
	sudo rm *
	#	Para eliminar todos los archivos de la carpeta actual incluyendo archivos y subcarpetas:
	sudo rm *

# - - - - - Guardar salida en un fichero de texto:
	#	Guardar salida en un fichero de texto:
	#	1. Usando: >
	#   No se mostrará en la terminal. Si el archivo existe, se sobrescribirá. 
	#	Sintaxis:
	COMANDO > NOMBREARCHIVO.EXTENSION
	# Ejemplo:
	history 1000 > listaComandos.txt 
	#	2. Usando: >>
	#   No se mostrará en la terminal. Si el archivo existe, se escribirá al final. 
	#	Sintaxis:
	COMANDO > NOMBREARCHIVO.EXTENSION
	# Ejemplo:
	history 1000 >> listaComandos.txt 


# - - - - - Para ver los últimos comandos usados en la terminal:
	#	[!] Para ver los últimos comandos usados en la terminal (el numero indica la cantidad de comandos que queremos mostrar):
	history 20


# - - - - - Configuracion de la Red. Para configurar la red de nuestro equipo:
	#	[!] Para ver informacion de las interfaces de red:
	ifconfig 
	#	Para ver informacion completa de las interfaces de red (Muy util tambien para saber las MAC de las interfaces de red):
	ifconfig -a
	#	Para desactivar una interfaz de red determinada:
	sudo ifdown eth0
	#	Para activar una interfaz de red determinada:
	sudo ifup eth0
	#	[!] Para configurar las interfaces de red: 
	#	Se debe editar para ello el archivo localizado en: /etc/network/interfaces 
	sudo nano /etc/network/interfaces
	#	Dentro de este archivo podemos configurar por ejemplo:
	#	1. Que nuestra red obtenga dir IP de un servidor DHCP.
	#	Si queremos una configuracion de una interfaz para que trabaje
	#	por DHCP y se asigne automatica la dir. IP dentro del documento escribimos:
	#	Eth0 lo debemos sustituir por la interfaz que deseemos
	auto eth0
	iface eth0 inet dhcp
	#	2. Que nuestra red tenga una dir IP fija dada por la direccion que indiquemos.
	#	Si queremos una asignacion estática dentro del documento escribimos (igualmente eth1 lo cambiamos por la interfaz que queremos configurar):
	iface eth1 inet static
	address 172.16.0.1
	netmask 255.255.0.0


# - - - - - Para descargar un archivo:
	#	[!] Para descargar un archivo:
	wget ruta
	#	Ejemplo:
	wget http://www.bit.ly/2nTge4b


# - - - - - Para instalar el navegador por terminar lynx:
	#	[!] Para instalar lyxn:
	sudo apt-get install lynx


# - - - - - Para montar particiones:
#	[POR PROBAR] Para montar particiones:
	sudo mount


# - - - - - Crear un enlace simbólico (que un proceso se ejecute al arranque del sistema)
#	Crear un enlace simbólico (que un proceso se ejecute al arranque del sistema)
#	Se establece primero el objetivo y luego el enlace. (Los numeros mas bajos son los prioritarios)
#	La sintaxis es esta:
	sudo ln -s RUTA/ARCHIVO.EXTENSION S80NOMBRE
#	Ejemplo:
	sudo ln -s /etc/init.d/proxy.sh /etc/init.d/S80proxy 


# - - - - - Para dar permisos de administrador sobre un archivo
#   Para dar permisos de administrador sobre un archivo
#	(777 establecerá el maximo de los permisos de lectura, escritura y ejecución)
#	Ejemplos:
	sudo chmod 777 proxy.sh
	sudo chmod 755 proxy.sh


# - - - - - Configuracion de un servidor como PROXY
#   Configuracion de un servidor como PROXY
#	1. Creamos en la siguiente ruta este archivo:
	sudo nano /etc/init.d/proxy.sh
#	2. Escribimos dentro de ese archivo el siguiente código:

				#~ !/bin/bash
				IPTABLES="/sbin/iptables"
				#~ Limpiamos las reglas anteriores y ponemos los contadores a cero:
				$IPTABLES -F
				$IPTABLES -t nat -F
				$IPTABLES -Z
				#~ Establecemos la política por defecto de las cadenas de la tabla
				#~ filter
				$IPTABLES -P INPUT ACCEPT
				$IPTABLES -P OUTPUT ACCEPT
				$IPTABLES -P FORWARD ACCEPT
				$IPTABLES -t nat -P PREROUTING ACCEPT
				$IPTABLES -t nat -P POSTROUTING ACCEPT
				/sbin/iptables -P FORWARD ACCEPT
				#~iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 80 -j REDIRECT --to-port 8080
				/sbin/iptables --table nat -A POSTROUTING -s 172.16.0.0/16 -o eth0 -j MASQUERADE
				#~/sbin/iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 80 -j DNAT --to-destination 172.17.0.75:80
				echo 1 > /proc/sys/net/ipv4/ip_forward

#	3. Una vez guardado lo anterior para ejecutarlo usaremos
	sudo sh /etc/init.d/proxy.sh 
#	4. Finalmente deberemos incorporarlo en un enlace simbólico
	sudo ln -s /etc/init.d/proxy.sh /etc/init.d/S80proxy 

# - - - - - Instalacion de un servidor DHCP 
#   Instalacion de un servidor DHCP 
#	1. El primer paso es configurar primero las interfaces de red correctamente:
	sudo nano /etc/network/interfaces
#	2. Una vez dentro tenemos que poner una configuracion válida, por ejemplo:
#	Una de las interfaces será por donde se nos sumistrará internet
#	La otra o las otras interfaces de red serán por las cuales se emitirá el protocolo DHCP
	#FALTA PONER AQUI ARCHIVO CONFIGURACION
# 	3. Instalamos el servidor DHCP:
	sudo apt-get install isc-dhcp-server
	sudo nano /etc/default/isc-dhcp-server
#	Para ver el estado del servidor DHCP:
	sudo service isc-dhcp-server status
#	Ejemplo 1 del fichero de configuracion del DHCP:
	sudo nano /etc/dhcp/dhcpd.conf
#	En domain-name se puede configurar el nombre del dominio
#	si incluye autorative tendra prioridad frente a otros que no tengan eso activado
#	Dentro del archivo de configuracion podemos usar las variables globales
#	que daran una configuracion por defecto o podemos por ejemplo usar 
#	esta configuracion:

			#	A slightly diferent configuration for an internar subnet.
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

#	Para arrancar el servicio:
	sudo service isc-dhcp-server restart

#	En el cliente tenemos que cambiar la configuracion de las 
#	redes, para ello usamos:
	sudo nano /etc/network/interfaces
#	Y cambiamos de estatico a dinamico:
	auto eth0
	iface eth0 inet dhcp
#	Por si queremos podemos solicitar otra direcion dhcp.
	sudo dhclient -r eth1
#	Para testear si hay problemas en el script de configuracion DHCP:
	dhcpd -t


# - - - - - COMANDOS PARA DNS:
#	Comandos para DNS
#	[!] Devuelve la ip de esta maquina:
	nslookup nombredominio
#	Instalar un servidor DNS Maestro:
#	1. Antes de nada configura las interfaces de red y el servidor dhcp para que se
#	emita correctamente y no haya problemas con otros servidores de nombres
	sudo nano /etc/network/interfaces
#	2. Instalamos BIND9 y configurar BIND9 para disponer de un servidor DNS en una intranet:
	sudo aptitude install bind9
	cd /etc/bind/
	sudo nano named.conf.local
# 	Editamos named.conf.local:

				zone "nombredeldominio.es" {
					type master;
					file "/etc/bind/db.nombredeldominio";
				};
				zone "17.172.in_addr.arpa" {
					type master;
					file "/etc/bind/db.172";
				};

#	Creamos el fichero de configuración "db.nombredeldominio" a partir de “db.local”:
	cp db.local db.nombredeldominio
#	Editamos “db.nombredeldominio:
	sudo nano db.nombredeldominio
#   reemplazamos la palabra “localhost” pornombredeldominio.homeip.net”, cambiamos la
#   IP “127.0.0.1″ por la que queramos asignar al dominio y añadimos al final
#	del fichero todos los A, MX y CNAME que queramos, quedando:

				; BIND data file for local loopback interface
				$TTL 604800
				@ IN SOA nombredeldominio.es. root.nombredeldominio.es. (
				 2 ; Serial
				 604800 ; Refresh
				 86400 ; Retry
				 2419200 ; Expire
				 604800 ) ; Negative Cache TTL
				;
				@ IN NS nombredeldominio.es.
				@ IN A 172.17.0.1
				dns IN A 172.17.0.1
				www IN A 172.17.0.2
				;mail IN MX 0 192.168.15.4
				ftp IN A 172.17.0.3
				files IN A 172.17.0.4
				;mail IN CNAME mail.nombredeldominio.es.
				;ftp IN CNAME ftp.nombredeldominio.es.
				;files IN CNAME files.nombredeldominio.es.
				;www IN CNAME www.nombredeldominio.es.

#	3. Cada vez que se cambia la configuración de BIND9, debemos reiniciar el demonio:
	/etc/init.d/bind9 restart
#	Para que nuestra máquina utilice el servidor de DNS que hemos configurado,
#	debemos editar “/etc/resolv.conf” y dejamos únicamente la línea:
	nameserver 127.0.0.1
#	Se debería hacer lo mismo con el resto de máquinas de la intranet que vayan a
#	utilizar el servidor, con la única diferencia que habrá que substituir la IP
#	127.0.0.1 por la IP que tenga el servidor en la red.
#	Para comprobar el correcto funcionamiento, utilizamos el comando “host” el
#	cual sirve para resolver dominios:

				$ host marblestation.homeip.net
				marblestation.homeip.net has address 192.168.48.32
				marblestation.homeip.net mail is handled by 0 marblestation.homeip.net.
				$ host saturno.marblestation.homeip.net
				saturno.marblestation.homeip.net is an alias for marblestation.homeip.net.
				marblestation.homeip.net has address 192.168.48.32
				saturno.marblestation.homeip.net is an alias for marblestation.homeip.net.
				saturno.marblestation.homeip.net is an alias for marblestation.homeip.net.
				marblestation.homeip.net mail is handled by 0 marblestation.homeip.net.

# Para iniciar el servidor bin9:
	sudo service bin9 restart
# Para parar el servidor bin9:
	sudo service bin9 stop
# Para ver la carpeta donde se guarda la cache del servidor bin9:
	sudo ls /var/cache/bind
#	Para verificar si esta correcta la configuracion:
named-checkzone nombredeldominio.es db.nombredeldominio
