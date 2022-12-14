# Level02: Wireshark

> login:password -> *`level02:f2av5il02puano7naaf6adaaf`*
```
:~$ su level02
Password:f2av5il02puano7naaf6adaaf
```
---

```
:~$ pwd
/home/user/level02
```

```
:~$ ls -la
...
----r--r-- 1 flag02  level02 8302 Aug 30  2015 level02.pcap
...
```

On trouve un fichier *`.pcap`* qui est un fichier de données associé à Wireshark. On télécharge donc le fichier en local pour l'ouvrir avec Wireshark\
(Wireshark est un outil de capture et d'analyse de paquets. Il capture le trafic du réseau local et stocke les données ainsi obtenues)

```
:~$ scp -P 4242 level02@192.168.56.101:/home/user/level02/level02.pcap .
Password:f2av5il02puano7naaf6adaaf
level02.pcap

:~$ chmod 644 level02.pcap
```
En ouvrant le fichier à ligne 43, on trouve `Pas sword:`, ce qui suit sera donc le mot de passe, on va alors l'analyser.\
> Analyse > Follow > TCP Stream

On obtiens alors le résultat : `Password: ft_wandr...NDRel.L0L`.\
A partir de ce résultat, et en sachant que Wireshark affiche les caractères non imprimable par des `.`, on peux comprendre les points correspondent surement à `7f` en ASCII (base 16) soit `DEL` (Delete), qui est donc une suppression du caractères précédent.\
En conclusion, ceci nous donne donc le mot de passe suivant : `ft_waNDReL0L`.\ 

On se connecte ensuite à flag02, puis on lance `getflag`

```
:~$ su flag02
Password:ft_waNDReL0L
Don't forget to launch getflag !

:~$ getflag
Check flag.Here is your token : kooda2puivaav1idi4f57q8iq
```

Le flag nous permet de se connecter au level03
`level03:kooda2puivaav1idi4f57q8iq`

> Tools:
> - https://www.reviversoft.com/fr/file-extensions/pcap
> - https://supersonique-studio.com/2011/11/code-de-controle-ascii-utiles-cr-lf-vt-etc/
> - https://fr.wikibooks.org/wiki/Les_ASCII_de_0_%C3%A0_127/La_table_ASCII