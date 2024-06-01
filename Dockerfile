# do budowy obrazu wybrałem node:14-alpine3.17
FROM alpine:3.17

EXPOSE 3000

# monitorowanie dostepnosci serwera 
HEALTHCHECK --interval=4s --timeout=100s --start-period=3s \
    CMD curl -f http://localhost:3000/ || exit 1

# przypisanie komendy uruchamiajacej serwer
ENTRYPOINT ["node", "index.js"]
