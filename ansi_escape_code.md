# Full List of ANSI Escape Codes

Taking reference from this file, `colored_log` is developed.

## Text Color Codes:

### Regular Colors (Text):
30. black
31. red
32. green
33. yellow
34. blue
35. magenta
36. cyan
37. white

### Bright Colors (Text):
90. brightBlack (dark gray)
91. brightRed
92. brightGreen
93. brightYellow
94. brightBlue
95. brightMagenta
96. brightCyan
97. brightWhite


## Background Color Codes:
### Regular Background Colors:

40. black background
41. red background
42. green background
43. yellow background
44. blue background
45. magenta background
46. cyan background
47. white background

### Bright Background Colors:
100. brightBlack background (dark gray)
101. brightRed background
102. brightGreen background
103. brightYellow background
104. brightBlue background
105. brightMagenta background
106. brightCyan background
107. brightWhite background

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