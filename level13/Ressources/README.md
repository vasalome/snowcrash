# Level11

> login:password -> *`level13:g1qKMiRpXf53AWhDaU7FEkczr`*
```
:~$ su level13
Password:g1qKMiRpXf53AWhDaU7FEkczr
```
---

```
:~$ pwd
/home/user/level13
```

```
:~$ ls -la
...
-rwsr-sr-x 1 flag13  level13 7303 Aug 30  2015 level13
...
```

Le Home de l'user level13 contient un binaire du même nom :

```
:~$ ./level13
UID 2013 started us but we we expect 4242
```

On remqarque que l'usage attend un UID `4242`.
On vérifiant avec la commande `cat /etc/passwd`, on comprends que notre UID est `2013` et qu'aucun user ne possède l'UID 4242.

En utilisant la commande `gdb -q`, puis `disas main` une fois gdb lancé, on va pouvoir l'analyser et modifier son fonctionnement et ses valeurs en cours d'exécution :

```
:~$ gdb -q ./level13
Reading symbols from /home/user/level13/level13...(no debugging symbols found)...done.
(gdb) disas main
Dump of assembler code for function main:
  0x0804858c <+0>:		push   %ebp
  0x0804858d <+1>:		mov    %esp,%ebp
  0x0804858f <+3>:		and    $0xfffffff0,%esp
  0x08048592 <+6>:		sub    $0x10,%esp
  0x08048595 <+9>:		call   0x8048380 <getuid@plt>
  0x0804859a <+14>:	cmp    $0x1092,%eax
  0x0804859f <+19>:	je     0x80485cb <main+63>
  0x080485a1 <+21>:	call   0x8048380 <getuid@plt>
  0x080485a6 <+26>:	mov    $0x80486c8,%edx
  0x080485ab <+31>:	movl   $0x1092,0x8(%esp)
  0x080485b3 <+39>:	mov    %eax,0x4(%esp)
  0x080485b7 <+43>:	mov    %edx,(%esp)
  0x080485ba <+46>:	call   0x8048360 <printf@plt>
  0x080485bf <+51>:	movl   $0x1,(%esp)
  0x080485c6 <+58>:	call   0x80483a0 <exit@plt>
  0x080485cb <+63>:	movl   $0x80486ef,(%esp)
  0x080485d2 <+70>:	call   0x8048474 <ft_des>
  0x080485d7 <+75>:	mov    $0x8048709,%edx
  0x080485dc <+80>:	mov    %eax,0x4(%esp)
  0x080485e0 <+84>:	mov    %edx,(%esp)
  0x080485e3 <+87>:	call   0x8048360 <printf@plt>
  0x080485e8 <+92>:	leave
  0x080485e9 <+93>:	ret
End of assembler dump.
```

Puis le desassemble pour comprendre et définir ses actions

```
(gdb) b *main+14 (ici on met un Breakpoint sur l'adresse 0x0804859a)
Breakpoint 1 at 0x0804859a

(gdb) run (ici on lance l'exécutable qui prendra fin au Breakpoint)
Starting program: /home/user/level13/level13

Breakpoint 1, 0x0804859a in main ()

(gdb) print $eax (ici on affiche la valeur de eax)
$1 = 2013
```
La valeur de eax (2013) est celle de notre UID.\
Il nous suffit donc de la modifier ici par celle attendu par notre programme -> `4242`.

```
(gdb) set $eax=4242 (ici on modifie la valeur de eax)

(gdb) print $eax
$2 = 4242

(gdb) continue (ici on poursuit l'exécution du programme)
Continuing.
your token is 2A31L79asukciNyi8uppkEuSx
[Inferior 1 (process 2632) exited with code 050]

(gdb) quit
```

Le flag nous permet de se connecter au level14
`level14:2A31L79asukciNyi8uppkEuSx`