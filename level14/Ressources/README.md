# Level11

> login:password -> *`level14:2A31L79asukciNyi8uppkEuSx`*
```
:~$ su level14
Password:2A31L79asukciNyi8uppkEuSx
```
---

```
:~$ pwd
/home/user/level14
```

```
:~$ ls -la
...
```

On ne trouve absolument rien d'inhabituel sur le Home de l'user level14, donc il faudra surement exploiter directement le binaire `/bin/getflag`. Nous allons pouvoir procéder en utilisant aussi `gdb`, mais cette fois sur getflag.

```
:~$ gdb /bin/getflag
[...]
(gdb) disas main
Dump of assembler code for function main:
[...]
   0x08048989 <+67>:	call   0x8048540 <ptrace@plt>
   0x0804898e <+72>:	test   %eax,%eax
[...]
   0x08048afd <+439>:	call   0x80484b0 <getuid@plt>
   0x08048b02 <+444>:	mov    %eax,0x18(%esp)
[...]
End of assembler dump.

(gdb) b *main+72 (ici on fait un Breakpoint pour remplacer la sortie de ptrace)
Breakpoint 1 at 0x804898e

(gdb) b *main+444 (ici on fait un 2e Breakpoint pour remplacer la valeur de 0x80484b0 par l'UID de flag14 -> 3014)
Breakpoint 2 at 0x8048b02

(gdb) run (ici on relance le programme jusqu'au 1er Breakpoint)
Starting program: /bin/getflag

Breakpoint 1, 0x0804898e in main ()

(gdb) set $eax=0 (ici on remet la valeur de eax à 0)
(gdb) print $eax
$1 = 0 

(gdb) step (ici on relance le programme jusqu'au 2e Breakpoint)
Single stepping until exit from function main,
which has no line number information.

Breakpoint 2, 0x08048b02 in main ()

(gdb) set $eax=3014 (ici on met la valeur de eax au UID du user flag14)
(gdb) print $eax
$2 = 3014

(gdb) step
Single stepping until exit from function main,
which has no line number information.
Check flag.Here is your token : 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
0xb7e454d3 in __libc_start_main () from /lib/i386-linux-gnu/libc.so.6
```

Le dernier flag est donc :
`7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ`