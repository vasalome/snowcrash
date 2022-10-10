# Level09: Find My Hash

> login:password -> *`level09:25749xKZ8L7DkSCwJkT9dyv6f`*
```
:~$ su level09
Password:25749xKZ8L7DkSCwJkT9dyv6f
```
---

```
:~$ pwd
/home/user/level09
```

```
:~$ ls -la
...
-rwsr-sr-x 1 flag09  level09 7640 Mar  5  2016 level09
----r--r-- 1 flag09  level09   26 Mar  5  2016 token
...
```

Le Home contient un binaire et un fichier token :

```
:~$ ./level09
You need to provied only one arg.

:~$ ./level09 token
tpmhr

:~$ cat token
f4kmm6p|=�p�n��DB�Du{��

:~$ ./level09 token
tpmhr
```

On remarque que le binaire semble effectuer un hashage sur l'élément en paramétre. Pour mieux le comprendre on peux procéder à plusieurs tests:

```
:~$ ./level09 test
tfuw
:~$ ./level09 abc
ace
:~$ ./level09 a
a
:~$ ./level09 aa
ab
:~$ ./level09 aaaaa
abcde
:~$ ./level09 11111
12345
```

Dés lors, on remarque facilement le schema réalisé par le hashage. Il se contente uniquement de prendre chaque caractère de la string à un un, mais l'affiche en lui ajoutant son index.\
Ainsi dans le dernière exemple :
> `1` en position [0] => 1 + 0 = 1\
> `1` en position [1] => 1 + 1 = 2\
> `1` en position [2] => 1 + 2 = 3\
> `1` en position [3] => 1 + 3 = 4\
> `1` en position [4] => 1 + 4 = 5

Nous allons donc pouvoir faire un programme qui va décoder notre `token`

> Par exemple en créant en C, un fichier `decode.c` comme ci-dessous :
```
#include <stdio.h>

int main(int ac, char **av) {
  int i = 0;
  char c;
  while (av[1][i] != 0) {
    c = av[1][i];
    printf("%c", (c - i));
    i++;
  }
  printf("\n");
  return 0;
}
```

Maintenant on peux le compiler puis exécuter notre binaire issue de `decode.c` avec le `token`

```
:~$ scp -P 4242 level09@192.168.56.101:/home/user/level09/token .
Password:25749xKZ8L7DkSCwJkT9dyv6f
token

:~$ chmod 777 token

:~$ gcc decode.c

:~$ ./a.out `cat token`
f3iji1ju5yuevaus41q1afiuq
```

Le fichier `token` a pu être lu par notre binaire, il nous suffit maintenant de nous connecter sur l'user `flag09` avec le résultat obtenu puis de lancer un `getflag`

```
:~$ su flag09
Password:
Don't forget to launch getflag !

:~$ getflag
Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
```

Le flag nous permet de se connecter au level10
`level10:s5cAJpM8ev6XHw998pRWG728z`