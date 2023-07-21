import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myjots/firebase_options.dart';
import 'package:myjots/views/login_view.dart';
import 'package:myjots/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        themeMode: ThemeMode.system,
        // home: LoginView(),
        home: Scaffold(
          //   appBar: AppBar(title: const Text('HOme')),
          body: FutureBuilder(
              future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    print(FirebaseAuth.instance.currentUser);
                    return SafeArea(
                        child: Container(
                            width: double.infinity,
                            child: Card(
                              color: Theme.of(context).cardTheme.color,
                              child: SizedBox(
                                height: 200,
                                child: const Text('Card'),
                              ),
                            )));
                  default:
                    return const Text('loading....');
                }
              }),
        ));
  }
}

class CustomTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    // Dark mode theme
    scaffoldBackgroundColor: const Color(0xff131718),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFFCC4F4F),
    ),
    cardTheme: CardTheme(color: darkFolderCard.primary),
    // Add any other theme customization properties here
  );
  static ThemeData lightTheme = ThemeData.light().copyWith(
    // Light mode theme
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color(0xFFCC4F4F)), // red color
    // Add any other theme customization properties here
    cardTheme: CardTheme(color: lightFolderCard.primary),
  );
  static ColorScheme lightFolderCard = ColorScheme.light().copyWith(
    primary: const Color(0xfff0f2f2), // Light mode card color
  );
  static ColorScheme darkFolderCard = ColorScheme.dark().copyWith(
    primary: const Color(0xFF1B1E1E),
  );
}
