import 'package:angular2/core.dart';

import 'package:np8080/editor/status_component.dart';
import 'package:np8080/toolbar/toolbar_component.dart';
import 'package:np8080/document/textdocument.dart';

@Component(
    selector: 'plain-editor',
    templateUrl: 'editor_component.html',
    directives: const [StatusComponent, ToolbarComponent])
class EditorComponent {
  @Input()
  TextDocument note;

  void changeHandler() {
    note.save();
  }
}
