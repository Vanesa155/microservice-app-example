#!/bin/bash

# Crear la red si no existe 
docker network create microservices-network || true

# Construir imágenes
docker build -t redis-image ./redis
docker build -t zipkin-image ./zipkin
docker build -t usersapi-image ./users-api
docker build -t authapi-image ./auth-api
docker build -t todosapi-image ./todos-api
docker build -t frontend-image ./frontend

# Ejecutar contenedores en orden
docker run -d --name redis --network microservices-network -p 6379:6379 redis-image
docker run -d --name zipkin --network microservices-network -p 9411:9411 zipkin-image
docker run -d --name usersapi --network microservices-network -p 8083:8083 usersapi-image
docker run -d --name authapi --network microservices-network -p 8000:8000 authapi-image
docker run -d --name todosapi --network microservices-network -p 8082:8082 todosapi-image
docker run -d --name frontendapi --network microservices-network -p 8080:8080 frontend-image

#Todos estan en una misma red para que se puedan ver