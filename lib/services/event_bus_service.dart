import 'dart:async';

export 'dart:async';

enum EventBusType { toggleFavorite }

extension EventBusTypeExt on EventBusType {
  void onEvent({required EventBusType eventType, dynamic function}) {
    if (this == eventType) function();
  }
}

class EventBusService {
  final StreamController<EventBusType> _streamController = StreamController.broadcast();

  StreamController<EventBusType> get streamController => _streamController;

  Stream<EventBusType> get stream => _streamController.stream;

  void fire(EventBusType event) => _streamController.add(event);
}
