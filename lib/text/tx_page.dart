import 'package:confesion_de_fe_de_westminster/cubit/cub_textSize.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:confesion_de_fe_de_westminster/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

SharedPrefs sharedPrefs = SharedPrefs();

class TextSize extends StatefulWidget {
  const TextSize({Key? key}) : super(key: key);

  @override
  State<TextSize> createState() => _TextSizePageState();
}

class _TextSizePageState extends State<TextSize> {

  List<double> sizesList = [14, 16, 18, 20, 22, 24, 26, 28];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
        actions: const [],
        leading: GestureDetector(
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.yellow,
            ),
            onPressed: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.pushNamed(context, '/main');
                },
              );
            },
          ),
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
                      Future.delayed(
                        Duration(milliseconds: Globals.navigatorDelay),
                        () {
                          Navigator.pushNamed(context, '/main');
                        },
                      );
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
