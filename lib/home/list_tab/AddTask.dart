import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/provider/app_config_provider.dart';
import 'package:to_do_app/provider/list_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/user_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}
var selectedDate =DateTime.now();
String title='';
String desc='';
late ListProvider listProvider;
var formKey= GlobalKey<FormState>();
class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of<ListProvider>(context);
    var appProvider =Provider.of<AppProvider>(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           Text(AppLocalizations.of(context)!.newTask,
           textAlign: TextAlign.center,
             style: Theme.of(context).textTheme.titleSmall!.copyWith(
                 color: appProvider.modeApp==ThemeMode.light ?
                 AppColors.blackColor
                     :
                 AppColors.whiteColor
             ),
           ),
           SizedBox(
             height: MediaQuery.of(context).size.height*0.02,
           ),
           Form(
             key: formKey,
               child:Column(
                 children: [
                   TextFormField(
                     onChanged: (text){
                       title=text;
                     },
                     validator: (value){
                       if(value==null || value.isEmpty){
                         return 'Please enter title';}

                       return null;
                     },
                     style: Theme.of(context).textTheme.labelMedium!.copyWith(
                         color: appProvider.modeApp==ThemeMode.light ?
                         AppColors.blackColor
                             :
                         AppColors.whiteColor
                     ),
                     decoration: InputDecoration(
                       hintText: AppLocalizations.of(context)!.enterTask,
                       hintStyle:  Theme.of(context).textTheme.labelMedium,
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: AppColors.primaryColor,
                         ),

                       ),
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: AppColors.primaryColor,
                         ),

                       ),
                     ),

                   ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height*0.02,
                   ),
                   TextFormField(
                     onChanged: (text){
                       desc=text;
                     },
                     validator: (value){
                       if(value==null || value.isEmpty){
                         return 'Please enter description';}

                       return null;
                     },
                     style: Theme.of(context).textTheme.labelMedium!.copyWith(
                       color:  appProvider.modeApp==ThemeMode.light ?
                     AppColors.blackColor
                         :
                         AppColors.whiteColor
                     ),
                     decoration: InputDecoration(
                       hintText: AppLocalizations.of(context)!.enterDesc,
                       hintStyle:  Theme.of(context).textTheme.labelMedium,
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: AppColors.primaryColor,
                         ),

                       ),
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: AppColors.primaryColor,
                         ),

                       ),

                     ),
                   ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height*0.02,
                   ),

                 ],
               ) ),
           Text(AppLocalizations.of(context)!.time,
             //textAlign: TextAlign.start,
             style: Theme.of(context).textTheme.labelLarge!.copyWith(
                 color: appProvider.modeApp==ThemeMode.light ?
                 AppColors.blackColor
                     :
                 AppColors.whiteColor
             ),
           ),
           TextButton(
               onPressed: (){
                 ShowCalender();
               }, child:
           Text(
             '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ',
             style: Theme.of(context).textTheme.labelLarge!.copyWith(
                 color: appProvider.modeApp==ThemeMode.light ?
                 AppColors.blackColor
                     :
                 AppColors.whiteColor
             ),
           ),
           ),
           ElevatedButton(
               onPressed: (){
                 addTaskBottomSheet();

               },
               child: Text(AppLocalizations.of(context)!.add,
               style: TextStyle(
                 color: AppColors.whiteColor,
                 fontSize: 20
               ),),
             style:ElevatedButton.styleFrom(
               backgroundColor: AppColors.primaryColor
             )
           )
         ],
       ),
      ),
    );
  }

  void ShowCalender()async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if(chooseDate != null) {
      selectedDate = chooseDate;
    }

    setState(() {

    });
  }

  void addTaskBottomSheet() {
    DateTime now = DateTime.now();
    DateTime fullDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      now.hour,
      now.minute,
      now.second,
    );
    Task task = Task(title: title, desc: desc, time: fullDateTime);
    if (formKey.currentState!.validate()){
      var authProvider=Provider.of<UserAuthProvider>(context,listen: false);
      FirebaseUtils.addTaskToFireStore(task,authProvider.currentUser!.id!)
          .then((value){
        ///print('added task successfully');
        listProvider.getAllTasks(authProvider.currentUser!.id!);
        Fluttertoast.showToast(
            msg:AppLocalizations.of(context)!.msgSuccess,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pop(context);

      })
          .timeout(
          Duration(seconds: 1),
          onTimeout: () {
          ///  print('added task successfully');
            listProvider.getAllTasks(authProvider.currentUser!.id!);
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg:AppLocalizations.of(context)!.msgSuccess,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: AppColors.primaryColor,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
      );

  }
  }


}
