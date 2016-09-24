import 'dart:math';

import 'package:angular2/core.dart';

@Component(
    selector: 'text-status',
    templateUrl: 'status_component.html')
class StatusComponent {

  @Input('text')
  String text;

  @Input('modified')
  DateTime modified;

  String get length => text.length.toString();

  //String get lastModified => modified.toString();

  String get wordCount {
    String workingText = text;
    workingText = workingText.replaceAll('\n', ' ');
    List<String> words = workingText.split(' ');
    words.removeWhere((word) => word.length == 0 || word == " ");
    return min(words.length, text.length).toString();
  }

  String get lineCount =>
      ('\n'
          .allMatches(text)
          .length).toString();
}
