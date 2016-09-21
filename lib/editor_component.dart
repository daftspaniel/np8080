import 'package:angular2/core.dart';

import 'status_component.dart';
import 'toolbar_component.dart';
import 'textdocument.dart';

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
