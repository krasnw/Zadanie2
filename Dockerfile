# do budowy obrazu wybrałem node:14-alpine3.17
FROM node:14-alpine3.17

# zmienna srodowiskowa VERSION z wartoscia domyslna v1.0
ARG VERSION
ENV VERSION=${VERSION:-v1.0}

# etykieta z informacja o autorze
LABEL maintainer="Uladzislau Krasnavitski"

# kopiowanie plikow aplikacji do katalogu /app
WORKDIR /app
COPY src .

# instalacja zaleznosci
RUN npm install

EXPOSE 3000

# monitorowanie dostepnosci serwera 
HEALTHCHECK --interval=4s --timeout=100s --start-period=3s \
    CMD curl -f http://localhost:3000/ || exit 1

# przypisanie komendy uruchamiajacej serwer
ENTRYPOINT ["node", "index.js"]
