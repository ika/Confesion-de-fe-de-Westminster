import 'package:confesion_de_fe_de_westminster/bkmarks/model.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_scroll.dart';
import 'package:confesion_de_fe_de_westminster/dort/model.dart';
import 'package:confesion_de_fe_de_westminster/dort/queries.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_font.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_italic.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_size.dart';
import 'package:confesion_de_fe_de_westminster/fonts/list.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:confesion_de_fe_de_westminster/utils/menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Dort

DortQueries dortQueries = DortQueries();

late PageController? pageController;
int indexNumber = 0;

class DortPage extends StatefulWidget {
  const DortPage({super.key});

  @override
  State<DortPage> createState() => _DortPageState();
}

class _DortPageState extends State<DortPage> {
  ItemScrollController initialScrollController = ItemScrollController();

  List<Dort> paragraphs = List<Dort>.empty();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(Duration(milliseconds: Globals.navigatorLongDelay), () {
          if (initialScrollController.isAttached) {
            initialScrollController
                .scrollTo(
              index: indexNumber, //context.read<ScrollBloc>().state,
              duration: Duration(milliseconds: Globals.navigatorLongDelay),
              curve: Curves.easeInOutCubic,
            )
                .then((value) {
              // reset scrollto
              context.read<ScrollBloc>().add(
                    UpdateScroll(index: 0),
                  );
            });
          } else {
            debugPrint("initialScrollController is NOT attached");
          }
        });
      },
    );
  }

  itemScrollControllerSelector() {
    initialScrollController = ItemScrollController();
  }

  // void getPageController() {
  //   //pageController = PageController(initialPage: pageNumber);
  //   pageController =
  //       PageController(initialPage: context.read<ChapterBloc>().state);
  // }

  @override
  Widget build(BuildContext context) {
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
              child: ScrollablePositionedList.builder(
                itemCount: paragraphs.length,
                itemScrollController: initialScrollController,
                itemBuilder: (BuildContext context, int index) {
                  itemScrollControllerSelector();
                  return GestureDetector(
                    child: ListTile(
                      title: Text(
                        paragraphs[index].h!,
                        style: TextStyle(
                            fontFamily:
                                fontsList[context.read<FontBloc>().state],
                            fontWeight: FontWeight.w700,
                            fontStyle: (context.read<ItalicBloc>().state)
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontSize: context.read<SizeBloc>().state),
                      ),
                      subtitle: Text(
                        paragraphs[index].t!,
                        style: TextStyle(
                            fontFamily:
                                fontsList[context.read<FontBloc>().state],
                            fontStyle: (context.read<ItalicBloc>().state)
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontSize: context.read<SizeBloc>().state),
                      ),
                    ),
                    onTap: () {
                      final model = BmModel(
                          title: AppLocalizations.of(context)!.dort,
                          subtitle: paragraphs[index].t!,
                          doc: 4, // document one
                          page: 1,
                          para: index);

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
