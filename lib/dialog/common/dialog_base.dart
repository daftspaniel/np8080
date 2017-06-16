import 'dart:async';

import 'package:np8080/services/eventbusservice.dart';

abstract class DialogBase {
  final StreamController onShowDialogChange = new StreamController();

  void close() {
    onShowDialogChange.close();
  }
}