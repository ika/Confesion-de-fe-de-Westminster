import 'package:confesion_de_fe_de_westminster/bmarks/bm_page.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_queries.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_model.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_page.dart';
import 'package:confesion_de_fe_de_westminster/text/tx_page.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:confesion_de_fe_de_westminster/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

int r = 0;
DbQueries _dbQueries = DbQueries();
SharedPrefs sharedPrefs = SharedPrefs();

bool refs = true;

class MList extends StatefulWidget {
  const MList({Key? key}) : super(key: key);

  @override
  MainListState createState() => MainListState();
}

class MainListState extends State<MList> {
  List<Chapter> chapters = List<Chapter>.empty();

  @override
  void initState() {
    super.initState();

    sharedPrefs.getBoolPref('refs').then((value) {
      refs = (value == null) ? true : value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chapter>>(
        future: _dbQueries.getChapters(),
        builder: (context, AsyncSnapshot<List<Chapter>> snapshot) {
          if (snapshot.hasData) {
            chapters = snapshot.data!;
            return showChapterList(chapters, context);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  _onShareLink(BuildContext context) async {
    await Share.share(AppLocalizations.of(context)!.title +
        ' https://play.google.com/store/apps/details?id=org.armstrong.ika.confesion_de_fe_de_westminster');
  }

  showChapterList(List<Chapter> chapters, context) {
    ListTile makeListTile(chapters, int index) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          // leading: Container(
          //   padding: EdgeInsets.only(right: 12.0),
          //   decoration: new BoxDecoration(
          //       border: new Border(
          //           right: new BorderSide(width: 1.0, color: Colors.white24))),
          //   child: Icon(Icons.autorenew, color: Colors.white),
          // ),
          title: Text(
            chapters[index].chap,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              const Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: const StrutStyle(fontSize: 12.0),
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white),
                    text: " ${chapters[index].title}",
                  ),
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          onTap: () {
            Future.delayed(
              Duration(milliseconds: Globals.navigatorDelay),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MPage(index),
                  ),
                );
              },
            );
          },
        );

    Card makeCard(chapters, int index) => Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(chapters, index),
          ),
        );

    final makeBody = ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: chapters.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(chapters, index);
      },
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
      title: Text(
        AppLocalizations.of(context)!.title,
        style: TextStyle(
            color: Colors.yellow,
            fontFamily: 'Raleway-Regular',
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );

    final theDrawer = Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(64, 75, 96, .9),
              ),
              child: Baseline(
                baseline: 50,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  AppLocalizations.of(context)!.index,
                  style: TextStyle(
                      color: Colors.yellow,
                      fontFamily: 'Raleway-Regular',
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              AppLocalizations.of(context)!.bookmarks,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            dense: true,
            onTap: () => {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BmPage(),
                    ),
                  );
                },
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              (refs)
                  ? AppLocalizations.of(context)!.withrefs
                  : AppLocalizations.of(context)!.withoutrefs,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            dense: true,
            onTap: () => {
              (refs) ? refs = false : refs = true,
              sharedPrefs.setBoolPref('refs', refs).then((value) {
                setState(() {
                  refs;
                });
              }),
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              AppLocalizations.of(context)!.size,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            dense: true,
            onTap: () => {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  //Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TextSizePage(),
                    ),
                  );
                },
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              AppLocalizations.of(context)!.share,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            dense: true,
            onTap: () => {Navigator.pop(context), _onShareLink(context)},
          ),
        ],
      ),
    );

    return Scaffold(
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        appBar: topAppBar,
        drawer: theDrawer,
        body: makeBody);
  }
}
