library locker_server;

import 'dart:io';

import 'package:route/server.dart';
import 'package:route/pattern.dart';

import "server/routes.dart";


const ADDRESS = "127.0.0.1";
const PORT = 1337;

main() {


  HttpServer.bind(ADDRESS, PORT).then((server) {
    print("Listening on ${server.port}.");
    var router = new Router(server)
//        ..filter(matchesAny(allUrls), authFilter)
        ..serve(urls["static"], method: "GET").listen(staticRoute)
        ..serve(urls["authenticate"], method: "POST").listen(authenticateRoute)
        ..serve(urls["home"], method: "GET").listen(homeRoute);
  });

//  var port = 3000;
//  start(view: null, public: 'web/out', port: port).then((app) {
//    app.get('/', (Request req, Response res) {
//      res.sendFile("web/out/index.html");
//    });
//    print("Listening on port ${port}");
//  });

}