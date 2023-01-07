import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notlaruyg/cubit/AnasayfaCubit.dart';
import 'package:notlaruyg/cubit/NotDetayCubit.dart';
import 'package:notlaruyg/cubit/NotKayitCubit.dart';
import 'package:notlaruyg/views/YuklemeSayfasi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AnasayfaCubit(),
        ),
        BlocProvider(
          create: (context) => NotKayitCubit(),
        ),
        BlocProvider(
          create: (context) => NotDetayCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Not Kaydet Ve Hesapla',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: YuklemeSayfasi(),
      ),
    );
  }
}
