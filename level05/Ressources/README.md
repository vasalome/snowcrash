# Level05: You have new mail.

> login:password -> *`level05:ne2searoevaevoem4ov4ar8ap`*
```
:~$ su level05
Password:ne2searoevaevoem4ov4ar8ap
```
---

```
:~$ pwd
/home/user/level05
```

```
:~$ ls -la
...
```

Le Home est vide mais on a peu être averti qu'un mail nous attends:

```
:~$ ssh level05@localhost -p 4242
	   _____                      _____               _
	  / ____|                    / ____|             | |
	 | (___  _ __   _____      _| |     _ __ __ _ ___| |__
	  \___ \| '_ \ / _ \ \ /\ / / |    | '__/ _` / __| '_ \
	  ____) | | | | (_) \ V  V /| |____| | | (_| \__ \ | | |
	 |_____/|_| |_|\___/ \_/\_/  \_____|_|  \__,_|___/_| |_|

  Good luck & Have fun

          10.0.2.15
level05@localhost's password:
You have new mail.
```

On va donc essayer de voir ce mail

```
:~$ cat /var/mail/level05
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```

Ce mail nous informe qu'une tache cron est planifié et qu'elle execute le script `/usr/sbin/openarenaserver` toutes les 2min sur le user flag05

```
:~$ cat /usr/sbin/openarenaserver
#!/bin/sh

for i in /opt/openarenaserver/* ; do
	(ulimit -t 5; bash -x "$i")
	rm -f "$i"
done
```

On remarque alors que le script exécute tous les fichiers présents dans `/opt/openarenaserver/` avec `bash`, puis les supprime. Il suffit alors d'y ajouter notre propre script qui exécutera alors la commande `getflag` et conservera son résultat dans un dossier qui lui ne se supprimera pas, par exemple `/tmp/flag`.

```
:~$ echo "getflag > /tmp/flag05" > /opt/openarenaserver/getflag
```

On patiente 2min que cron puisse lancer le script

```
:~$ cat /tmp/flag05
Check flag.Here is your token : viuaaale9huek52boumoomioc
```

Le flag nous permet de se connecter au level06
`level06:viuaaale9huek52boumoomioc`