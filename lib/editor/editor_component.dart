import 'package:angular2/core.dart';
import 'package:np8080/dialog/about_component.dart';
import 'package:np8080/dialog/generate_component.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/editor/preview_component.dart';
import 'package:np8080/editor/status_component.dart';
import 'package:np8080/toolbar/toolbar_component.dart';

@Component(
    selector: 'plain-editor',
    templateUrl: 'editor_component.html',
    directives: const [
      StatusComponent,
      ToolbarComponent,
      AboutDialogComponent,
      GenerateDialogComponent,
      PreviewComponent
    ])
class EditorComponent {

  final String placeHolderText = """
  Welcome to notepad8080!

  np8080.win is a simple text editor in your browser. It is free and Open Source software.

  Your data is stored in your web browser's local storage and NOT on any server.

  Click the download button to save the text as a file.

  You can change the filename by clicking on the field in the top left.

  Click 'About' to learn even more.""";

  @Input()
  TextDocument note;

  bool showAboutDialog = false;

  bool showGenerateDialog = false;

  bool showPreview = false;

  void changeHandler() {
    note.save();
  }

}
