import 'package:dan_notes_saver/db_handler.dart';
import 'package:dan_notes_saver/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model.dart';
class AddUpdateTask extends StatefulWidget {
  const AddUpdateTask({super.key});

  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
 DBhelper? dBhelper;
 final titleController = TextEditingController();
 final descController = TextEditingController();
 final fromkey = GlobalKey<FormState>();
 late Future<List<Model>> dataList;
 @override
 void initState() {
dBhelper = DBhelper();
  loadData();
    super.initState();
  }
  loadData() async{
   dataList = dBhelper!.getDatalist();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar( centerTitle: true,elevation: 0,
        title: Text('Add / Upadte Note',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,letterSpacing: 1),),),
  body: Padding(padding: EdgeInsets.only(top: 10),child: SingleChildScrollView(
    child: Column(children: [
      Form(key:fromkey ,child:Column(children: [Padding(padding: EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(keyboardType: TextInputType.multiline,controller: titleController,decoration: InputDecoration(border: OutlineInputBorder(),
    hintText: 'Note Title'),
    validator: (value){if(value!.isEmpty){return "enter Text";}
    return null;}
    ),)
      ,const SizedBox(height: 10,),Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(maxLines: null,minLines: 5,keyboardType: TextInputType.multiline,controller: descController,decoration: InputDecoration(border: OutlineInputBorder(),
              hintText: 'Note Dicription'),
              validator: (value){if(value!.isEmpty){return "enter Text";}
              return null;}
          ),)],) ),SizedBox(height: 40,),
      Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [Material(color: Colors.green,borderRadius: BorderRadius.circular(5),child: InkWell(onTap: (){
            if(fromkey.currentState!.validate()){
              dBhelper!.insert(Model(title: titleController.text,desc: descController.text,dateTime: DateFormat('ymd').add_jm().format(DateTime.now()).toString()));
Navigator.push(context,MaterialPageRoute(builder: (context)=> HomeScreen()));
titleController.clear();
descController.clear();
print('date added');
            }
          },child: Container(alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20,),
            padding: EdgeInsets.symmetric(horizontal: 10, ),
            height: 55,width: 120,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                boxShadow: [const BoxShadow(color: Colors.black12,blurRadius: 5,spreadRadius: 1)],),child: Text('Submit',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),),),),
            Material(color: Colors.red[800],borderRadius: BorderRadius.circular(5),child: InkWell(onTap: (){setState(() { titleController.clear();
              descController.clear();

            });},child: Container(alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20 ,),
              padding: EdgeInsets.symmetric(horizontal: 10,),
              height: 55,width: 120,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                boxShadow: [const BoxShadow(color: Colors.black12,blurRadius: 5,spreadRadius: 1)],),child: Text('Clear',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),),),)],
        ),
      )
    ],),
  ),),
    );


 }
}
