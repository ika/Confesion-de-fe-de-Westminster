import 'package:confesion_de_fe_de_westminster/bmarks/bm_model.dart';
import 'package:confesion_de_fe_de_westminster/bmarks/bm_queries.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_list.dart';
import 'package:confesion_de_fe_de_westminster/main/ma_page.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:flutter/material.dart';

final BMQueries bmQueries = BMQueries();

class BmPage extends StatefulWidget {
  const BmPage({super.key});

  @override
  State<BmPage> createState() => _BmPageState();
}

Future confirmDialog(BuildContext context, arr) async {
  return showDialog(
    builder: (context) => AlertDialog(
      title: const Text('¿Eliminar este marcador?'), // title
      content: Text(arr[0]), // subtitle
      actions: [
        TextButton(
          child:
              const Text('Sí', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        TextButton(
          child:
              const Text('No', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    ),
    context: context,
  );
}

class _BmPageState extends State<BmPage> {
  List<BMModel> bmarklist = List<BMModel>.empty();

  void bMDeleterapper(BuildContext context, arr) {
    confirmDialog(context, arr).then((value) {
      if (value) {
        BMQueries().deleteBookMark(int.parse(arr[1])).then((value) {
          setState(() {});
        });
      }
    });
  }

  Widget bookMarksList(BuildContext context, bmarklist) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: bmarklist.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! > 0 || details.primaryVelocity! < 0) {
              var arr = List.filled(2, '');
              arr[0] = bmarklist[index].subtitle;
              arr[1] = bmarklist[index].id.toString();
              bMDeleterapper(context, arr);
            }
          },
          child: Card(
            elevation: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                title: Text(
                  bmarklist[index].title,
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
                          text: " ${bmarklist[index].subtitle}",
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0),
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(
                    Duration(milliseconds: Globals.navigatorDelay),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MPage(int.parse(bmarklist[index].pagenum)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BMModel>>(
      future: bmQueries.getBookMarkList(),
      builder: (context, AsyncSnapshot<List<BMModel>> snapshot) {
        if (snapshot.hasData) {
          bmarklist = snapshot.data!;
          return Scaffold(
            backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
            appBar: AppBar(
              elevation: 0.1,
              backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
              leading: GestureDetector(
                child: const Icon(Globals.backArrow),
                onTap: () {
                  backButton(context);
                },
              ),
              title: const Text('Marcadores'),
            ),
            body: bookMarksList(context, bmarklist),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
