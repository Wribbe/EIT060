#!/bin/bash

server_name="server"
client_name="client"

port=1234

javac ${server_name}.java
javac ${client_name}.java

rm -rf run_env
mkdir run_env

mv ${server_name}.class run_env 
mv ${client_name}.class run_env

cp stores/* run_env

cd run_env

mate-terminal -x java "$server_name" $port 
mate-terminal -x java "$client_name" localhost $port 
