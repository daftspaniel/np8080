import 'package:angular2/core.dart';

import 'package:np8080/editor/status_component.dart';
import 'package:np8080/toolbar/toolbar_component.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/dialog/about_component.dart';

@Component(
    selector: 'plain-editor',
    templateUrl: 'editor_component.html',
    directives: const [StatusComponent, ToolbarComponent, AboutDialogComponent])
class EditorComponent {

  final String placeHolderText = "Welcome to notepad8080! Click 'About' to learn more.";

  @Input()
  TextDocument note;

  @Input()
  bool showDialog = false;

  void changeHandler() {
    note.save();
  }
}
