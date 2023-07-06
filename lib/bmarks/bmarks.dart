import 'package:confesion_de_fe_de_westminster/bmarks/bmModel.dart';
import 'package:confesion_de_fe_de_westminster/bmarks/bmQueries.dart';
import 'package:flutter/material.dart';

final BMQueries bmQueries = BMQueries();

class Bmarks extends StatefulWidget {
  const Bmarks({super.key});

  @override
  State<Bmarks> createState() => _BmarksState();
}

class _BmarksState extends State<Bmarks> {
  List<BMModel> bmarklist = List<BMModel>.empty();

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
                  title: const Text('Marcadores'),
                ),
                body: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: bmarklist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 2.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          // leading: Container(
                          //   padding: EdgeInsets.only(right: 12.0),
                          //   decoration: new BoxDecoration(
                          //       border: new Border(
                          //           right: new BorderSide(width: 1.0, color: Colors.white24))),
                          //   child: Icon(Icons.autorenew, color: Colors.white),
                          // ),
                          title: Text(
                            bmarklist[index].title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              const Icon(Icons.linear_scale,
                                  color: Colors.yellowAccent),
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
                            // Future.delayed(
                            //   const Duration(milliseconds: 200),
                            //   () {
                            //     Navigator.push(
                            //       context,
                            //       CupertinoPageRoute(
                            //         builder: (context) =>
                            //             (r == 0) ? ADetailPage(index) : ADetailPage(index),
                            //       ),
                            //     );
                            //   },
                            // );
                          },
                        ),
                      ),
                    );
                  },
                ));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
