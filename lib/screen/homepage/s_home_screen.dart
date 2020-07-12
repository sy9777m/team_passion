import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team_passion/module/m_firebase.dart';
import 'package:team_passion/widget/w_home.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
            Consumer<FireBaseModule>(builder: (context, firebaseModule, child) {
          return StreamBuilder<QuerySnapshot>(
              stream: firebaseModule.loadGoalsSnapshot(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<Map<String, dynamic>> _goalDocumentList =
                    snapshot.data.documents.map((e) => e.data).toList();

                final DateFormat _dateFormat = DateFormat.yMMMd();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: _goalDocumentList.length,
                  itemBuilder: (context, i) {
                    return MyGoalCard(
                      title: _goalDocumentList[i]['title'],
                      deadLine: _dateFormat
                          .format(_goalDocumentList[i]['deadLine'].toDate()),
                    );
                  },
                );
              });
        }),
      ),
    );
  }
}
