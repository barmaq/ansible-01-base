#!/bin/bash
#переменные
CONTAINERS=("fedora" "centos7" "ubuntu")
IMAGES=("pycontribs/fedora:latest" "pycontribs/centos:7" "pycontribs/ubuntu:latest")

ANSIBLE_PLAYBOOK="./site.yml"
INVENTORY="./inventory/prod.yml"

#запускаем контейнеры
for i in "${!CONTAINERS[@]}"; do
        docker run -dit --name "${CONTAINERS[$i]}" "${IMAGES[$i]}" sleep 6000000
        echo "поднимаем контейнер: $container"
done

#применяем плейбук
ansible-playbook "$ANSIBLE_PLAYBOOK" -i "$INVENTORY" --ask-vault-pass

#останавливаем и удаляем контейнеры
for container in "${CONTAINERS[@]}"; do
    echo "Останавливаем контейнер: $container"
    sudo docker stop "$container"
    echo "Удалям контейнер: $container"
    sudo docker rm "$container"
done
