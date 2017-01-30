import 'package:angular2/core.dart';
import 'package:angular2/src/facade/browser.dart';
import 'package:np8080/dialog/about/about_component.dart';
import 'package:np8080/dialog/generate/generate_component.dart';
import 'package:np8080/dialog/prepost/prepost_component.dart';
import 'package:np8080/dialog/replace/replace_component.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/editor/preview_component.dart';
import 'package:np8080/editor/status_component.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/toolbar/toolbar_component.dart';

@Component(
    selector: 'plain-editor',
    templateUrl: 'editor_component.html',
    directives: const [
      StatusComponent,
      ToolbarComponent,
      AboutDialogComponent,
      GenerateDialogComponent,
      ReplaceDialogComponent,
      PrePostDialogComponent,
      PreviewComponent
    ],
    providers: const [TextareaDomService])
class EditorComponent {
  final TextareaDomService _textareaDomService;

  EditorComponent(this._textareaDomService);

  final String placeHolderText = """
  Welcome to Notepad 8080!

  Notepad 8080 is a simple web based text editor in your browser. It is free to use and Open Source software.

  Your data is automatically stored in your web browser's local storage and NOT on any server.

  Click the download button to save the text as a file.

  You can change the filename by clicking on the name in the top left.

  Click 'About' to learn even more.""";

  @Input()
  TextDocument note;

  bool showAboutDialog = false;

  bool showGenerateDialog = false;

  bool showReplaceDialog = false;

  bool showPreview = false;

  bool showPrePostDialog = false;

  void changeHandler() {
    note.save();
  }

  bool keyHandler(KeyboardEvent e) {
    // TAB key
    if (e.keyCode == 9) {
      e.preventDefault();
      TextareaSelection selInfo = _textareaDomService.getCurrentSelectionInfo();

      int pos = selInfo.start + 4;

      _textareaDomService.setText(
          note.text.substring(0, selInfo.start) + "    " +
              note.text.substring(selInfo.start));
      _textareaDomService.setCursorPosition(pos);

      note.text = _textareaDomService.getText();

      return false;
    }
    return true;
  }

}