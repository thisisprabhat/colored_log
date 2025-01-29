enum LogStyle {
  bold(1),
  faint(2),
  italicized(3),
  underlined(4),
  blinkSlow(5),
  blinkRapid(6),
  reverse(7),
  hidden(8),
  strikethrough(9);

  const LogStyle(this.code);
  final int code;
}
