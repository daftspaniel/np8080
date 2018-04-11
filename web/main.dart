// Copyright (c) 2016-18, Davy Mitchell. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:pwa/client.dart' as pwa;

// ignore: uri_has_not_been_generated
import 'package:np8080/src/app.template.dart' as ng;

import 'rootinjector.dart';

main() {
  pwa.Client();
  runApp(ng.AppComponentNgFactory, createInjector: rootInjector);
}
