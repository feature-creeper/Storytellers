import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/view-controllers/signin.dart';
import 'package:storytellers/view-model/saved_books_provider.dart';
import 'package:storytellers/view-model/signin_view-model.dart';
import 'view-controllers/navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool signedIn = false;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          signedIn = false;
        });
      } else {
        print('User is signed in!');
        setState(() {
          signedIn = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storytellers',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.heeboTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: signedIn
          ? ChangeNotifierProvider(
              create: (_) => SavedBooksProvider(), child: NavigationBar())
          : ChangeNotifierProvider(
              create: (_) => SigninViewModel(),
              builder: (context, child) => Signin()),
    );
  }
}
