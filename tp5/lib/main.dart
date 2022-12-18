import 'dart:html';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: MyTheme.defaultTheme,
      builder: (_, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo Login',
          theme: theme,
          home: const MyHomePage(title: 'Connexion'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final String emailPattern='^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$';
  bool isDark = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: ThemeSwitcher(
              builder: (context) => DayNightSwitcherIcon(
                  isDarkModeEnabled: isDark,
                  onStateChanged: (val) {
                    setState(() {
                      isDark = val;
                      isDark
                          ? ThemeSwitcher.of(context)
                              .changeTheme(theme: MyTheme.darkTheme)
                          : ThemeSwitcher.of(context)
                              .changeTheme(theme: MyTheme.defaultTheme);
                    });
                  }),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 30),
                    ),
                    Container(
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            hintText: "me@example.com",
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                            labelText: 'Adresse email'),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                            hintText: '***',
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                            labelText: 'Mot de passe'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid password!';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(email.text);
                              print(password.text);
                              print('success');
                            }
                          },
                          child: Text('Login')),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
