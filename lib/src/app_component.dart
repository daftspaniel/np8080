// (c) 2016-17, Davy Mitchell. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/editor/editor_component.dart';

@Component(
    selector: 'np8080-app',
    templateUrl: 'app_component.html',
    directives: const [EditorComponent])
class AppComponent {
  TextDocument note1 = new TextDocument();
}
