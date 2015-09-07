#!/bin/bash

ar=/home/cemg/projects/zcloud/containers/
#find . -name 'Dockerfile' | awk -F/ '{print $(NF-1),$NF}' | cut -d " " -f1
#find . -name "Dockerfile" -exec dirname {} \;

cd $ar

for i in $(find $ar -name "Dockerfile" -exec dirname {} \;)
do

if [ -d $i ]
then
cd $i

image_name=$(pwd | awk -F/ '{print $(NF-1),$NF}' | cut -d " " -f2)
echo "----------------$image_name---------------"
$(sudo docker build -t zetaops/$image_name .) # --file=$(pwd)/Dockerfile $(pwd))

long_image_id=$(sudo docker inspect zetaops/$image_name | grep "Id" | cut -d ":" -f2 | cut -d '"' -f2)
image_id=$(echo $long_image_id | cut -c 1-12)
sudo docker tag $image_id  quay.io/zetaops/$image_name

quay_name=$(sudo docker images | grep quay | awk '{ print $1 }')
docker push $quay_name

fi
done

# git log --name-only --pretty=oneline --full-index HEAD^^..HEAD | grep -vE '^[0-9a-f]{40} ' | sort | uniq
