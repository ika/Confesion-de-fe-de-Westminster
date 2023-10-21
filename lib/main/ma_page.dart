import 'package:confesion_de_fe_de_westminster/bmarks/bm_model.dart';
import 'package:confesion_de_fe_de_westminster/bmarks/bm_queries.dart';
import 'package:confesion_de_fe_de_westminster/cubit/cub_text.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_queries.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_list.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_model.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Plain Text

final DbQueries _dbQueries = DbQueries();
final BMQueries _bmQueries = BMQueries();

int index = 0;
double? primaryTextSize;

class MPage extends StatefulWidget {
  MPage(int idx, {Key? key}) : super(key: key) {
    index = idx;
  }

  @override
  MPageState createState() => MPageState();
}

void bMWrapper(BuildContext context, arr) {
  _bmQueries.getBookMarkExists(int.parse(arr[4])).then((value) {
    if (value < 1) {
      confirmDialog(context, arr).then((value) {
        if (value) {
          final model = BMModel(
              title: arr[0].toString(),
              subtitle: arr[1].toString(),
              pagenum: arr[2]);
          _bmQueries.saveBookMark(model).then(
            (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.added),
                ),
              );
            },
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.exists),
        ),
      );
    }
  });
}

Future confirmDialog(BuildContext context, arr) async {
  return showDialog(
    builder: (context) => AlertDialog(
      title: Text(arr[3]), // title
      content: Text(arr[1]), // subtitle
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.yes,
              style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.no,
              style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    ),
    context: context,
  );
}

class MPageState extends State<MPage> {
  List<Chapter> chapters = List<Chapter>.empty();

  @override
  void initState() {
    super.initState();
    primaryTextSize = BlocProvider.of<TextSizeCubit>(context).state;
    //debugPrint("PRIMARY TEXT SIZE $primaryTextSize");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chapter>>(
      future: _dbQueries.getChapters(),
      builder: (context, AsyncSnapshot<List<Chapter>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          return showChapters(chapters, index, context);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

Widget showChapters(chapters, index, context) {
  String heading = AppLocalizations.of(context)!.question;

  PageController pageController =
      PageController(initialPage: chapters[index].id);

  final html = Style(
    backgroundColor: Colors.white30,
    padding: HtmlPaddings.all(15),
    fontFamily: 'Raleway-Regular',
    fontSize: FontSize(primaryTextSize!),
  );

  final h2 = Style(fontSize: FontSize(primaryTextSize! + 2));
  final h3 = Style(fontSize: FontSize(primaryTextSize!));
  final a =
      Style(fontSize: FontSize(14.0), textDecoration: TextDecoration.none);

  final page0 = Html(
    data: chapters[0].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page1 = Html(
    data: chapters[1].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page2 = Html(
    data: chapters[2].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page3 = Html(
    data: chapters[3].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page4 = Html(
    data: chapters[4].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page5 = Html(
    data: chapters[5].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page6 = Html(
    data: chapters[6].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page7 = Html(
    data: chapters[7].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page8 = Html(
    data: chapters[8].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page9 = Html(
    data: chapters[9].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page10 = Html(
    data: chapters[10].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page11 = Html(
    data: chapters[11].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page12 = Html(
    data: chapters[12].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page13 = Html(
    data: chapters[13].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page14 = Html(
    data: chapters[14].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page15 = Html(
    data: chapters[15].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page16 = Html(
    data: chapters[16].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page17 = Html(
    data: chapters[17].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page18 = Html(
    data: chapters[18].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page19 = Html(
    data: chapters[19].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page20 = Html(
    data: chapters[20].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page21 = Html(
    data: chapters[21].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page22 = Html(
    data: chapters[22].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page23 = Html(
    data: chapters[23].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page24 = Html(
    data: chapters[24].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page25 = Html(
    data: chapters[25].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page26 = Html(
    data: chapters[26].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page27 = Html(
    data: chapters[27].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page28 = Html(
    data: chapters[28].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page29 = Html(
    data: chapters[29].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page30 = Html(
    data: chapters[30].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page31 = Html(
    data: chapters[31].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

  final page32 = Html(
    data: chapters[32].text,
    style: {"html": html, "h2": h2, "h3": h3, "a": a},
  );

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

  topAppBar(context) => AppBar(
        elevation: 0.1,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        leading: GestureDetector(
          child: const Icon(Globals.backArrow),
          onTap: () {
            backButton(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.title,
          style: TextStyle(
              color: Colors.yellow,
              fontFamily: 'Raleway-Regular',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark_outline_sharp,
              color: Colors.yellow,
            ),
            onPressed: () {
              int pg = pageController.page!.toInt();
              //int sp = pg + 1;
              var arr = List.filled(5, '');

              _dbQueries.getChapterInfo(pg).then(
                    (value) => {
                      arr[0] = value[0].chap!,
                      arr[1] = value[0].title!,
                      arr[2] = pg.toString(),
                      arr[3] = heading,
                      arr[4] = pg.toString(),
                      bMWrapper(context, arr)
                    },
                  );
            },
          ),
        ],
      );

  return Scaffold(
    appBar: topAppBar(context),
    body: PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      children: [
        SingleChildScrollView(
          child: page0,
        ),
        SingleChildScrollView(
          child: page1,
        ),
        SingleChildScrollView(
          child: page2,
        ),
        SingleChildScrollView(
          child: page3,
        ),
        SingleChildScrollView(
          child: page4,
        ),
        SingleChildScrollView(
          child: page5,
        ),
        SingleChildScrollView(
          child: page6,
        ),
        SingleChildScrollView(
          child: page7,
        ),
        SingleChildScrollView(
          child: page8,
        ),
        SingleChildScrollView(
          child: page9,
        ),
        SingleChildScrollView(
          child: page10,
        ),
        SingleChildScrollView(
          child: page11,
        ),
        SingleChildScrollView(
          child: page12,
        ),
        SingleChildScrollView(
          child: page13,
        ),
        SingleChildScrollView(
          child: page14,
        ),
        SingleChildScrollView(
          child: page15,
        ),
        SingleChildScrollView(
          child: page16,
        ),
        SingleChildScrollView(
          child: page17,
        ),
        SingleChildScrollView(
          child: page18,
        ),
        SingleChildScrollView(
          child: page19,
        ),
        SingleChildScrollView(
          child: page20,
        ),
        SingleChildScrollView(
          child: page21,
        ),
        SingleChildScrollView(
          child: page22,
        ),
        SingleChildScrollView(
          child: page23,
        ),
        SingleChildScrollView(
          child: page24,
        ),
        SingleChildScrollView(
          child: page25,
        ),
        SingleChildScrollView(
          child: page26,
        ),
        SingleChildScrollView(
          child: page27,
        ),
        SingleChildScrollView(
          child: page28,
        ),
        SingleChildScrollView(
          child: page29,
        ),
        SingleChildScrollView(
          child: page30,
        ),
        SingleChildScrollView(
          child: page31,
        ),
        SingleChildScrollView(
          child: page32,
        )
      ],
    ),
  );
}
