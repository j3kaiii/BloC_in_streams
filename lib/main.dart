import 'package:bloc_with_streams/color_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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

class BlocPage extends StatefulWidget {
  @override
  _BlocPageState createState() => _BlocPageState();
}

class _BlocPageState extends State<BlocPage> {
  // добавляем bloc в стейт приложения
  final ColorBloc _bloc = ColorBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc App'),
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
                duration: Duration(milliseconds: 500),
              );
            }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.red,
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
