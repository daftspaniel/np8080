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
    for (int i = 0; i < segments.length; i++) {
      out += prefix + segments[i];
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  String postfixLines(String text, String postfix) {
    List<String> segments = text.split('\n');
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      out += segments[i] + postfix;
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  String trimLines(String text) {
    List<String> segments = text.split('\n');
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      out += segments[i].trim();
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }

  String removeBlankLines(String text) {
    List<String> segments = text.split('\n');
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      if (segments[i].length > 0) {
        out += segments[i];
        if (i < (segments.length - 1) && text.indexOf('\n') > -1) {
          out += '\n';
        }
      }
    }

    return out;
  }

  String removeExtraBlankLines(String text) {
    while (text.indexOf('\n\n\n') > -1) {
      text = text.replaceAll('\n\n\n', '\n\n');
    }

    return text;
  }

  String doubleSpaceLines(String text) {
    return text.replaceAll('\n', '\n\n');
  }

  String randomise(String text) {
    List<String> segments = text.split('\n');
    segments.shuffle();
    String out = "";

    for (int i = 0; i < segments.length; i++) {
      if (segments[i].length > 0) out += segments[i];
      if (i < (segments.length - 1)) {
        out += '\n';
      }
    }
    return out;
  }
}
