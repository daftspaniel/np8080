import 'dart:async';

abstract class DialogBase {
  final StreamController onShowDialogChange = new StreamController();

  void close() {
    onShowDialogChange.close();
  }
}