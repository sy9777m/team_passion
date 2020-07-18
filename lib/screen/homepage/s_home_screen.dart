import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team_passion/module/m_firebase.dart';
import 'package:team_passion/widget/w_home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showComplete = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SingleChildScrollView(
            child: Consumer<FireBaseModule>(
              builder: (context, firebaseModule, child) {
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

                    final List<String> _goalIdList = snapshot.data.documents
                        .map((e) => e.documentID)
                        .toList();

                    final DateFormat _dateFormat = DateFormat.yMMMd();

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _goalDocumentList.length,
                      itemBuilder: (context, i) {
                        if (showComplete) {
                          return MyGoalCard(
                            onDismissed: (d) async {
                              await firebaseModule.deleteGoal(_goalIdList[i]);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    '${_goalDocumentList[i]['title']}을 삭제했습니다.'),
                              ));
                            },
                            key: Key(_goalIdList[i]),
                            icon: Icon(_goalDocumentList[i]['isDone']
                                ? FontAwesomeIcons.redo
                                : FontAwesomeIcons.check),
                            color: _goalDocumentList[i]['isDone']
                                ? Colors.grey
                                : Colors.white,
                            onPressed: () async {
                              await firebaseModule.cancelDone(_goalIdList[i]);
                            },
                            title: _goalDocumentList[i]['title'],
                            deadLine: _dateFormat.format(
                                _goalDocumentList[i]['deadLine'].toDate()),
                          );
                        } else {
                          return _goalDocumentList[i]['isDone']
                              ? Container()
                              : MyGoalCard(
                                  onDismissed: (d) async {
                                    await firebaseModule
                                        .deleteGoal(_goalIdList[i]);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          '${_goalDocumentList[i]['title']}을 삭제했습니다.'),
                                    ));
                                  },
                                  key: Key(_goalIdList[i]),
                                  icon: Icon(FontAwesomeIcons.check),
                                  onPressed: () async {
                                    await firebaseModule
                                        .doneGoal(_goalIdList[i]);
                                  },
                                  title: _goalDocumentList[i]['title'],
                                  deadLine: _dateFormat.format(
                                      _goalDocumentList[i]['deadLine']
                                          .toDate()),
                                );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                showComplete = !showComplete;
              });
            },
            child: Container(
              child: Text(
                showComplete ? '완료한 목표 감추기' : '완료한 목표 보기',
                textAlign: TextAlign.center,
              ),
              width: double.maxFinite,
            ),
          ),
        ],
      ),
    );
  }
}
