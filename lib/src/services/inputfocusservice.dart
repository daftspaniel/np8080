import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';

@Injectable()
class InputFocusService {
  void setFocus(String id) {
    Timer(Duration(seconds: 1), () => querySelector(id)?.focus());
  }
}
