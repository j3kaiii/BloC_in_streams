import 'package:bloc_with_streams/color_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloC with Stream',
      home: BlocPage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class BlocPage extends StatefulWidget {
  @override
  _BlocPageState createState() => _BlocPageState();
}

class _BlocPageState extends State<BlocPage> {
  // добавляем bloc в стейт приложения
  final ColorBloc _bloc = ColorBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc App'),
        centerTitle: true,
      ),
      body: Center(
        // изменяемую часть нужно обернуть в StreamBuilder
        child: StreamBuilder<Color>(
            // исходящий поток (гетер) с новым состоянием
            stream: _bloc.outputStateStream,
            // первоначальное состояние
            initialData: Colors.red,
            // строим UI на основе данных (snapshot)
            builder: (context, snapshot) {
              return AnimatedContainer(
                height: 100,
                width: 100,
                color: snapshot.data,
                duration: const Duration(milliseconds: 500),
              );
            }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // во входящий поток bloc передаем событие
              _bloc.inputEventSink.add(ColorEvent.event_red);
            },
            backgroundColor: Colors.red,
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              // во входящий поток bloc передаем событие
              _bloc.inputEventSink.add(ColorEvent.event_green);
            },
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
