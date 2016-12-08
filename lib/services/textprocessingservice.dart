import 'dart:math';

import 'package:angular2/core.dart';
import 'package:markdown/markdown.dart' as md;

@Injectable()
class TextProcessingService {

  String trimText(String src) {
    return src.trim();
  }

  int getWordCount(String text) {
    String workingText = text;
    workingText =
    workingText..replaceAll('\n', ' ')..replaceAll('.', ' ')..replaceAll(
        ',', ' ')..replaceAll(':', ' ')..replaceAll(';', ' ')..replaceAll(
        '?', ' ');
    List<String> words = workingText.split(' ');
    words.removeWhere((word) => word.length == 0 || word == " ");
    return min(words.length, text.length);
  }

  int getLineCount(String text) {
    return '\n'
        .allMatches(text)
        .length;
  }

  String getRepeatedString(String textToRepeat, num count) {
    count ??= 1;
    return textToRepeat * count.toInt();
  }

  String convertMarkdownToHtml(String content) {
    return md.markdownToHtml(content, extensionSet: md.ExtensionSet.commonMark);
  }

  String sortLines(String text) {
    List<String> lines = text.split('\n');
    String out = "";
    lines.sort();
    lines.forEach((line) => out += line + '\n');
    return out;
  }

  String reverseLines(String text) {
    List<String> lines = text.split('\n');
    String out = "";
    lines = lines..reversed;
    lines.forEach((line) => out += line + '\n');
    return out;
  }
}
