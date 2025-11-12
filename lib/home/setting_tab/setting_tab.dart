import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/home/setting_tab/theme_bottom_sheet.dart';
import 'package:to_do_app/l10n/app_localizations.dart';
import 'package:to_do_app/provider/app_config_provider.dart';

import 'language_bottom_sheet.dart';


class SettingTab extends StatelessWidget {

late AppProvider appProvider;
  @override
  Widget build(BuildContext context) {
     appProvider =Provider.of<AppProvider>(context);
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal:MediaQuery.of(context).size.width*0.05,
          vertical: MediaQuery.of(context).size.height *0.04
        ),
    width: MediaQuery.of(context).size.width*0.9,
    height: MediaQuery.of(context).size.height*0.8,
    decoration: BoxDecoration(
    color: appProvider.modeApp==ThemeMode.light ?
    AppColors.whiteColor
        :
    AppColors.blackColor,
    borderRadius: BorderRadius.circular(15),

    ),
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.06,
        ),
        Text(AppLocalizations.of(context)!.language,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: appProvider.modeApp==ThemeMode.light ?
            AppColors.blackColor
                :
            AppColors.whiteColor
        )),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.02,
        ),
        InkWell(
          onTap: ()
          {
            showLanguageBottomSheet(context);
          },
          child: Container(
            //margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
            color: appProvider.modeApp==ThemeMode.light ?
    AppColors.whiteColor
        :
    AppColors.blackColor,
               borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appProvider.language=='en'?
                  AppLocalizations.of(context)!.english:
    AppLocalizations.of(context)!.arabic,
                style: TextStyle(
                    color: AppColors.primaryColor,
                ),),
                Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          ),
        ),


        SizedBox(
          height: MediaQuery.of(context).size.height*0.06,
        ),
        Text(AppLocalizations.of(context)!.mode,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: appProvider.modeApp==ThemeMode.light ?
              AppColors.blackColor
                  :
              AppColors.whiteColor
          )),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.02,
        ),
        InkWell(
          onTap: (){
            showThemeBottomSheet(context);
          },
          child: Container(
            //margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
            color: appProvider.modeApp==ThemeMode.light ?
    AppColors.whiteColor
        :
    AppColors.blackColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appProvider.modeApp==ThemeMode.light?
                AppLocalizations.of(context)!.light:
                AppLocalizations.of(context)!.dark,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),),
                Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          ),
        ),
   ]
    ));



  }
  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context,
        builder: (context)=> LanguageBottomSheet(),
      backgroundColor:   appProvider.modeApp==ThemeMode.light ?
      AppColors.whiteColor
          :
      AppColors.blackColor,
      clipBehavior: Clip.antiAlias,



    );
  }
  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context,
      builder: (context)=> ThemeBottomSheet(),
      clipBehavior: Clip.antiAlias,



    );
  }
}
