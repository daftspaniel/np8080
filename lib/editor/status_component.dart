import 'package:angular2/core.dart';
import 'dart:math';
@Component(
    selector: 'text-status',
    templateUrl: 'status_component.html')
class StatusComponent {
  @Input('text')
  String text;

  String get length => text.length.toString();
  String get wordCount => min(text.split(' ').length, text.length).toString();
  String get lineCount => ('\n'.allMatches(text).length).toString();
}
