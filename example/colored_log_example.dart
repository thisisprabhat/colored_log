import 'package:colored_log/colored_log.dart';

void main() {
  // Red-colored text
  // name is optional
  ColoredLog.red(
    "This is a red log message.",
    name: 'Red Log',
  );

  // Custom background color
  ColoredLog.black(
    "This log has a green background.",
    background: LogColor.green,
  );

  // Bold yellow text
  ColoredLog.yellow(
    "This log is bold and yellow.",
    style: LogStyle.bold,
  );

  // Italicized
  ColoredLog(
    "This log is italicized and underlined.",
    style: LogStyle.italicized,
  );

  // Blinking text
  ColoredLog.red(
    "This is a blinking log!",
    style: LogStyle.blinkSlow,
  );
}
