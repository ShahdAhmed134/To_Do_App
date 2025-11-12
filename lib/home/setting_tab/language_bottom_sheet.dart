import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/provider/app_config_provider.dart';

import '../../l10n/app_localizations.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late AppProvider appProvider;
  @override
  Widget build(BuildContext context) {
     appProvider=Provider.of<AppProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal:MediaQuery.of(context).size.width*0.05,
          vertical: MediaQuery.of(context).size.height *0.04
      ),
      //color: Colors.cyan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              appProvider.changeLanguage('en');
            },
            child: appProvider.language == 'en'?
            selectedLanguage(AppLocalizations.of(context)!.english):
            unSelectedLanguage(AppLocalizations.of(context)!.english)
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *0.04,
          ),
          InkWell(
            onTap: (){
              appProvider.changeLanguage("ar");
            },
            child: appProvider.language == 'ar'?
            selectedLanguage(AppLocalizations.of(context)!.arabic):
            unSelectedLanguage(AppLocalizations.of(context)!.arabic)
          ),

        ],
      ),
    );
  }

  Widget selectedLanguage(String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: AppColors.primaryColor
            )),
        Icon(Icons.check,
          color: AppColors.primaryColor,)
      ],
    );
  }

  Widget unSelectedLanguage(String text){
    return  Text(text
      ,style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: appProvider.modeApp==ThemeMode.light ?
            AppColors.blackColor
                :
            AppColors.whiteColor
        ));
  }
}
