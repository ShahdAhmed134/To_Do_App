
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/provider/app_config_provider.dart';

import 'l10n/app_localizations.dart';
class DialogUtils {
  static void showLoading(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context, listen: false);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appProvider.modeApp == ThemeMode.light
              ? AppColors.whiteColor
              : AppColors.backgroundDark,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  AppLocalizations.of(context)!.loading,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: appProvider.modeApp == ThemeMode.light
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showMassage({
    required BuildContext context,
    required String title,
    required String content,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    var appProvider = Provider.of<AppProvider>(context, listen: false);

    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      );
    }

    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      );
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appProvider.modeApp == ThemeMode.light
              ? AppColors.whiteColor
              : AppColors.backgroundDark,
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          content: Text(
            content,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
             color:  appProvider.modeApp == ThemeMode.light
                  ? AppColors.blackColor
                  : AppColors.whiteColor,
            ),
          ),
          actions: actions,
        );
      },
    );
  }
}
