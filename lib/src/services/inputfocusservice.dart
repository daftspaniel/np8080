import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';

@Injectable()
class InputFocusService {
  void setFocus(String id) {
    new Timer(new Duration(seconds: 1), () => querySelector(id)?.focus());
  }
}
