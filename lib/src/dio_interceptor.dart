import 'dart:convert' show JsonEncoder, jsonEncode;

import 'package:dio/dio.dart'
    show
        Interceptor,
        DioException,
        RequestOptions,
        RequestInterceptorHandler,
        Response,
        FormData,
        ResponseInterceptorHandler,
        ErrorInterceptorHandler;

import '../colored_log.dart';

/// This is an interceptor for dio package
/// - It ColorLogs all request in [Dio]
///
/// Implementation :
/// ```dart
///  Dio dio = Dio();
///  dio.interceptors.add(const ColoredLogDioInterceptor());
/// ...
///
/// ```
/// We can also logs cURLs too: `showCurl:true`
class ColoredLogDioInterceptor extends Interceptor {
  const ColoredLogDioInterceptor({
    this.showRequestHeader = true,
    this.showResponseBody = true,
    this.showError = true,
    this.showCurl = false,
    this.showLog = true,
  });

  /// Print request header [Options.headers]
  final bool showRequestHeader;

  /// Print [Response.data]
  final bool showResponseBody;

  /// Print error message
  final bool showError;

  /// Print request cURL if true
  /// By default it is false
  final bool showCurl;

  /// We can enable or disable logging
  final bool showLog;

  /// Defines encoder for intercepted json
  static const _encoder = JsonEncoder.withIndent('\n');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!showLog) return;
    try {
      _printRequest(options);
    } catch (e) {
      ColoredLog.red(e, name: 'Colored Log Error');
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (!showLog) return;

    try {
      if (showResponseBody) _printResponse(response);
    } catch (e) {
      ColoredLog.red(e, name: 'Colored Log Error');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (showLog) {
      try {
        _logOnError(err);
      } catch (e) {
        ColoredLog.red(e, name: 'Colored Log Error');
      }
    }
    handler.next(err);
  }

  void _printRequest(RequestOptions options) {
    //Printing curl
    if (showCurl) _printCurl(options);

    //Printing Url
    ColoredLog.cyan(
      options.path,
      name: '${options.method.toUpperCase()} URL',
    );

    //Printing Header
    if (showRequestHeader && options.headers.isNotEmpty) {
      ColoredLog.magenta(jsonEncode(options.headers), name: 'Headers');
    }

    //Printing Query Parameters
    if (options.queryParameters.isNotEmpty) {
      try {
        ColoredLog.white(
          jsonEncode(options.queryParameters),
          name: 'Query Parameters',
        );
      } catch (e) {
        ColoredLog.red('Query Parameter', name: 'Format Exception');
      }
    }

    //Printing payload
    _printPayload(options);
  }

  void _printResponse(Response<dynamic> response) {
    final method = response.requestOptions.method;
    final uri = response.requestOptions.uri.normalizePath().path;
    dynamic data = response.data;
    try {
      if (response.data is Map || response.data is List) {
        data = jsonEncode(response.data);
      }
    } catch (e) {
      //Error formatting response data
    }
    ColoredLog.yellow(
      data,
      name:
          '${method.toUpperCase()} Response[${response.statusCode}] - ($uri) ',
    );
  }

  void _logOnError(DioException err) {
    if (!showError) return;
    ColoredLog.red(
      err.response?.data,
      name:
          'DioException -- ${err.response?.statusCode ?? ''}(${err.response?.statusMessage ?? ''}) -- ${err.type.name} -- (${err.requestOptions.uri.normalizePath().path})',
    );
  }

  void _printPayload(RequestOptions options) {
    final dynamic data = options.data;
    if (data == null) return;
    if (data is Map) {
      ColoredLog.green(jsonEncode(data), name: 'Payload');
    } else if (data is FormData) {
      final formDataMap = <String, String?>{}
        ..addEntries(data.fields)
        ..addEntries(data.files.map((e) => MapEntry(e.key, e.value.filename)));
      final formDataJson = _encoder.convert(formDataMap);
      ColoredLog.green(formDataJson, name: 'Payload FormData');
    } else {
      ColoredLog.green(data, name: 'Payload');
    }
  }

  void _printCurl(RequestOptions options) {
    final components = ['curl -i', '-X ${options.method}'];
    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });
    final data = options.data;
    if (data != null) {
      if (data is FormData) {
        for (final field in data.fields) {
          components.add('--form ${field.key}="${field.value}"');
        }
        for (final file in data.files) {
          components.add('--form =@"${file.value.filename}"');
        }
      } else if (options.headers['content-type'] ==
          'application/x-www-form-urlencoded') {
        (data as Map).forEach((k, v) => components.add('-d "$k=$v"'));
      } else {
        final dataJson = _encoder.convert(data).replaceAll('"', r'\"');
        components.add('-d "$dataJson"');
      }
    }

    components.add('"${options.uri}"');
    ColoredLog.blackBright(
      components.join(' \\\n\t'),
      name: 'cURL',
    );
  }
}
