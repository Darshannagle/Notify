
import 'package:dan_notes_saver/db_handler.dart';
import 'package:flutter/material.dart';

import 'model.dart';
class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
DBhelper? dBhelper;
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
    return Scaffold(

      appBar: AppBar( centerTitle: true,elevation: 0,
       title:  Text('DAN_Notes',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,letterSpacing: 1),),actions: [Padding(padding: EdgeInsets.only(right: 10),child: Icon(Icons.help_center_rounded,size: 30,),)],),
  body: Column(children: [Expanded(child:FutureBuilder(
    builder: (context,AsyncSnapshot<List<Model>> snapshot){
      if(!(snapshot.hasData)|| snapshot.data==null){
        return Center(child: CircularProgressIndicator(),);
      }
      else if(snapshot.data!.length==0){
        return Center(child: Text("Empty",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),);
      }
      else {
        return ListView.builder(shrinkWrap: true,itemCount:snapshot.data!.length ,itemBuilder: (context,index) {
          int toID = snapshot.data![index].id!.toInt();
          String toTitle = snapshot.data![index].title!.toString();
          String toDesc = snapshot.data![index].desc!.toString();
          String toDT = snapshot.data![index].dateTime!.toString();
          return Dismissible(key: ValueKey<int>(toID),direction: DismissDirection.endToStart, background: Container(color: Colors.red[600],child: Icon(Icons.delete,color: Colors.white,),),onDismissed: (DismissDirection direction){
            setState(() {
dBhelper!.delete(toID);
dataList= dBhelper!.getDatalist();
snapshot.data!.remove(snapshot.data![index]);
            });

          },child: Container(margin:  EdgeInsets.all(15),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.yellowAccent,boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 5,spreadRadius: 5)]),child: Column(children: [
            ListTile(contentPadding: EdgeInsets.all(10),title: Padding(padding: EdgeInsets.only(bottom: 10),child: Text(toTitle,style: TextStyle(fontSize: 15),),),subtitle: Text(toDesc,style: TextStyle(fontSize: 16),
            ),
            ),Divider(color: Colors.black,thickness: 0.8,),Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text(toDT,style: TextStyle(fontSize: 14,fontWeight:  FontWeight.w400,fontStyle: FontStyle.italic)
                ,),InkWell(onTap: (){

              },child: IconButton(icon:Icon(Icons.edit_note,size: 28,color: Colors.green), onPressed: (){Navigator.pushNamed(context,'/addUpdate' );},),)],
            ),),
          ],),),);
        },);
        /*ListView.builder(shrinkWrap: true,itemBuilder: snapshot )
      */}
    },
    future: dataList,
  ) )],), floatingActionButton: FloatingActionButton(onPressed: (){
Navigator.pushNamed(context,'/addUpdate');
    },child: Icon(Icons.add),), );
  }
}
