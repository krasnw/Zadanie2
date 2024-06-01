const http = require('http');
var geoip = require('geoip-lite');

const authorName = "Uladzislau Krasnavitski";
const serverPort = process.env.PORT || 3000;

console.log(`Start date: ${new Date().toLocaleString()}, Author: ${authorName}, Port: ${serverPort}`);

http.createServer((req, res) => {
    let clientIP = req.connection.remoteAddress;
    if (clientIP.substr(0, 7) == "::ffff:") {
    clientIP = clientIP.substr(7)
    }

    // do wyliczenia strefy czasowej i kraju wykorzystuje biblioteke geoip-lite
    var geo = geoip.lookup(clientIP);
    var country = geo ? geo.country : "None";
    var timeZone = geo ? geo.timezone : "None";

    // kiedy aplikacja uruchomiona jest lokalnie, nie jest możliwe określenie kraju i strefy czasowej,
    // bo IP adres też jest lokalny
    if (country == "None" || timeZone == "None") {
        res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' });
        res.write(`IP: ${clientIP}\nNie udało się określić kraju i strefy czasowej. Bo aplikacja uruchomiona jest lokalnie.`);
        res.end();
    } else {
        res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' });
        res.write(`IP: ${clientIP}\nPaństwo: ${country}\nTimezone: ${timeZone}`);
        res.end();
    }
}).listen(serverPort);