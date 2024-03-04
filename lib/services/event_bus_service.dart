import 'dart:async';

class EventBusService {
  final StreamController _streamController = StreamController.broadcast();

  StreamController<dynamic> get streamController => _streamController;

  void registerOnEvent(Function() func) => streamController.stream.listen((_) => func());

  void fire(dynamic event) => _streamController.add(event);
}
