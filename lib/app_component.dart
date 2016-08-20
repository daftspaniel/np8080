// (c) 2016, Davy Mitchell. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'textdocument.dart';
import 'editor_component.dart';

@Component(selector: 'my-app', templateUrl: 'app_component.html',
    directives: const [
      EditorComponent
    ])
class AppComponent {
  TextDocument note1 = new TextDocument();
}
