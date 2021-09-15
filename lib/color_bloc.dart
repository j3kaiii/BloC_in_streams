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

  // метод изменяет состояние в зависимости от события
  void _mapEventToState(ColorEvent event) {
    if (event == ColorEvent.event_red) {
      _color = Colors.red;
    } else if (event == ColorEvent.event_green) {
      _color = Colors.green;
    } else {
      throw Exception('Wrong event type');
    }

    // полученное состояние нужно добавить в исходящий поток
    _outputStateController.sink.add(_color);
  }

  // слушаем входящий поток и обрабатываем события
  ColorBloc() {
    _inputEvenController.stream.listen(_mapEventToState);
  }

  //закрываем потоки
  void dispose() {
    _inputEvenController.close();
    _outputStateController.close();
  }
}
