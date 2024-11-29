#!/bin/bash
#переменные
CONTAINERS=("fedora" "centos7" "ubuntu")
IMAGES=("pycontribs/fedora:latest" "pycontribs/centos:7" "pycontribs/ubuntu:latest")

ANSIBLE_PLAYBOOK="/home/barmaq/ansible/ansible-01-base/playbook/site.yml"
INVENTORY="/home/barmaq/ansible/ansible-01-base/playbook/inventory/prod.yml"

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
