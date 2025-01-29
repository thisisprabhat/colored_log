### Log Levels
The package supports multiple log levels to categorize your logs, such as info, warning, and error.
```dart
void main() {
  ColoredLog.info("This is an info message.");
  ColoredLog.warning("This is a warning message.", color: LogColor.yellow);
  ColoredLog.error("This is an error message.", color: LogColor.red);
}
```