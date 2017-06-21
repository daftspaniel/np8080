// Copyright (c) 2016-17, Davy Mitchell. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/platform/browser.dart';
import 'package:np8080/app_component.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';
import 'package:pwa/client.dart' as pwa;

main() {
  new pwa.Client();
  bootstrap(
      AppComponent, [EventBusService, TextProcessingService, TextareaDomService, ThemeService
  ]);
}
