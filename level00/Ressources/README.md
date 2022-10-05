# Level00

```
ℹ️ Astuce - Se connecter à la VM en local

Utilisez une connection ssh :
:~$ ssh XXX.XXX.XX.XXX -p 4242

Par exemple: 
:~$ ssh 192.168.56.101 -p 4242 -l level00
```

> login:password -> *`level00:level00`*
```
:~$ su level00
Password:level00
```
---

```
:~$ pwd
/home/user/level00
```

```
:~$ ls -la
dr-xr-x---+ 1 level00 level00  100 Mar  5  2016 .
d--x--x--x  1 root    users    340 Aug 30  2015 ..
-r-xr-x---+ 1 level00 level00  220 Apr  3  2012 .bash_logout
-r-xr-x---+ 1 level00 level00 3518 Aug 30  2015 .bashrc
```

Le Home est vide et ne contient aucun fichier inhabituel. L'user level00 ne possède pas beaucoup de droits sur la racine. On va chercher un ou des ficher(s) sur lequel l'user level00 ou flag00 aura des droits.

```
:~$ find / -group flag00  2> /tmp/test
/usr/sbin/john
/rofs/usr/sbin/john
```

```
:~$ cat /usr/sbin/john
cdiiddwpgswtgt
```

```
:~$ cat /rofs/usr/sbin/john
cdiiddwpgswtgt
```
( *rofs est une copie de l'iso en readonly* )

En lui appliquant un ROT15, on obtient *`nottoohardhere`*, il ne manque plus qu'à récupérer le flag en se connectant sur *`flag00`*

`flag00:nottoohardhere`
```
:~$ su flag00
Password:nottoohardhere
Don't forget to launch getflag !

:~$ getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
```

Le flag nous permet de se connecter au level01
`level01:x24ti5gi3x0ol2eh4esiuxias`

> Tools:
> - https://www.dcode.fr/chiffre-cesar