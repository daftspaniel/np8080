// Copyright (c) 2016, Davy Mitchell. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/platform/browser.dart';
import 'package:np8080/app_component.dart';

ApplicationCache appCache = window.applicationCache;

main() {
  bootstrap(AppComponent);

  appCache.onUpdateReady.listen((e) => (){
    if (appCache.status == ApplicationCache.UPDATEREADY) {
      appCache.swapCache();
      window.alert('A new version of NP8080 is available. Please reload to enjoy the new hotness!');
    }
  });
}
