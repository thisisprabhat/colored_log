enum LogColor {
  black(code: 30, background: 40),
  red(code: 31, background: 41),
  green(code: 32, background: 42),
  yellow(code: 33, background: 43),
  blue(code: 34, background: 44),
  magenta(code: 35, background: 45),
  cyan(code: 36, background: 46),
  white(code: 37, background: 47),
  blackBright(code: 90, background: 100),
  redBright(code: 91, background: 101),
  greenBright(code: 92, background: 102),
  yellowBright(code: 93, background: 103),
  blueBright(code: 94, background: 104),
  magentaBright(code: 95, background: 105),
  cyanBright(code: 96, background: 106),
  whiteBright(code: 97, background: 107);

  const LogColor({required this.code, required this.background});

  final int code;
  final int background;
}
