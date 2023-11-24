import 'package:confesion_de_fe_de_westminster/bmarks/bm_page.dart';
import 'package:confesion_de_fe_de_westminster/cubit/cub_text.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_list.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_page.dart';
import 'package:confesion_de_fe_de_westminster/text/tx_page.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:confesion_de_fe_de_westminster/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

SharedPrefs sharedPrefs = SharedPrefs();

main() {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPrefs.getDoublePref('textSize').then((t) {
    Globals.initialTextSize = t ?? 16.0;
    runApp(const SpanishConfession());
  });
}

class SpanishConfession extends StatelessWidget {
  const SpanishConfession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TextSizeCubit>(
          create: (context) => TextSizeCubit()..getSize(),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('es'),
        debugShowCheckedModeBanner: false,
        title: 'Westminster Confession in Spanish',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(58, 66, 86, 1.0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: const MList(),
        initialRoute: '/main',
        routes: {
          '/main': (context) => const MList(),
          '/page': (context) => const MPage(),
          '/bookmarks': (context) => const BmPage(),
          '/textsize': (context) => const TextSize()
        },
      ),
    );
  }
}
