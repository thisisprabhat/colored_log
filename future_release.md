### Log Levels

## The package supports multiple log levels to categorize your logs, such as info, warning, and error.
```dart
void main() {
  ColoredLog.info("This is an info message.");
  ColoredLog.warning("This is a warning message.", color: LogColor.yellow);
  ColoredLog.error("This is an error message.", color: LogColor.red);
  ColoredLog.success("This is an error message.", color: LogColor.red);
}
```

## It should colorize a markdown file with some specific rules
Example
- yellow for heading 
- Green for code 
- Bold colors
- normal text in white
- Use some sets of different colors for the lines that starts with (#, -,* , ~, > )
