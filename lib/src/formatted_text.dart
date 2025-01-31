import '../colored_log.dart';

class FormattedText {
  ///Formatting Json Values with colors
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
          output += ColoredLog.getColoredObject(value, stringQuotes: true);
        } else {
          output += formatJsonObjectWithColors(
            value,
            indentLevel + 1,
          );
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

  ///Formatting Dart Objects with colors
  static String formatDartObjectString(Object input) {
    String value = input.toString();

    //Colorizing class name
    value = value.replaceAllMapped(
      RegExp(r'([\w]+)\('),
      (match) =>
          '${ColoredLog.getStylizedText(match[1], color: LogColor.green)}(',
    );

    //Colorizing the values
    value = value.replaceAllMapped(
        RegExp(r':\s(\w+\s+\w+|\d+|null|true|false)'), (match) {
      String resultVal = match[1].toString();
      String result = 'null';
      RegExp stringReg = RegExp(r'\w');
      RegExp numberReg = RegExp(r'-?\d+(\.\d+)?');
      bool isBool = resultVal == 'true' || resultVal == 'false';
      if (isBool) {
        result = ColoredLog.getStylizedText(resultVal,
            color: LogColor.yellow, style: LogStyle.bold);
      } else if (numberReg.hasMatch(resultVal)) {
        result = ColoredLog.getStylizedText(resultVal,
            color: LogColor.cyan, style: LogStyle.bold);
      } else if (resultVal == 'null') {
        result = ColoredLog.getStylizedText(null,
            color: LogColor.redBright, style: LogStyle.italicized);
      } else if (stringReg.hasMatch(result)) {
        result = resultVal;
      } else {
        result = ColoredLog.getStylizedText(resultVal, color: LogColor.magenta);
      }
      return ': $result';
    });

    //Colorizing the keys
    value = value.replaceAllMapped(
      RegExp(r'([a-zA-Z_]+):'),
      (match) =>
          '\n   ${ColoredLog.getStylizedText(match[1], color: LogColor.blackBright)}${ColoredLog.getStylizedText(':', color: LogColor.white)}',
    );

    //Colorizing [:,)(]
    value = value.replaceAllMapped(
      RegExp(r'[,())]'),
      (match) => ColoredLog.getStylizedText(
        match[0] == ')' ? '\n)' : match[0],
        color: match[0] == ',' || match[0] == ':'
            ? LogColor.white
            : LogColor.magenta,
      ),
    );
    return value;
  }
}
