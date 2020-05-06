import 'package:flutter/widgets.dart';


Map<String, WidgetBuilder> allRoutes(){

final Map<String, WidgetBuilder> allRoutes = <String, WidgetBuilder>{

  "/login": (BuildContext context) => null,
  "/register":(BuildContext context) => null,
  "/spashScreen":(BuildContext context) => null,
  "/resetPassword":(BuildContext context) => null,
  "/varificationEmail":(BuildContext context) => null,
  "/pairingScrren":(BuildContext context) => null,
};
return allRoutes;
}
