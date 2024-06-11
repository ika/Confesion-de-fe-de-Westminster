import 'package:confesion_de_fe_de_westminster/dort/model.dart';
import 'package:confesion_de_fe_de_westminster/dort/queries.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_font.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_italic.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_size.dart';
import 'package:confesion_de_fe_de_westminster/fonts/list.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// Dort

DortQueries dortQueries = DortQueries();

class DortPage extends StatefulWidget {
  const DortPage({super.key});

  @override
  DortPageState createState() => DortPageState();
}

class DortPageState extends State<DortPage> {

  List<Dort> paragraphs = List<Dort>.empty();

  // @override
  // void initState() {
  //   super.initState();
  //   primaryTextSize = BlocProvider.of<TextSizeCubit>(context).state;
  // }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as PrefPageArguments;

    return FutureBuilder<List<Dort>>(
      future: dortQueries.getParagraphs(),
      builder: (context, AsyncSnapshot<List<Dort>> snapshot) {
        if (snapshot.hasData) {
          paragraphs = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 5,
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              title: Text(AppLocalizations.of(context)!.dort,
                  style: const TextStyle(fontWeight: FontWeight.w700)
                  // style: const TextStyle(
                  //   color: Colors.yellow,
                  // ),
                  ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: paragraphs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      paragraphs[index].h!,
                      style: TextStyle(
                          fontFamily: fontsList[context.read<FontBloc>().state],
                          fontWeight: FontWeight.w700,
                          fontStyle: (context.read<ItalicBloc>().state)
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: context.read<SizeBloc>().state),
                    ),
                    subtitle: Text(
                      paragraphs[index].t!,
                      style: TextStyle(
                          fontFamily: fontsList[context.read<FontBloc>().state],
                          fontStyle: (context.read<ItalicBloc>().state)
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: context.read<SizeBloc>().state),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
