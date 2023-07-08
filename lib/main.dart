import 'package:confesion_de_fe_de_westminster/cubit/cub_text.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:confesion_de_fe_de_westminster/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main/ma_list.dart';

SharedPrefs sharedPrefs = SharedPrefs();

main() {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPrefs.getDoublePref('textSize').then((t) {
    Globals.initialTextSize = t;
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TextSizeCubit>(
          create: (context) => TextSizeCubit()..getSize(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Westminster Confession in Spanish',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(58, 66, 86, 1.0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MList(),
      ),
    );
  }
}
