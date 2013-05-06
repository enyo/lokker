import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:route/client.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'package:js/js.dart' as js;
import 'dart:json';

//import 'app/urls.dart' as urls;


// initial value for click-counter
int startingCount = 5;



final homeUrl = new UrlPattern(r'/');
final registerUrl = new UrlPattern(r'/register');

Map<String, Element> pathElements = { };

Router router;


/**
 * Learn about the Web UI package by visiting
 * http://www.dartlang.org/articles/dart-web-components/.
 */
void main() {
  // Enable this to use Shadow DOM in the browser.
  // useShadowDom = true;


  router = new Router()
      ..addHandler(homeUrl, showPage)
      ..addHandler(registerUrl, showPage)
      ..listen();



  queryAll("nav.main a").forEach((Element element) {
    pathElements[element.attributes["href"]] = element;

    element.onClick.listen((MouseEvent e) {
      e.preventDefault();
      // I have no idea why this isn't necessary...
      // router.gotoPath(element.attributes["href"], element.text);
    });
  });

  js.context.signedIn = new js.Callback.many(signedIn);
  js.context.signedOut = new js.Callback.many(signedOut);

}

void signedIn(js.Proxy profile, js.Proxy authResult) {
  HttpRequest request = new HttpRequest();
  request.open("POST", "/authenticate", async: true);
  request.setRequestHeader("Content-type", "application/json");
  Map data = {
              "access_token": authResult['access_token'],
              "user_id": profile['id']
            };

  request.send(stringify(data));
  // TODO: Actually wait for server feedback and redirct.
}

void signedOut() {

}


void showPage(String path) {
  pathElements.values.forEach((element) { element.parent.classes.remove("active"); });
  pathElements[path].parent.classes.add("active");
  print("Showing $path");
  watchers.dispatch();
}