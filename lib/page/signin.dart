import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/api/authentication.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Icon(
          Icons.people_sharp,
          size: 100.0,
        ),
      ),
    );

    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 200.0,
        ),
        logo,
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: "Password",
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        ElevatedButton(
          onPressed: () {
            context.read<AuthenticationService>().signIn(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
          },
          child: Text("Sign in"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
          ),
        )
      ]),
    );
  }
}

class SignInPage1 extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
          ),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: "Password",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<AuthenticationService>().signIn(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
          },
          child: Text("Sign in"),
        )
      ]),
    );
  }
}
