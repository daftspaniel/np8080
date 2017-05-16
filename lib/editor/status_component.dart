import 'package:angular2/core.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'dart:html';

@Component(
    selector: 'text-status',
    templateUrl: 'status_component.html',
    providers: const [TextProcessingService])
class StatusComponent {

  final TextProcessingService _textProcessingService;

  StatusComponent(this._textProcessingService);

  @Input('text')
  String text;

  @Input('modified')
  DateTime modified;

  String get length => text.length.toString();

  String get wordCount => _textProcessingService.getWordCount(text).toString();

  String get lineCount => _textProcessingService.getLineCount(text).toString();

  bool isHttps(){
    return window.location.href.contains('https://');
  }
}
