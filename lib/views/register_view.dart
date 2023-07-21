import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myjots/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //text editing controller
  late final TextEditingController _email;
  late final TextEditingController _password;

//create text editing controllers
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  //dispose controllers
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text(this.title)),
        appBar: AppBar(title: Text('Register')),
        body: FutureBuilder(
          //perform the initialization before building the widget
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration:
                        const InputDecoration(hintText: "Enter your email"),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "Enter desired password"),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        final userCred = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password);
                        print(userCred);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          print('Email already in use');
                        } else if (e.code == 'weak-password') {
                          print('Weak pass biatch');
                        } else if (e.code == 'network-request-failed') {
                          print("Network error");
                        }
                        print(e.code);
                      } catch (e) {
                        print(e.runtimeType);
                        print(e);
                      }
                    },
                    child: Text('Register'),
                  ),
                ]);
              default:
                return const Text('loading...');
            }
          },
        ));
  }
}
