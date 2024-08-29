// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_expense_tracker/models/user.dart' as m;
import 'package:personal_expense_tracker/provider/user_provider.dart';
import 'package:personal_expense_tracker/screens/home_screen.dart';
import 'package:personal_expense_tracker/utils/utils.dart';
import 'package:provider/provider.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //signUP
  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      showSnackBar(
        context: context,
        content: "You have succcesully created Account!\nPlease Sign In!",
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.toString());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  // SignIn
  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final res = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = m.User(
        uid: res.user!.uid,
        name: "",
        email: email,
        password: password,
      );
      userProvider.setUserByModel(user);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (_) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        context: context,
        content: e.toString(),
      );
    } catch (e) {
      showSnackBar(
        context: context,
        content: e.toString(),
      );
    }
  }
}
