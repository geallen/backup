#!/bin/bash

ar=/home/cemg/projects/zcloud/containers/

cd $ar

for i in $(ls $ar)
do

if [ -d $i ]
then

cd $i

wait $(sudo docker build -t zetaops/$i --file=$(pwd)/Dockerfile $(pwd))
echo $(pwd)
fi

cd $ar
echo $(pwd)
done

x
