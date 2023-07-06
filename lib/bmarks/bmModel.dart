
// Bookmarks Model

class BMModel {
  int? id;
  String title;
  String subtitle;
  String pagenum;

  BMModel({this.id, required this.title, required this.subtitle, required this.pagenum});

  // used when inserting data to the database
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'subtitle': subtitle, 'pagenum': pagenum};
  }
}
