import '../colored_log.dart';

class FormattedText {
  static String formatJsonObjectWithColors(dynamic jsonObject,
      [int indentLevel = 0]) {
    String output = "";
    String indent = "  " * indentLevel;

    if (jsonObject is Map<String, dynamic>) {
      output += "{\n";
      int index = 0;
      for (var key in jsonObject.keys) {
        var value = jsonObject[key];
        output += "$indent  ";
        output +=
            ColoredLog.getStylizedText("\"$key\": ", color: LogColor.yellow);
        if (value is String || value is num || value is bool || value == null) {
          output += ColoredLog.getColoredObject(value);
        } else {
          output += formatJsonObjectWithColors(value, indentLevel + 1);
        }
        output += ColoredLog.getStylizedText(",", color: LogColor.white);
        if (index < jsonObject.length - 1) {
          output += "\n";
        }
        index++;
      }
      output += "\n$indent}";
    } else if (jsonObject is List<dynamic>) {
      output += "[\n";
      for (int i = 0; i < jsonObject.length; i++) {
        output += "$indent  ";
        output += formatJsonObjectWithColors(jsonObject[i], indentLevel + 1);
        if (i < jsonObject.length - 1) {
          output += ",\n";
        }
      }
      output += "\n$indent]";
    } else {
      return ColoredLog.getColoredObject(jsonObject);
    }
    return output;
  }
}
