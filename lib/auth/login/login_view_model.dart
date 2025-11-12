import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/auth/login/login_navigator.dart';

import '../../firebase_utils.dart';
import '../../provider/user_provider.dart';

class LoginViewModel extends ChangeNotifier{
  /// hold data - handle logic
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  late LoginNavigator navigator;

  void login(GlobalKey<FormState> formState,UserAuthProvider authProvider )async{
    if(formState.currentState?.validate()==true){
      //todo: show Loading
      navigator.showLoading();
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        var user= await FirebaseUtils.getUserFromFireStore(credential.user!.uid??'');
        if(user==null){
          return;
        }
        authProvider.updateUser(user);
        //todo: hide loading
        navigator.hideLoading();
        //todo: show message
        navigator.showMessage('success');

      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo: hide loading
          navigator.hideLoading();
          //todo: show message
        navigator.showMessage('invalid');
          /// print('No user found for that email or Wrong Password.');
        }
        else if (e.code == 'network-request-failed') {
          //todo: hide loading
          navigator.hideLoading();
          //todo: show message
          navigator.showMessage('network');

        }
      }catch(e){

        //todo: hide loading
        navigator.hideLoading();
        //todo: show message
        navigator.showMessage(e.toString());

        print(e);
      }
    }
  }
}