import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent { event_red, event_green }

class ColorBloc {
  Color _color = Colors.red;

  // создали контроллер для входящих событий
  final _inputEvenController = StreamController<ColorEvent>();
  // гетер для контроллера. Через sink(входной поток) контроллер получает события
  StreamSink<ColorEvent> get inputEventSink => _inputEvenController.sink;

  // создали контроллер для исходящих данных
  final _outputStateController = StreamController<Color>();
  // геттер, через stream(исходящий поток) передает данные наружу
  Stream<Color> get outputStateStream => _outputStateController.stream;
}
