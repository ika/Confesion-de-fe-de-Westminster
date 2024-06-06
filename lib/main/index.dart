import 'package:confesion_de_fe_de_westminster/about/page.dart';
import 'package:confesion_de_fe_de_westminster/bkmarks/page.dart';
import 'package:confesion_de_fe_de_westminster/bloc/bloc_chapters.dart';
import 'package:confesion_de_fe_de_westminster/creeds/page.dart';
import 'package:confesion_de_fe_de_westminster/dort/page.dart';
import 'package:confesion_de_fe_de_westminster/fonts/fonts.dart';
import 'package:confesion_de_fe_de_westminster/main/page.dart';
import 'package:confesion_de_fe_de_westminster/shorter/page.dart';
import 'package:confesion_de_fe_de_westminster/theme/theme.dart';
import 'package:confesion_de_fe_de_westminster/utils/globals.dart';
import 'package:confesion_de_fe_de_westminster/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<String> tableIndex = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  drawerCode() {
    return Drawer(
      //backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 200.0,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                  //color: Theme.of(context).colorScheme.inversePrimary
                  ),
              child: Baseline(
                baseline: 80,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  'Index',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.bookmarks,
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BMMarksPage(),
                    ),
                  );
                },
              );
            },
          ),
          // ListTile(
          //   trailing: Icon(
          //     Icons.keyboard_double_arrow_right,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          //   title: Text(
          //     'Preface',
          //     style: Theme.of(context).textTheme.bodyLarge,
          //     // style: TextStyle(
          //     //   color: Colors.black87,
          //     //   fontFamily: 'Raleway-Regular',
          //     //   fontSize: 16,
          //     // ),
          //   ),
          //   dense: true,
          //   onTap: () {
          //     // Future.delayed(
          //     //   Duration(milliseconds: Globals.navigatorDelay),
          //     //   () {
          //     //     Navigator.push(
          //     //       context,
          //     //       MaterialPageRoute(
          //     //         builder: (context) => const PrefPage(),
          //     //       ),
          //     //     );
          //     //   },
          //     // );
          //   },
          // ),
          // ListTile(
          //   trailing: Icon(
          //     Icons.keyboard_double_arrow_right,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          //   title: Text(
          //     'Five Points',
          //     style: Theme.of(context).textTheme.bodyLarge,
          //     // style: TextStyle(
          //     //   color: Colors.black87,
          //     //   fontFamily: 'Raleway-Regular',
          //     //   fontSize: 16,
          //     // ),
          //   ),
          //   dense: true,
          //   onTap: () {
          //     // Future.delayed(
          //     //   Duration(milliseconds: Globals.navigatorDelay),
          //     //   () {
          //     //     Navigator.push(
          //     //       context,
          //     //       MaterialPageRoute(
          //     //         builder: (context) => const PointsPage(),
          //     //       ),
          //     //     );
          //     //   },
          //     // );
          //   },
          // ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.creeds,
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreedsPage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.catechism,
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShorterPage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.dort,
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DortPage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.fonts,
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FontsPage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThemePage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              AppLocalizations.of(context)!.about,
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutPage(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // reset chapter
    // context.read<ChapterBloc>().add(
    //       UpdateChapter(chapter: 1),
    //     );
    return FutureBuilder<List<String>>(
      future: Utils().getTableIndex(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          tableIndex = snapshot.data!;
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              elevation: 5,
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                    );
                  },
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.index,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            drawer: drawerCode(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ListView.separated(
                  itemCount: tableIndex.length,
                  itemBuilder: (BuildContext context, int index) {
                    int num = index + 1;
                    String chap =
                        '${AppLocalizations.of(context)!.chapter} $num:';
                    return ListTile(
                      title: Text(
                        chap,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.linear_scale,
                              color: Theme.of(context).colorScheme.primary),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: " ${tableIndex[index]}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          )
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20.0),
                      onTap: () {
                        context
                            .read<ChapterBloc>()
                            .add(UpdateChapter(chapter: index));
                        Future.delayed(
                          Duration(milliseconds: Globals.navigatorDelay),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConfPage(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
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
