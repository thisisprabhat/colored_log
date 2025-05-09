import 'dart:developer' as console;

import '/enums/log_color.dart';
import '/enums/log_style.dart';
import '/enums/log_type.dart';

import 'formatted_text.dart';

class ColoredLog {
//! Constructor with all properties ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ColoredLog(
    dynamic message, {
    LogColor? color,
    String? name,
    bool autoColoring = true,
    LogColor? background,
    LogStyle? style,
  }) {
    _customLog(
      message,
      color: color ?? _defaultColor,
      background: background,
      auto: autoColoring,
      style: style,
      name: name,
    );
  }

  static markdown(dynamic message, {String? name}) {
    final markdown =
        FormattedText.formatMarkdownStringToColors(message, name: name);
    if (_logs == LogType.hideLogs) return;
    if (_logs == LogType.print) {
      print(markdown);
    } else if (_logs == LogType.logs) {
      console.log(markdown, name: name ?? 'Markdown');
    }
  }

  //! This is common method for logging ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  static _customLog(
    dynamic message, {
    required LogColor color,
    String? name,
    LogColor? background,
    LogStyle? style,
    bool auto = false,
  }) {
    if (_logs == LogType.hideLogs) return;

    String? coloredName = getStylizedText(
      name == null
          ? ''
          : _logs == LogType.logs
              ? name
              : '[$name] ',
      color: color,
      background: background,
      style: style,
    );

    String coloredMessage = auto
        ? getColoredObject(message)
        : getStylizedText(
            message,
            background: background,
            color: color,
            style: style,
          );

    if (_logs == LogType.print) {
      print('${name == null ? '' : coloredName}$coloredMessage');
    } else if (_logs == LogType.logs) {
      console.log(coloredMessage, name: name == null ? '' : coloredName);
    }
  }

  //* gettting stylize text _________________________________________________
  /// It returns stylized text that can be inserted in print() or log() to print stylized text
  static String getStylizedText(
    dynamic value, {
    LogColor? color,
    LogColor? background,
    LogStyle? style,
  }) {
    const reset = '\x1B[0m'; //ANSI reset code
    final colorCode = color == null ? '' : '\x1B[${color.code}m';
    final backgroundCode =
        background == null ? '' : '\x1B[${background.background}m';
    final styleCode = style == null ? '' : '\x1B[${style.code}m';

    // This mapping is done for multiline formatting
    return value
        .toString()
        .split('\n')
        .map((line) => '$colorCode$backgroundCode$styleCode$line$reset')
        .join('\n');
  }

  /// It returns stylized text based on object type
  static String getColoredObject(dynamic value, {bool stringQuotes = false}) {
    if (value is Map<String, dynamic>) {
      return FormattedText.formatJsonObjectWithColors(value);
    } else if (value.toString().startsWith(value.runtimeType.toString())) {
      return FormattedText.formatDartObjectString(value);
    } else if (value is String) {
      return stringQuotes
          ? "'${ColoredLog.getStylizedText(value, color: LogColor.cyan)}'"
          : ColoredLog.getStylizedText(value, color: LogColor.cyan);
    } else if (value is num) {
      return ColoredLog.getStylizedText(value, color: LogColor.blue);
    } else if (value is bool) {
      return ColoredLog.getStylizedText(
        value,
        color: LogColor.green,
        style: LogStyle.bold,
      );
    } else if (value == null) {
      return ColoredLog.getStylizedText(
        value,
        color: LogColor.red,
        style: LogStyle.italicized,
      );
    } else {
      return ColoredLog.getStylizedText(value, color: LogColor.magenta);
    }
  }

  //! Static coloredLogs for quick access ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  static black(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.black,
        background: background,
        style: style,
        name: name,
      );

  static red(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.red,
        background: background,
        style: style,
        name: name,
      );

  static green(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.green,
        background: background,
        style: style,
        name: name,
      );

  static yellow(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.yellow,
        background: background,
        style: style,
        name: name,
      );

  static blue(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.blue,
        background: background,
        style: style,
        name: name,
      );

  static magenta(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.magenta,
        background: background,
        style: style,
        name: name,
      );

  static cyan(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.cyan,
        background: background,
        style: style,
        name: name,
      );

  static white(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.white,
        background: background,
        style: style,
        name: name,
      );

  static blackBright(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.blackBright,
        background: background,
        style: style,
        name: name,
      );

  static redBright(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.redBright,
        background: background,
        style: style,
        name: name,
      );

  static greenBright(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.greenBright,
        background: background,
        style: style,
        name: name,
      );

  static yellowBright(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.yellowBright,
        background: background,
        style: style,
        name: name,
      );

  static blueBright(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.blueBright,
        background: background,
        style: style,
        name: name,
      );

  static magentaBright(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.magentaBright,
        background: background,
        style: style,
        name: name,
      );

  static cyanBright(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.cyanBright,
        background: background,
        style: style,
        name: name,
      );

  static whiteBright(
    var message, {
    String? name,
    LogColor? background,
    LogStyle? style,
  }) =>
      _customLog(
        message,
        color: LogColor.whiteBright,
        background: background,
        style: style,
        name: name,
      );

  //! Logs Type Config ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  static LogColor _defaultColor = LogColor.magenta;

  /// When using constructor directly, then the default color is used
  static set setDefaultColor(LogColor color) => _defaultColor = color;

  static final _isFlutter = const bool.fromEnvironment('dart.library.ui');
  static LogType? _defaultLogs;
  static LogType get _logs =>
      _defaultLogs ?? (_isFlutter ? LogType.logs : LogType.print);
  static bool _isSetterUsed = false;

  ///### Setting logs type globally for the entire project
  /// - [LogType.logs]      : It prints [ColoredLog] using `log('Hello World')`
  /// - [LogType.print]     : It prints [ColoredLog] using `print("Hellow World")`
  /// - [LogType.hideLogs]  : It makes the log print nothing
  ///
  /// **Setting up the logType**
  /// ```
  ///   ColoredLog.setLogType = LogType.logs;
  /// ```
  /// - This setter can be used only at once throught the project, so use it in the top level only
  static set setLogType(LogType type) {
    if (_isSetterUsed) return;
    _isSetterUsed = true;
    _defaultLogs = type;
  }
}
