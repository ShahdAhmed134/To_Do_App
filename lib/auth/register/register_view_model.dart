import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/auth/register/register_navigator.dart';

import '../../firebase_utils.dart';
import '../../model/user.dart';
import '../../provider/user_provider.dart';

class RegisterViewModel extends ChangeNotifier {
  /// hold data - handle logic
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  late RegisterNavigator navigator;

  void register(GlobalKey<FormState> formKey , UserAuthProvider authProvider) async {
    if (formKey.currentState?.validate() == true) {
      //todo: show loading
      navigator.showLoading();
      try {
        final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
         MyUser myUser = MyUser(
          id: credential.user!.uid ?? '',
          name: nameController.text,
          email: emailController.text);
        // Save to Firestore
        await FirebaseUtils.addUserToFireStore(myUser);

        // Update Provider
        authProvider.updateUser(myUser);

        //todo: hide loading
        navigator.hideLoading();
        //todo: show message
        navigator.showMessage('success');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          navigator.hideLoading();
          //todo: show message
          navigator.showMessage('weak password');

          ///  print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          //todo: hide loading
          navigator.hideLoading();
          //todo: show message
          navigator.showMessage('exists');

          /// print('The account already exists for that email.');
        } else if (e.code == 'network-request-failed') {
          //todo: hide loading
          navigator.hideLoading();
          //todo: show message
          navigator.showMessage('network');
        }
      } catch (e) {
        //todo: hide loading
        navigator.hideLoading();
        //todo: show message
        navigator.showMessage(e.toString());

        print(e);
      }
    }
  }
}
