import 'package:confesion_de_fe_de_westminster/bkmarks/model.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_font.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_italic.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_scroll.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_size.dart';
import 'package:confesion_de_fe_de_westminster/creeds/model.dart';
import 'package:confesion_de_fe_de_westminster/creeds/queries.dart';
import 'package:confesion_de_fe_de_westminster/fonts/list.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:confesion_de_fe_de_westminster/utils/menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


// Preface

// class PrefPageArguments {
//   final int index;
//   PrefPageArguments(this.index);
// }

CreedsQueries creedsQueries = CreedsQueries();

class CreedsPage extends StatefulWidget {
  const CreedsPage({super.key});

  @override
  CreedsPageState createState() => CreedsPageState();
}

class CreedsPageState extends State<CreedsPage> {
  ItemScrollController initialScrollController = ItemScrollController();

  List<Creeds> paragraphs = List<Creeds>.empty();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(Duration(milliseconds: Globals.navigatorLongDelay), () {
          if (initialScrollController.isAttached) {
            initialScrollController.scrollTo(
              index: context.read<ScrollBloc>().state,
              duration: Duration(milliseconds: Globals.navigatorLongDelay),
              curve: Curves.easeInOutCubic,
            );
            // reset scroll index
            context.read<ScrollBloc>().add(
                  UpdateScroll(index: 0),
                );
          } else {
            debugPrint("initialScrollController in NOT attached");
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as PrefPageArguments;

    return FutureBuilder<List<Creeds>>(
      future: creedsQueries.getCreeds(),
      builder: (context, AsyncSnapshot<List<Creeds>> snapshot) {
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
              title: Text(AppLocalizations.of(context)!.creeds,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScrollablePositionedList.builder(
                itemCount: paragraphs.length,
                itemScrollController: initialScrollController,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      paragraphs[index].h,
                      style: TextStyle(
                          fontFamily: fontsList[context.read<FontBloc>().state],
                          fontWeight: FontWeight.w700,
                          fontStyle: (context.read<ItalicBloc>().state)
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: context.read<SizeBloc>().state),
                    ),
                    subtitle: Text(
                      paragraphs[index].t,
                      style: TextStyle(
                          fontFamily: fontsList[context.read<FontBloc>().state],
                          fontStyle: (context.read<ItalicBloc>().state)
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: context.read<SizeBloc>().state),
                    ),
                    onTap: () {
                      final model = BmModel(
                          title: AppLocalizations.of(context)!.creeds,
                          subtitle: paragraphs[index].t,
                          doc: 2, // Prefrences
                          page: 0, // not used
                          para: index);

                      //debugPrint(model.para.toString());

                      showPopupMenu(context, model);
                    },
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
