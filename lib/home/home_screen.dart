import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/auth/login/login_screen.dart';
import 'package:to_do_app/home/setting_tab/setting_tab.dart';
import 'package:to_do_app/provider/app_config_provider.dart';
import 'package:to_do_app/provider/list_provider.dart';
import 'package:to_do_app/provider/user_provider.dart';
import 'package:to_do_app/home/show_info.dart';

import '../l10n/app_localizations.dart';
import 'list_tab/AddTask.dart';
import 'list_tab/list_tab.dart';

class HomeScreen extends StatefulWidget {
static const String routeName ='home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  bool isContainerVisible=false;
  late AppProvider appProvider;
  @override
  Widget build(BuildContext context) {
     appProvider =Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          selectedIndex==0?
         'TASKIFY':
          AppLocalizations.of(context)!.setting,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: appProvider.modeApp==ThemeMode.light ?
              AppColors.whiteColor
                  :
              AppColors.blackColor
          ),
        ),

        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  isContainerVisible=!isContainerVisible;
                });
                /*listProvider.listTasks=[];
                authProvider.currentUser=null;
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);*/
              },
              icon: Icon(Icons.person,
                  color: appProvider.modeApp==ThemeMode.light ?
                  AppColors.whiteColor
                      :
                  AppColors.blackColor))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: appProvider.modeApp==ThemeMode.light ?
          AppColors.whiteColor
              :
          AppColors.blackColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.transparent
          ),
          child: SingleChildScrollView(
            child: Container(
              child: BottomNavigationBar(
                  currentIndex: selectedIndex,
                  onTap: (index) {
                    selectedIndex = index;
                    setState(() {});
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.list),
                        label: 'list'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: 'setting'),
                  ]),
            ),
          ),
        ),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              height: 45,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor,
                    blurRadius: 40,
                    spreadRadius: 5,
                    offset: const Offset(0, -3), // الشادو طالع لفوق
                  ),
                ],
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              showAddTaskBottomSheet();
            },
            backgroundColor: AppColors.primaryColor,
            child: const Icon(
              Icons.add,
              size: 32,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),

      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(
          Icons.add,
          size: 32,
          color: AppColors.whiteColor,
        ),
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.12,
            color: AppColors.primaryColor,
          ),
          tabs[selectedIndex],
          if(isContainerVisible)
          Positioned(
            right:appProvider.language=='ar'
            ? MediaQuery.of(context).size.width*0.41
                : 20,
              child: ShowInfo(),
          ),

        ],
      ),
    );
  }
  List<Widget> tabs = [
    ListTab(), SettingTab()
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:   appProvider.modeApp==ThemeMode.light ?
    AppColors.whiteColor
        :
        AppColors.blackColor,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: AddTask(),
            );
          },
        );
      },
      clipBehavior: Clip.antiAlias
    );
  }


}




