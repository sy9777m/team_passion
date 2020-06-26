import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_passion/module/m_firebase.dart';
import 'package:team_passion/widget/w_add_goal_screen.dart';

class AddGoalPage extends StatefulWidget {
  static String id = './add_goal_page';

  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      '목표 설정하기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
//                    TODO: make form
                    child: Consumer<FireBaseModule>(
                      builder: (context, firebaseModule, child) {
                        return Form(
                          child: Column(
                            children: <Widget>[
                              TextInputContainer(
                                onChange: (v) {
                                  firebaseModule.setTitle(v);
                                },
                                labelText: '타이틀',
                                hintText: '타이틀',
                              ),
//                      CardWidget(
//                        title: Text('다음 단계 추가하기'),
//                        icon: Icon(FontAwesomeIcons.plus),
//                        onTap: () {},
//                      ),

//                      CardWidget(
//                        title: Text('알람 설정'),
//                        icon: Icon(FontAwesomeIcons.clock),
//                      ),

//                      CardWidget(
//                        title: Text('반복 설정'),
//                        icon: Icon(FontAwesomeIcons.redo),
//                      ),

                              TextInputArea(
                                onChange: (v) {
                                  firebaseModule.setMemo(v);
                                },
                                labelText: '메모',
                                hintText: '메모',
                              ),
                              PickDeadlineButton(),
                              CreateGoalButton(
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text('Loading'),
                                          content: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      });

                                  await firebaseModule.createGoal();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
