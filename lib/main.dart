import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/auth/register/register_screen.dart';
import 'package:to_do_app/home/home_screen.dart';
import 'package:to_do_app/provider/app_config_provider.dart';
import 'package:to_do_app/provider/list_provider.dart';
import 'package:to_do_app/provider/user_provider.dart';
import 'package:to_do_app/theme_app.dart';

import 'auth/login/login_screen.dart';
import 'edit/edit_task.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,

  );
 /// await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (BuildContext context)=>ListProvider(),),
        ChangeNotifierProvider(create: (BuildContext context)=>UserAuthProvider()),
        ChangeNotifierProvider(create: (BuildContext context)=>AppProvider())

      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        EditTask.routeName:(context)=>EditTask(),

      },
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: appProvider.modeApp,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appProvider.language),

    );
  }

}
