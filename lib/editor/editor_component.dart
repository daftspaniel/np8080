import 'dart:html';

import 'package:angular2/core.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:np8080/dialog/about_component.dart';
import 'package:np8080/dialog/generate_component.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/editor/status_component.dart';
import 'package:np8080/toolbar/toolbar_component.dart';

@Component(
    selector: 'plain-editor',
    templateUrl: 'editor_component.html',
    directives: const [
      StatusComponent,
      ToolbarComponent,
      AboutDialogComponent,
      GenerateDialogComponent
    ])
class EditorComponent implements OnChanges {

  DivElement htmlDiv = querySelector('#previewPane');

  final nullSanitizer = new NullTreeSanitizer();
  final String placeHolderText = """
  Welcome to notepad8080!

  np8080.win is a simple text editor in your browser. It is free and Open Source software.

  Your data is stored in your web browser's local storage and NOT on any server.

  Click the download button to save the text as a file.

  You can change the filename by clicking on the field in the top left.

  Click 'About' to learn even more.""";

  @Input()
  TextDocument note;

  @Input()
  bool showAboutDialog = false;

  @Input()
  bool showGenerateDialog = false;

  @Input()
  bool showPreview = false;

  void changeHandler() {
    note.save();
    if (!showPreview) return;

    htmlDiv = querySelector('#previewPane');

    htmlDiv.setInnerHtml(
        md.markdownToHtml(note.text, extensionSet: md.ExtensionSet.commonMark),
        treeSanitizer: nullSanitizer);
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    // TODO: implement ngOnChanges
    print(changes);
    print(changes.keys);
//    if (changes.containsKey("showPreview")) {
      htmlDiv = querySelector('#previewPane');

      htmlDiv.setInnerHtml(
          md.markdownToHtml(
              note.text, extensionSet: md.ExtensionSet.commonMark),
          treeSanitizer: nullSanitizer);
//    }
  }
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}