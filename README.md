# Mariadb-Galera-Init-Script

This is for setting up a Mariadb Galera on Ubuntu 16.04 much easier. Althought it still need quite a lot of manual work for changing settings.

## Step 1:
Git this repo(duh!)

## Step 2:
CD into the directory, chmod +x all sh files.

## Step 3:
Run ADD_RPM first, then Auto_port, after that run Install_mariadb, follow promts that show up.
For all 3 steps above, do it on all nodes.

## Step 4:
Stop mariadb on all nodes
Change setting file on each node. It is located at /etc/mysql/my.cnf
Setting that needed to be changed:
`BIND_ADDRESS = 0.0.0.0`
Scroll to almost bottom, change setting accordingly
```
    wsrep_on=ON
    wsrep_provider=/usr/lib/galera/libgalera_smm.so
    wsrep_cluster_address="gcomm://<node 1 ip>,<node 2 ip>,<node x ip>" # All ip except the one you are changing cnf
    binlog_format=row
    default_storage_engine=InnoDB
    innodb_autoinc_lock_mode=2
```

## Step 5:
Run galera_new_cluster ON THE FIRST NODE ONLY!
Then just run `service mariadb start` on all nodes.

## Step 6(optional):
To test if this working run `SHOW GLOBAL STATUS LIKE 'wsrep_cluster_size';` when you login to mysql. If it is succeed, you will see the numbers of nodes you set up.
To test further more, run `CREATE DATABASE test`, and go to other nodes login into mysql, then run `SHOW DATABASES`, if you see `test`, then you are good to go.
