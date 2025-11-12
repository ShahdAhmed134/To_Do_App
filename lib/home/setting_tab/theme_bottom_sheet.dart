import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/provider/app_config_provider.dart';

import '../../l10n/app_localizations.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  late AppProvider appProvider;
  @override
  Widget build(BuildContext context) {
     appProvider=Provider.of<AppProvider>(context);
    return Container(
      color:  appProvider.modeApp==ThemeMode.light ?
      AppColors.whiteColor
          :
      AppColors.backgroundDark,
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
              appProvider.changeTheme(ThemeMode.light);
            },
            child: appProvider.modeApp==ThemeMode.light?
            selectedLanguage(AppLocalizations.of(context)!.light):
            unSelectedLanguage(AppLocalizations.of(context)!.light)
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *0.04,
          ),
          InkWell(
            onTap: (){
              appProvider.changeTheme(ThemeMode.dark);
            },
              child: appProvider.modeApp==ThemeMode.dark?
              selectedLanguage(AppLocalizations.of(context)!.dark):
              unSelectedLanguage(AppLocalizations.of(context)!.dark)
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
