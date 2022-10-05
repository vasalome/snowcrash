# Level01

> login:password -> *`level01:x24ti5gi3x0ol2eh4esiuxias`*
```
:~$ su level01
Password:x24ti5gi3x0ol2eh4esiuxias
```
---

```
:~$ pwd
/home/user/level01
```

```
:~$ ls -la
dr-x------ 1 level01 level01  100 Mar  5  2016 .
d--x--x--x 1 root    users    340 Aug 30  2015 ..
-r-x------ 1 level01 level01  220 Apr  3  2012 .bash_logout
-r-x------ 1 level01 level01 3518 Aug 30  2015 .bashrc
-r-x------ 1 level01 level01  675 Apr  3  2012 .profile
```

Le Home est vide et ne contient aucun fichier inhabituel. 

```
:~$ find / -user level01
... (Permission denied)
:~$ find / -user flag01
... (Permission denied)
```

On remarque que l'user possède beaucoup de fichier dont il n'a pas les droits.\
On se dirige sur la racine. On va chercher un ou des ficher(s) sur lequel l'user level01 ou flag00 aura des droits.

```
:~$ ls -l /etc/passwd
-rw-r--r-- 1 root root  2477 Mar  5  2016 /etc/passwd
```

```
:~$ cat /etc/passwd
...
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
...
```

Après une petite recherche, on va casser le mot de passe avec *`John The Ripper`* (JtR). Pour se faire, je vais d'abord créer un fichier contenant mon `login:[mot de passe à casser]`, puis lancer John à sa poursuite !

```
:~$ echo "flag01:42hDRfypTqqnw" > passwd
:~$ john --show passwd
flag01:abcdefg

1 password hash cracked, 0 left
```

On se connecte ensuite à flag01, puis on lance `getflag`

```
:~$ su flag01
Password:abcdefg
Don't forget to launch getflag !

:~$ getflag
Check flag.Here is your token : f2av5il02puano7naaf6adaaf
```

Le flag nous permet de se connecter au level02
`level02:f2av5il02puano7naaf6adaaf`

> Tools:
> - https://www.openwall.com/john/