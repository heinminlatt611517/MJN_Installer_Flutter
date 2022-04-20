
import 'package:event_bus/event_bus.dart';

class EventBusUtils {
  static  EventBus _instance =new EventBus();

  static EventBus getInstance() {
    if (null == _instance) {
      _instance = new EventBus();
    }
    return _instance;
  }
}

