# Используйте официальный образ Alpine
FROM alpine:3.17

# Установите простой HTTP-сервер для статического контента
RUN apk add --no-cache busybox-extras

# Сделайте порт 3000 доступным для мира за пределами этого контейнера
EXPOSE 3000
