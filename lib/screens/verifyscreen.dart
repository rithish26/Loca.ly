import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser user;

  Timer timer;
  @override
  void initState() {
    getCurrentUser();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        user.sendEmailVerification();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('An Email has been sent to ${user.email}'),
    ));
  }

  Future<void> checkEmailVerified() async {
    user = await _auth.currentUser();
    await user.reload();
    if (user.isEmailVerified) {
      timer.cancel();
      Navigator.pushNamed(context, ChatScreen.id);
    }
  }
}
