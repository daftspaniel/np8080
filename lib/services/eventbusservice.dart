import 'package:angular2/core.dart';

@Injectable()
class EventBusService {
  static final Map<String, List<Function>> subscriptions = new Map<String,
      List<Function>>();

  EventBusService() {
  }

  void subscribe(String event, Function target) {
    List <Function> subscribers;
    if (subscriptions.containsKey(target)) {
      subscribers = subscriptions[event];
    }
    else {
      subscribers = new List <Function>();
      subscriptions[event] = subscribers;
    }
    subscribers.add(target);
  }

  void post(String event) {
    if (subscriptions.containsKey(event)) {
      List <Function> subscribers = subscriptions[event];

      subscribers.forEach((Function target) {
        target();
      });
    }
  }
}