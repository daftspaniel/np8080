// (c) 2016-18, Davy Mitchell. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/editablelabel/editablelabel.dart';
import 'package:np8080/src/editor/editor.dart';

import 'package:np8080/src/dialog/about/aboutdialog.dart';
import 'package:np8080/src/dialog/manual/manualdialog.dart';
import 'package:np8080/src/editor/views/dualreaderview.dart';
import 'package:np8080/src/editor/views/readerview.dart';
import 'package:np8080/src/services/documentservice.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';
import 'package:np8080/src/storage/localstorage.dart';
import 'package:np8080/src/toolbar/toolbar.dart';

@Component(selector: 'np8080-app', templateUrl: 'app.html', directives: [
  EditorComponent,
  AboutDialogComponent,
  ManualDialog,
  ReaderView,
  Toolbar,
  EditableLabel,
  NgClass,
  DualReaderView
])
class AppComponent implements AfterViewInit {
  final note1 = TextDocument(1);
  final note2 = TextDocument(2);
  final note3 = TextDocument(3);
  final note4 = TextDocument(4);
  final note5 = TextDocument(5);
  final note6 = TextDocument(6);

  final DocumentService documentService;
  final ThemeService themeService;
  final EventBusService eventBusService;

  var showPreview = false;

  AppComponent(this.documentService, this.themeService, this.eventBusService) {
    documentService
      ..activeNote = note1
      ..addNote(note1)
      ..addNote(note2)
      ..addNote(note3)
      ..addNote(note4)
      ..addNote(note5)
      ..addNote(note6);
  }

  ngAfterViewInit() {
    print('HELLLO');
    var index = loadValue('ActiveDocument', '1');
    print(index);
    //documentService.activeNote = documentService.getNote(int.parse(index) - 1);
    documentService.makeNoteActive(5);
    eventBusService.post("tabFocus5");
  }
}
