import 'package:colored_log/colored_log.dart';
import 'package:dio/dio.dart';

import 'models/name_id.dart';
import 'models/product.dart';

void main() async {
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
  ColoredLog(product.toMap(), name: 'Json Object');

  print('');

  // It formats object and prints in colored format
  // if toString() is overriden and formated in correct way
  ColoredLog(product, name: 'Product Object', color: LogColor.yellow);

  print('');

  //Adding  Dio Interceptors
  Dio dio = Dio();
  dio.interceptors.add(ColoredLogDioInterceptor(showCurl: true));

  // Performing a dio request
  await dio.get(
    'https://dummyjson.com/products/1',
    queryParameters: {'query': 'testquery'},
    data: {'status': 'active'},
    options: Options(headers: {"Content-Type": "application/json"}),
  );

  print('');
}

Product product = Product(
  id: 1,
  name: 'One Plus Nord 4',
  description: '8GB 256 variant',
  price: 20000.0,
  available: 39384,
  isAvailable: true,
  status: 'active',
  category: NameId(
    id: 343,
    name: 'smartphone',
  ),
);
