import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_passion/module/m_firebase.dart';
import 'package:team_passion/screen/homepage/s_add_goal.dart';
import 'package:team_passion/screen/s_home.dart';
import 'package:team_passion/screen/s_log_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FireBaseModule>(
          create: (context) => FireBaseModule(),
        )
      ],
      child: MaterialApp(
        title: 'Team Passion',
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: LogInPage.id,
        routes: {
          Home.id: (context) => Home(),
          LogInPage.id: (context) => LogInPage(),
          AddGoalPage.id: (context) => AddGoalPage(),
        },
      ),
    );
  }
}
