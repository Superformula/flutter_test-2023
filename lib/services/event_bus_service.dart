import 'dart:async';

class EventBusService {
  final StreamController _streamController = StreamController.broadcast();

  StreamController<dynamic> get streamController => _streamController;

  Stream<dynamic> get stream => _streamController.stream;

  void fire(dynamic event) => _streamController.add(event);
}
