import 'dart:io';

import 'package:confesion_de_fe_de_westminster/bloc/bloc_chapters.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_font.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_italic.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_refs.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_scroll.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_size.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_theme.dart';
import 'package:confesion_de_fe_de_westminster/main/index.dart';
import 'package:confesion_de_fe_de_westminster/theme/apptheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  //DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RefsBloc>(
          create: (context) => RefsBloc(),
        ),
        BlocProvider<ScrollBloc>(
          create: (context) => ScrollBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<FontBloc>(
          create: (context) => FontBloc(),
        ),
        BlocProvider<ItalicBloc>(
          create: (context) => ItalicBloc(),
        ),
        BlocProvider<SizeBloc>(
          create: (context) => SizeBloc(),
        ),
        BlocProvider<ChapterBloc>(
          create: (context) => ChapterBloc(),
        )
      ],
      child: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state) {
          return MaterialApp(
            locale: const Locale('es'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [
              Locale('en'), // English
              Locale('es'), // Spanish
            ],
            debugShowCheckedModeBanner: false,
            title: 'Westminster Confession',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state ? ThemeMode.light : ThemeMode.dark,
            home: const IndexPage(),
          );
        },
      ),
    );
  }
}
