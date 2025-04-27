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

  /// Format a Markdown string with colors and styles for readability in logs.
  static String formatMarkdownStringToColors(dynamic value, {String? name}) {
    if (value is! String) {
      throw ArgumentError('The value must be a string.');
    }

    final String markdown = value;

    // Regular expressions for markdown elements
    final RegExp headerRegex = RegExp(r'^(#{1,6})\s*(.*)');
    final RegExp boldItalicRegex = RegExp(r'(\*\*\*|___)(.*?)\1');
    final RegExp boldRegex = RegExp(r'(\*\*|__)(.*?)\1');
    final RegExp italicRegex = RegExp(r'(\*|_)(.*?)\1');
    final RegExp codeBlockRegex = RegExp(r'```([\w-]+)?\n([\s\S]*?)```');
    final RegExp inlineCodeRegex = RegExp(r'`([^`]+)`');
    final RegExp bulletPointRegex = RegExp(r'^(\s*[-*+])\s+(.*)');
    final RegExp captionRegex = RegExp(r'^\[.*\]\(.*\)');
    final RegExp blockQuoteRegex = RegExp(r'^>\s?(.*)');

    final List<String> lines = markdown.split('\n');
    final StringBuffer formattedOutput = StringBuffer();

    for (var line in lines) {
      if (headerRegex.hasMatch(line)) {
        // Format headers with different colors
        final match = headerRegex.firstMatch(line);
        final String hashes = match?.group(1) ?? '';
        final String content = match?.group(2) ?? '';

        switch (hashes.length) {
          case 1:
            formattedOutput.writeln(ColoredLog.getStylizedText('# $content',
                color: LogColor.white, style: LogStyle.blinkSlow));
            break;
          case 2:
            formattedOutput.writeln(ColoredLog.getStylizedText('## $content',
                color: LogColor.magenta, style: LogStyle.bold));
            break;
          case 3:
            formattedOutput.writeln(ColoredLog.getStylizedText('### $content',
                color: LogColor.green, style: LogStyle.bold));
            break;
          case 4:
            formattedOutput.writeln(ColoredLog.getStylizedText('#### $content',
                color: LogColor.yellow, style: LogStyle.bold));
            break;
          case 5:
            formattedOutput.writeln(ColoredLog.getStylizedText('##### $content',
                color: LogColor.cyan, style: LogStyle.bold));
            break;
          case 6:
            formattedOutput.writeln(ColoredLog.getStylizedText(
                '###### $content',
                color: LogColor.white,
                style: LogStyle.faint));
            break;
          default:
            formattedOutput.writeln(line);
        }
      } else if (blockQuoteRegex.hasMatch(line)) {
        // Format inline quotes
        final String formattedLine =
            line.replaceAllMapped(blockQuoteRegex, (match) {
          final String quotes = match.group(1) ?? '';
          return ColoredLog.getStylizedText(
            quotes,
            color: LogColor.magenta,
            style: LogStyle.italicized,
          );
        });
        formattedOutput.writeln(formattedLine);
      } else if (inlineCodeRegex.hasMatch(line)) {
        // Format inline code
        final String formattedLine =
            line.replaceAllMapped(inlineCodeRegex, (match) {
          final String code = match.group(1) ?? '';
          return ColoredLog.getStylizedText(code,
              color: LogColor.blackBright, style: LogStyle.italicized);
        });
        formattedOutput.writeln(formattedLine);
      } else if (boldItalicRegex.hasMatch(line)) {
        // Format bold italic text
        final String formattedLine =
            line.replaceAllMapped(boldItalicRegex, (match) {
          final String content = match.group(2) ?? '';
          return ColoredLog.getStylizedText(content,
              color: LogColor.red, style: LogStyle.italicized);
        });
        formattedOutput.writeln(formattedLine);
      } else if (boldRegex.hasMatch(line)) {
        // Format bold text
        final String formattedLine = line.replaceAllMapped(boldRegex, (match) {
          final String content = match.group(2) ?? '';
          return ColoredLog.getStylizedText(content,
              color: LogColor.magenta, style: LogStyle.bold);
        });
        formattedOutput.writeln(formattedLine);
      } else if (italicRegex.hasMatch(line)) {
        // Format italic text
        final String formattedLine =
            line.replaceAllMapped(italicRegex, (match) {
          final String content = match.group(2) ?? '';
          return ColoredLog.getStylizedText(content,
              color: LogColor.blackBright, style: LogStyle.italicized);
        });
        formattedOutput.writeln(formattedLine);
      } else if (bulletPointRegex.hasMatch(line)) {
        // Format bullet points
        final match = bulletPointRegex.firstMatch(line);
        final String content = match?.group(2) ?? '';
        formattedOutput.writeln(
            '${ColoredLog.getStylizedText('‣', color: LogColor.red, style: LogStyle.bold)} ${ColoredLog.getStylizedText(content, color: LogColor.white)}');
      } else if (captionRegex.hasMatch(line)) {
        // Format captions/links
        formattedOutput.writeln(ColoredLog.getStylizedText(line,
            color: LogColor.blue, style: LogStyle.italicized));
      } else {
        formattedOutput.writeln(line);
      }
    }

    String formattedString = formattedOutput.toString();
    formattedString = formattedString.replaceAllMapped(codeBlockRegex, (match) {
      final String code = match.group(2) ?? '';
      return ColoredLog.getStylizedText(code, color: LogColor.blackBright);
    });

    final title = ColoredLog.getStylizedText(
      '${name ?? ''} ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~',
      color: LogColor.cyan,
      style: LogStyle.blinkSlow,
    );
    formattedString = '\n$title\n$formattedString\n$title';

    return formattedString;
  }
}
