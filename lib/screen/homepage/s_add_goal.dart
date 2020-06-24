import 'package:flutter/material.dart';
import 'package:team_passion/widget/w_add_goal_screen.dart';

class AddGoalPage extends StatefulWidget {
  static String id = './add_goal_page';

  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
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
                  child: Column(
                    children: <Widget>[
                      TextInputContainer(
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
                        labelText: '메모',
                        hintText: '메모',
                      ),
                      PickDeadlineButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
