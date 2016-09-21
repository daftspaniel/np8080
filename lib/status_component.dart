import 'package:angular2/core.dart';

@Component(
    selector: 'text-status',
    templateUrl: 'status_component.html')
class StatusComponent {
  @Input('text')
  String text;

  String get length => text.length.toString();
  String get wordCount => text.split(' ').length.toString();
  String get lineCount => ('\n'.allMatches(text).length).toString();
}
