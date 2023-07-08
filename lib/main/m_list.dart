import 'package:confesion_de_fe_de_westminster/bmarks/bm_page.dart';
import 'package:confesion_de_fe_de_westminster/main/db_queries.dart';
import 'package:confesion_de_fe_de_westminster/main/m_model.dart';
import 'package:confesion_de_fe_de_westminster/main/m_page.dart';
import 'package:confesion_de_fe_de_westminster/text/tx_page.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

int r = 0;
DbQueries _dbQueries = DbQueries();

// Future<int> _read() async {
//   final prefs = await SharedPreferences.getInstance();
//   final key = 'routs';
//   return prefs.getInt(key) ?? 0;
// }

// _save(int r) async {
//   final prefs = await SharedPreferences.getInstance();
//   final key = 'routs';
//   final value = r;
//   prefs.setInt(key, value);
// }

class MList extends StatefulWidget {
  const MList({Key? key}) : super(key: key);

  @override
  MainListState createState() => MainListState();
}

class MainListState extends State<MList> {
  List<Chapter> chapters = List<Chapter>.empty();

  // @override
  // void initState() {
  //   super.initState();

  //   r = 0;
  // }

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
    await Share.share(
        'La Confesión de Fe de Westminster https://play.google.com/store/apps/details?id=org.armstrong.ika.confesion_de_fe_de_westminster');
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
              const Duration(milliseconds: 200),
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
      title: const Text('Confesión de Westminster'),
      // actions: <Widget>[
      //  IconButton(
      //    icon: Icon(Icons.list_sharp),
      //    onPressed: () {},
      //  )
      // ],
    );

    final theDrawer = Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 120.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(64, 75, 96, .9),
              ),
              child: Baseline(
                baseline: 50,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  'Índice',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontFamily: 'Raleway-Regular',
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: const Text(
              'Marcadores',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
              ),
            ),
            dense: true,
            onTap: () => {
              Future.delayed(
                const Duration(milliseconds: 200),
                () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const BmPage()));
                },
              ),
            },
          ),
                    ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: const Text(
              'Tamano del texto',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
              ),
            ),
            dense: true,
            onTap: () => {
              Future.delayed(
                const Duration(milliseconds: 200),
                () {
                  //Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const TextSizePage()));
                },
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: const Text(
              'Comparte esta aplicación',
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
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
