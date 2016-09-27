import 'dart:math';

import 'package:angular2/core.dart';

@Injectable()
class TextProcessingService {

  String trimText(String src) {
    return src.trim();
  }

  int getWordCount(String text) {
    String workingText = text;
    workingText = workingText.replaceAll('\n', ' ');
    List<String> words = workingText.split(' ');
    words.removeWhere((word) => word.length == 0 || word == " ");
    return min(words.length, text.length);
  }

  int getLineCount(String text) {
    return '\n'
        .allMatches(text)
        .length;
  }
}