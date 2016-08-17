# Mariadb-Galera-Init-Script

#Current Mariadb version: 10.1

This helps setting up a Mariadb Galera on Ubuntu 16.04 much easier. Althought it still needs quite a lot of manual work for changing settings.

## Step 1:
Git this repo(duh!)

`git clone https://github.com/tony199555/Mariadb-Galera-Init-Script.git`

## Step 2:
CD into the directory, chmod +x all sh files.

`chmod +x Add_RPM_10-1.sh Auto_port.sh Install-Mariadb.sh`

## Step 3:
Run ADD_RPM first, then Auto_port, after that run Install_mariadb, follow promts that show up. Because it will promt you, it is suggested to run each script separately so you won't miss or misunderstand.

```
./Add_RPM_10-1.sh
./Auto_port.sh
./Install-Mariadb.sh
```

For all 3 steps above, do it on all nodes.

## Step 4:
Stop mariadb on all nodes.

Change setting file on each node. It is located at /etc/mysql/my.cnf

Setting that needed to be changed:

`bind-address = 127.0.0.1` --> `bind-address = 0.0.0.0`

Scroll to almost bottom, change setting accordingly
```INI
wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so
wsrep_cluster_address="gcomm://<node 1 ip>,<node 2 ip>,<node x ip>" # All ip address except this one
binlog_format=row
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
```

## Step 5:
Run `galera_new_cluster` ON THE FIRST NODE ONLY! After you ran the command, run `service mariadb start` on the same node.

Then just run `service mariadb start` on all nodes.

If no error messages show, then the Mariadb Galera is up.

## Step 6(optional):
To test if this working run `SHOW GLOBAL STATUS LIKE 'wsrep_cluster_size';` when you login to mysql. If it is succeed, you will see a number that matchs the number of nodes you set up.

To test further more, run `CREATE DATABASE test`, and go to other nodes login into mysql, then run `SHOW DATABASES`, if you see `test`, then you are good to go.
