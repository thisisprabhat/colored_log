import 'dart:convert';

import 'package:colored_log/colored_log.dart';

void main() {
  // Red-colored text
  // name is optional
  ColoredLog.red(
    "This is a red log message.\n",
    name: 'Red Log',
  );

  // Custom background color
  ColoredLog.black(
    "This log has a green background.\n",
    background: LogColor.green,
  );

  // Bold yellow text
  ColoredLog.yellow(
    "This log is bold and yellow.\n",
    style: LogStyle.bold,
  );

  // Italicized
  ColoredLog(
    "This log is italicized and underlined.",
    style: LogStyle.italicized,
  );

  //Auto Coloring based on value type
  ColoredLog(true, name: 'Bool');
  ColoredLog('Hello World', name: 'String');
  ColoredLog(5342.44, name: 'Num');
  ColoredLog(null, name: 'Null');

  // Blinking text
  ColoredLog.red(
    "This is a blinking log!\n",
    name: 'Rapid Blinking Text',
    style: LogStyle.blinkRapid,
  );

  // It formats json and prints in colored format
  ColoredLog(jsonDecode(jsonString), name: 'Json Object');
}

final jsonString =
    '''{"id":1,"title":"Essence Mascara Lash Princess","description":"The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects.","price":9.99,"tags":["beauty","mascara"],"thumbnail":"https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png","isSaved":false,"location":null}''';
