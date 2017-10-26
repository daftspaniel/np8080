// Copyright (c) 2016-17, Davy Mitchell. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:np8080/src/app.dart';
import 'package:np8080/src/services/documentservice.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';
import 'package:pwa/client.dart' as pwa;

main() {
  new pwa.Client();
  bootstrap(AppComponent, [
    EventBusService,
    TextProcessingService,
    TextareaDomService,
    ThemeService,
    DocumentService
  ]);
}
