library urls;

import 'dart:io';
import 'package:route/url_pattern.dart';

final Map<String, UrlPattern> urls = {
      "home": new UrlPattern(r'/([a-z0-9]*)'),
      "authenticate": new UrlPattern(r'/authenticate'),
      "static": new UrlPattern(r'/(.*).(dart|css|js)')
    };


void homeRoute(HttpRequest req) {
  sendFile(req, "index.html");
}

void staticRoute(HttpRequest req) {
  sendFile(req, req.uri.path);
}

// https://developers.google.com/accounts/docs/OAuth2UserAgent#validatetoken
void authenticateRoute(HttpRequest req) {
  req.transform(new StringDecoder()).toList().then((data) {
    var body = data.join('');
    print(body); // = access_token + user_id
    // TODO: Make request to
    // https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=TOKEN
    // and check if the user ID, and audience are ok.
    // audience: 624706025332.apps.googleusercontent.com
  });
}


void sendFile(HttpRequest req, String filename) {
  var file = new File("web/out/$filename");
  file.exists().then((found) {
    if (found) {
      file.openRead().pipe(req.response);
    } else {
      req.response.statusCode = HttpStatus.NOT_FOUND;
      req.response.write("File not found.");
      req.response.close();
    }
  });
}