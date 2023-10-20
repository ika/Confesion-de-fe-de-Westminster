import 'package:confesion_de_fe_de_westminster/cubit/cub_text.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_list.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:confesion_de_fe_de_westminster/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//MaterialColor? primarySwatch;
SharedPrefs sharedPrefs = SharedPrefs();

class TextSizePage extends StatefulWidget {
  const TextSizePage({Key? key}) : super(key: key);

  @override
  State<TextSizePage> createState() => _TextSizePageState();
}

class _TextSizePageState extends State<TextSizePage> {
  // @override
  // void initState() {
  //   primarySwatch =
  //       BlocProvider.of<SettingsCubit>(context).state.themeData.primaryColor as MaterialColor?;
  //   super.initState();
  // }

  backButton(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: Globals.navigatorDelay),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MList(),
          ),
        );
      },
    );
  }

  List<double> sizesList = [14, 16, 18, 20, 22, 24, 26, 28];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
        actions: const [],
        leading: GestureDetector(
          child: const Icon(Globals.backArrow),
          onTap: () {
            backButton(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.size,
          style: TextStyle(
              color: Colors.yellow,
              fontFamily: 'Raleway-Regular',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            for (int i = 0; i < sizesList.length; i++)
              InkWell(
                onTap: () {
                  double tsize = sizesList[i].toDouble();
                  sharedPrefs.setDoublePref('textSize', tsize).then((value) {
                    if (value) {
                      BlocProvider.of<TextSizeCubit>(context).setSize(tsize);
                      backButton(context);
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
                  height: 55,
                  color: Colors.yellow,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.example,
                      style: TextStyle(fontSize: sizesList[i]),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
