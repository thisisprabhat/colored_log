import 'package:colored_log/colored_log.dart';

void main() {
  ColoredLog.green('Test Msg', name: 'Test');
  ColoredLog(readmeText);
  print('Hellow World');
}

final multilineText = '''
Hello World , 
This is Prabhat
''';
final readmeText = '''
## All Text Formatting Codes:
These are used to modify text appearance beyond just color.

0. Reset (reset all styles, returns to default)
1. Bold text (also used for brighter colors in some terminals)
2. Faint (rarely used, can make text a bit dimmer)
3. Italicized text (note: not supported in all terminals)
4. Underlined text
5. Blink (slow) — not supported in many modern terminals
6. Blink (rapid) — not supported in many modern terminals
7. Reverse video (swaps foreground and background colors)
8. Hidden (invisible text)
9. Strikethrough text (draw a line through the text)
10. (Not widely used, specific to some terminals)<br>
11-19: (Some reserved codes for terminal-specific functionality, not commonly used)<br>
20: (Not widely used)<br>
21: Double underline (rarely supported)<br>
22: Normal color or intensity (turns off bold or faint)<br>
23: Not underlined (turns off underlining)<br>
24: Not blink (turns off blink effect)<br>
25: Reserved for future use (rarely seen in modern terminals)<br>
26-29: Specific codes for different effects, less commonly used:<br>
30-37: Text colors (listed above)<br>
40-47: Background colors (listed above)<br>
90-97: Bright text colors (listed above)<br>
100-107: Bright background colors (listed above)<br>
''';
