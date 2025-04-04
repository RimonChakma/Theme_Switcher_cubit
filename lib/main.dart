import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main () {
  runApp(MyApp());
}

class ThemeState extends Equatable{
  final Brightness brightness;
  const ThemeState(this.brightness);

  @override
  List<Object> get props =>[brightness];
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit():super(ThemeState(Brightness.light));

  void ThemeChange () {
    emit(state.brightness == Brightness.light?
    ThemeState(Brightness.dark)
    :ThemeState(Brightness.light
    ));
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ThemeCubit(),
      child: BlocBuilder <ThemeCubit,ThemeState>  (builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ThemeSwitcherScreen(),
        theme: ThemeData(
          brightness: state.brightness
        ),
      );
    },),);
  }
}

class ThemeSwitcherScreen extends StatefulWidget {
  const ThemeSwitcherScreen({super.key});

  @override
  State<ThemeSwitcherScreen> createState() => _ThemeSwitcherScreenState();
}

class _ThemeSwitcherScreenState extends State<ThemeSwitcherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Theme Change"),centerTitle: true,),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.read<ThemeCubit>().ThemeChange();
            }, child: Text("change saves")
        ),
      ),);
  }
}
