import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gatrabali/widgets/regency_news_card.dart';

class RegenciesNews extends StatefulWidget {
  @override
  _RegenciesNewsState createState() {
    return _RegenciesNewsState();
  }
}

class _RegenciesNewsState extends State<RegenciesNews> {
  @override
  Widget build(BuildContext ctx) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("entries")
          .orderBy("id", descending: true)
          .limit(10)
          .snapshots(),
      builder: (ctx, snapshots) {
        if (!snapshots.hasData) return LinearProgressIndicator();

        return _buildList(ctx, snapshots.data.documents);
      },
    );
  }
}

Widget _buildList(BuildContext ctx, List<DocumentSnapshot> docs) {
  return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      children: docs.map((doc) => _listItem(ctx, doc)).toList());
}

Widget _listItem(BuildContext ctx, DocumentSnapshot item) {
  Map<String, dynamic> data = item.data;
  //print("[${item.documentID}] ${data['title']} - ${data['enclosures']}");
  var hasImage = data["enclosures"] == null ? false : true;

  if (hasImage) {
    return Padding(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: RegencyNewsCard(key: ValueKey(item.documentID), data: data, regency: "Gianyar"),
    );
  }

  return Container();
}
