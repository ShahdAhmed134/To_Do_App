import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/edit/edit_task.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/provider/user_provider.dart';
import '../../l10n/app_localizations.dart';

import '../../provider/app_config_provider.dart';
import '../../provider/list_provider.dart';

class AddListItem extends StatefulWidget {
  Task task;
  AddListItem({required this.task});

  @override
  State<AddListItem> createState() => _AddListItemState();
}

class _AddListItemState extends State<AddListItem> {
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = AppLocalizations.of(context)!;
  }
  @override
  Widget build(BuildContext context) {
    var listProvider=Provider.of<ListProvider>(context);
    var authProvider=Provider.of<UserAuthProvider>(context);
    var appProvider=Provider.of<AppProvider>(context);

    return Directionality(
      textDirection: appProvider.language=='ar'?
      TextDirection.ltr : TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15),
          color: AppColors.redColor,
        ),
        child: Slidable(
         // key: const ValueKey(0),  // dismissible: DismissiblePane(onDismissed: () {}),
          startActionPane:
          ActionPane(
            extentRatio: 0.24,
            motion: BehindMotion(),
            children:  [
              SlidableAction(
               padding: EdgeInsets.zero,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),
                bottomLeft:Radius.circular(10)
                ),
                onPressed: (context){
                  /// delete the task
                  FirebaseUtils.deletedTask(widget.task,authProvider.currentUser!.id!)
                  .then((value){
                    print('Task Deleted Successfully');
                    listProvider.getAllTasks(authProvider.currentUser!.id!);
                    if(mounted){
                    Fluttertoast.showToast(
                        msg:  localizations.msgDelete,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.primaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  })
                      .timeout(
                    const Duration(seconds: 1),
                     onTimeout: (){
                      listProvider.getAllTasks(authProvider.currentUser!.id!);
                      Fluttertoast.showToast(
                          msg:  localizations.msgDelete,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                     }
                  );
                },
                backgroundColor: AppColors.redColor,
                foregroundColor: AppColors.whiteColor,
                icon: Icons.delete,
                label: 'Delete',


              ),
            ],
          ),
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(EditTask.routeName,
              arguments: widget.task);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(15),
              color:  appProvider.modeApp==ThemeMode.light ?
              AppColors.whiteColor
                :
                AppColors.blackColor

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    color:  widget.task.isDone==false?
                    AppColors.primaryColor:
                        AppColors.greenColor,
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.009,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.task.title,
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color:
                              widget.task.isDone==false?
                              AppColors.primaryColor:
                              AppColors.greenColor,
                            ),),
                          Text(widget.task.desc,
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                color:  appProvider.modeApp==ThemeMode.light ?
                                AppColors.blackColor
                                    :
                                AppColors.whiteColor
                            )),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                               Icon(Icons.access_time,
                              size: 15,
                                  color:  appProvider.modeApp==ThemeMode.light ?
                                  AppColors.blackColor
                                      :
                                  AppColors.whiteColor),
                                const SizedBox( width: 7,),
                                Text(
                                  '${(widget.task.time.hour % 12 == 0 ? 12 : widget.task.time.hour % 12).toString().padLeft(2, '0')}:${widget.task.time.minute.toString().padLeft(2, '0')} ${widget.task.time.hour >= 12 ? 'PM' : 'AM'}',
                                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                      color:  appProvider.modeApp==ThemeMode.light ?
                                      AppColors.blackColor
                                          :
                                      AppColors.whiteColor
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      widget.task.isDone=!widget.task.isDone;
                      FirebaseUtils.editIsDone(authProvider.currentUser!.id!, widget.task);
                      setState(() {

                      });
                    },
                    child:  widget.task.isDone==false ?

                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height*0.005,
                          horizontal: MediaQuery.of(context).size.width*0.047,),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius:BorderRadius.circular(13) ),
                      child: const Icon(Icons.check,
                      color:AppColors.whiteColor,
                      size: 34,
                      ),
                    ):
                        Text('IsDone',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.greenColor
                        ),)
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
