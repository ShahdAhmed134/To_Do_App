import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/provider/app_config_provider.dart';

import '../app_color.dart';
import '../firebase_utils.dart';
import '../l10n/app_localizations.dart';
import '../model/task.dart';
import '../provider/list_provider.dart';
import '../provider/user_provider.dart';

class EditTask extends StatefulWidget {
static const String routeName ='edit';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
var selectedDate =DateTime.now();

var titleController=TextEditingController();

var descController=TextEditingController();

late ListProvider listProvider;

var formKey= GlobalKey<FormState>();
late Task taskModel;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    taskModel = ModalRoute.of(context)!.settings.arguments as Task;
      titleController.text = taskModel.title ?? "";
      descController.text = taskModel.desc ?? "";
      selectedDate = taskModel.time ?? DateTime.now(); setState(() {
        setState(() {

        });
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of<ListProvider>(context);
    var appProvider =Provider.of<AppProvider>(context);
    //taskModel = ModalRoute.of(context)!.settings.arguments as Task;
/*if(titleController.text.isEmpty||descController.text.isEmpty||selectedDate==null){
///////  make problem   ////////
  titleController.text=taskModel.title??"";
  descController.text=taskModel.desc??"";
  selectedDate=taskModel.time??DateTime.now();
}*/


    return Scaffold(
     resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.12,
            color: AppColors.primaryColor,
          ),
          Container(
            margin: EdgeInsets.only(top:  MediaQuery.of(context).size.width*0.03),
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
                Text(AppLocalizations.of(context)!.edit,
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
                          controller: titleController,
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
                          controller: descController,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return 'Please enter description';}

                            return null;
                          },
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: appProvider.modeApp==ThemeMode.light ?
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
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                ElevatedButton(
                    onPressed: (){
                      editTask();

                    },
                    child: Text(AppLocalizations.of(context)!.save,
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
        ],
      ),

    );
  }

void ShowCalender()async {
  var chooseDate = await showDatePicker(
      context: context,
      initialDate:  DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365))
  );
  if(chooseDate != null) {
    selectedDate = chooseDate;
  }

  setState(() {

  });
}

void editTask() {
  DateTime now = DateTime.now();
  DateTime fullDateTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    now.hour,
    now.minute,
    now.second,
  );
  taskModel.title= titleController.text;
  taskModel.desc= descController.text;
  taskModel.time=fullDateTime;
  if (formKey.currentState!.validate()){
    var authProvider=Provider.of<UserAuthProvider>(context,listen: false);
    FirebaseUtils.editTask(authProvider.currentUser!.id!,taskModel)
        .then((value){
      ///print('added task successfully');
      listProvider.getAllTasks(authProvider.currentUser!.id!);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg:AppLocalizations.of(context)!.msgEdit,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
    })
        .timeout(
        Duration(seconds: 1),
        onTimeout: () {
          ///  print('added task successfully');
         listProvider.getAllTasks(authProvider.currentUser!.id!);
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg:AppLocalizations.of(context)!.msgEdit,
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
