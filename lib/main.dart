import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numeric_converter/core/converter_service.dart';
import 'package:numeric_converter/presentation/bloc/home_bloc.dart';
import 'package:numeric_converter/presentation/cubit/home_cubit.dart';
import 'package:numeric_converter/presentation/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<HomeBloc>(
        //   create: (context) => HomeBloc(ConverterService()),
        // ),
                BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Numeric Converter',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
