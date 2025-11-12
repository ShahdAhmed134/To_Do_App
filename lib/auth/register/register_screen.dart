import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/auth/custom_text_form_field.dart';
import 'package:to_do_app/auth/register/register_navigator.dart';
import 'package:to_do_app/auth/register/register_view_model.dart';
import 'package:to_do_app/dialog_utils.dart';
import 'package:to_do_app/home/home_screen.dart';
import 'package:to_do_app/provider/user_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/app_config_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator{
  GlobalKey<FormState> formState=GlobalKey();

  bool obscurePass=true;
  bool obscureConf=true;
  TextEditingController confirmController =TextEditingController();

  RegisterViewModel viewModel =RegisterViewModel();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    var appProvider =Provider.of<AppProvider>(context);

    return ChangeNotifierProvider(
      create: (context)=>viewModel,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
      
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                    colors:appProvider.modeApp==ThemeMode.light ?
                    [
                      AppColors.primaryColor,
                      AppColors.backgroundLight,
                    ]: [
                      AppColors.primaryColor,
                      AppColors.backgroundDark,
                    ]
                ),
              ),
            ),
            SingleChildScrollView(
      
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                    color : appProvider.modeApp==ThemeMode.light ?
                    AppColors.whiteColor
                        :
                    AppColors.backgroundDark
                ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Row(
      
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width:appProvider.language=='en'?
                          MediaQuery.of(context).size.width * 0.13    :
                          MediaQuery.of(context).size.width * 0.19,),
                        Text(
                          AppLocalizations.of(context)!.account,
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Form(
                      key: formState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(AppLocalizations.of(context)!.name,
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color:  appProvider.modeApp==ThemeMode.light ?
                                    Color(0xff6C7278)
                                        :
                                    Color(0xffc4c4c4)
                                )
                            ),
                          ),
                          CustomTextFormField(text: 'Shahd Ahmed',preIcon: Icon(Icons.person,color: Colors.grey,),
                            controller: viewModel.nameController,
                            validator:(text){
                            if(text == null ||text.trim().isEmpty){
                              return 'Enter Your Name';
                            }
                            return null;
                            },),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,top: 15),
                            child: Text(AppLocalizations.of(context)!.email,
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color:  appProvider.modeApp==ThemeMode.light ?
                                    Color(0xff6C7278)
                                        :
                                    Color(0xffc4c4c4)
                                )),
                          ),
                          CustomTextFormField(text: 'Shahd@example.com',preIcon: Icon(Icons.email_outlined,color: Colors.grey,),
                          keyboardType: TextInputType.emailAddress,
                            controller: viewModel.emailController,validator: (text){
      
                            if(text == null ||text.trim().isEmpty){
                              return 'Enter Your Email';
                            }
                            final bool emailValid =
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~!]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if(!emailValid){
                              return 'Enter a valid email';
                            }
                            return null;
                          },
      
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,top: 15),
                            child: Text(AppLocalizations.of(context)!.password,
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color:  appProvider.modeApp==ThemeMode.light ?
                                    Color(0xff6C7278)
                                        :
                                    Color(0xffc4c4c4)
                                )),
                          ),
                          CustomTextFormField(text: '******',
                            obscureText: obscurePass,
                            preIcon: Icon(Icons.lock_outline_rounded,color: Colors.grey,),
                          suffIcon: IconButton(
                            icon: Icon(
                              obscurePass ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePass = !obscurePass; // تقلب بين الإظهار والإخفاء
                              });
                            },
                          ),
                          controller: viewModel.passwordController,
                          validator: (text){
                            if(text == null ||text.trim().isEmpty){
                              return 'Enter Your Password';
                            }
                            if(text.length <6){
                              return 'Password Must be at least 6 character';
                            }
                            return null;
                          },),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,top: 15),
                            child: Text(AppLocalizations.of(context)!.confirm,
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color:  appProvider.modeApp==ThemeMode.light ?
                                    Color(0xff6C7278)
                                        :
                                    Color(0xffc4c4c4)
                                )),
                          ),
                          CustomTextFormField(text: '******',
                            obscureText: obscureConf,
                            preIcon: Icon(Icons.lock_outline_rounded,color: Colors.grey,),
                            suffIcon: IconButton(
                              icon: Icon(
                                obscureConf ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureConf = !obscureConf; // تقلب بين الإظهار والإخفاء
                                });
                              },
                            ),
                              controller: confirmController,
                              validator:   (text){
                              if(text == null ||text.trim().isEmpty){
                                return 'Enter Confirmation Password';
      
                              }
                              if(text != viewModel.passwordController.text)
                                return "Confirm password dosen't Match Password";
                              return null;
                            },),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.035,),
                          Padding(
      
                            padding: const EdgeInsets.all(12.0),
                            child: ElevatedButton(
                                onPressed: (){
                                  final authProvider = Provider.of<UserAuthProvider>(context, listen: false);
                                  viewModel.register(formState, authProvider);

                                },
                                child: Text(AppLocalizations.of(context)!.register),
                                style:ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                                foregroundColor: AppColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
      
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
      
          ],
        ),
      ),
    );
  }



  @override
  void hideLoading() {
    // TODO: implement hideLoading
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
    DialogUtils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
    if(message=='success'){
      DialogUtils.showMassage(context: context, title:AppLocalizations.of(context)!.success,
          content: AppLocalizations.of(context)!.registrationSuccess,
          posActionName: AppLocalizations.of(context)!.ok,
          posAction: (){
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          });
  }else if(message=='weak password'){
    //todo: show message
    DialogUtils.showMassage(context: context, title: AppLocalizations.of(context)!.error,
    content:AppLocalizations.of(context)!.weakPassword,
    posActionName: AppLocalizations.of(context)!.ok,
    );
  }else if(message=='exists'){
      DialogUtils.showMassage(context: context, title:AppLocalizations.of(context)!.error,
        content: AppLocalizations.of(context)!.accountExists,
        posActionName: AppLocalizations.of(context)!.ok,
      );
    }
    else if(message=='network'){
      /// print('The account already exists for that email.');
    }
    else if (message == 'network-request-failed') {
      DialogUtils.showMassage(context: context, title:AppLocalizations.of(context)!.error,
        content: AppLocalizations.of(context)!.networkError,
        posActionName:AppLocalizations.of(context)!.ok,
      );

    }
    else{
  DialogUtils.showMassage(context: context, title: AppLocalizations.of(context)!.error,
  content:message,
  posActionName: AppLocalizations.of(context)!.ok,
  );

    }
  }
}



