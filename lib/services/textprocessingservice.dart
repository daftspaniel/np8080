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

  String getReplaced(String content, String target, String replacement) {
    return content.replaceAll(target, replacement);
  }

  String convertMarkdownToHtml(String content) {
    return md.markdownToHtml(content, extensionSet: md.ExtensionSet.commonMark);
  }

  String sort(String text) {
    String delimiter;
    if (text.contains('\n')) {
      delimiter = '\n';
    }
    else
      delimiter = ' ';

    return sortDelimiter(text, delimiter);
  }

  String sortDelimiter(String text, String delimiter) {
    List<String> segments = text.split(delimiter);
    String out = "";
    segments
      ..sort()
      ..forEach((line) => out += line + delimiter);
    return trimText(out);
  }

  String reverse(String text) {
    String delimiter;
    if (text.contains('\n')) {
      delimiter = '\n';
    }
    else
      delimiter = ' ';

    return reverseDelimiter(text, delimiter);
  }

  String reverseDelimiter(String text, String delimiter) {
    List<String> segments = text.split(delimiter);
    String out = "";

    segments.reversed.forEach((line) => out += line + delimiter);
    return trimText(out);
  }

  String prefixLines(String text, String prefix) {
    List<String> segments = text.split('\n');
    String out = "";

    segments.forEach((line) {
      out += prefix + line + '\n';
    });
    return out;
  }

  String removeBlankLines(String text) {
    List<String> segments = text.split('\n');
    String out = "";

    segments.forEach((line) {
      if (line.length > 0) out += line + '\n';
    });
    return out;
  }

  String randomise(String text) {
    List<String> segments = text.split('\n');
    segments.shuffle();
    String out = "";

    segments.forEach((line) {
      if (line.length > 0) out += line + '\n';
    });
    return out;
  }
}
