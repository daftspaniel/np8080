// (c) 2016-17, Davy Mitchell. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/editor/editor_component.dart';

import 'package:np8080/src/dialog/about/about_component.dart';
import 'package:np8080/src/dialog/manual/manualdialog.dart';
import 'package:np8080/src/editor/views/readerview.dart';

@Component(
    selector: 'np8080-app',
    visibility: Visibility.none,
    templateUrl: 'app_component.html',
    directives: const [
      EditorComponent,
      AboutDialogComponent,
      ManualDialog,
      ReaderView
    ])
class AppComponent {
  final TextDocument activeNote = new TextDocument();
}
