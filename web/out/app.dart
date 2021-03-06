// Auto-generated from index.html.
// DO NOT EDIT.

library index_html;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import 'pages/home.html.dart';
import 'pages/register.html.dart';
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:route/client.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'package:js/js.dart' as js;
import 'dart:json';


// Original code


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
// Additional generated code
void init_autogenerated() {
  var _root = autogenerated.document.body;
  final __html0 = new autogenerated.Element.html('<section is="x-home"></section>'), __html1 = new autogenerated.Element.html('<section is="x-register"></section>');
  var __e1, __e3;
  var __t = new autogenerated.Template(_root);
  __e1 = _root.nodes[1].nodes[3].nodes[1];
  __t.conditional(__e1, () => homeUrl.matches(window.location.pathname), (__t) {
    var __e0;
    __e0 = __html0.clone(true);
    __t.component(new XHome()..host = __e0);
  __t.addAll([new autogenerated.Text('\n          '),
      __e0,
      new autogenerated.Text('\n        ')]);
  });

  __e3 = _root.nodes[1].nodes[3].nodes[3];
  __t.conditional(__e3, () => registerUrl.matches(window.location.pathname), (__t) {
    var __e2;
    __e2 = __html1.clone(true);
    __t.component(new XRegister()..host = __e2);
  __t.addAll([new autogenerated.Text('\n          '),
      __e2,
      new autogenerated.Text('\n        ')]);
  });

  __t.create();
  __t.insert();
}

//@ sourceMappingURL=app.dart.map