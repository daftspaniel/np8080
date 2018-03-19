// (c) 2016-17, Davy Mitchell. All rights reserved. Use of this source code

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
import 'package:np8080/src/services/themeservice.dart';
import 'package:np8080/src/toolbar/toolbar.dart';

@Component(selector: 'np8080-app', templateUrl: 'app.html', directives: const [
  EditorComponent,
  AboutDialogComponent,
  ManualDialog,
  ReaderView,
  Toolbar,
  EditableLabel,
  NgClass,
  DualReaderView
])
class AppComponent {
  final TextDocument note1 = new TextDocument(1);
  final TextDocument note2 = new TextDocument(2);
  final DocumentService documentService;
  final ThemeService themeService;

  bool showPreview = false;

  AppComponent(this.documentService, this.themeService) {
    documentService.note = note1;
    documentService.inActiveNote = note2;
  }
}
