

import 'dart:developer';

import 'package:flutter/material.dart';
class home extends StatefulWidget {
  const home({ Key? key }) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
TextEditingController txt=  TextEditingController();
  var gettext = "";
  var lst = [];
  submit(){
    setState(() {
      lst.add(gettext);
      print(lst);
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
        appBar: AppBar(title: const Text('To-Do List')),
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height : 50),
          
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: lst.length,
            itemBuilder: (context,index){

              final item = lst[index];
            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  lst.removeAt(index);
                });
              ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$item dismissed')));
              },
              background: Container(color: Colors.red),
              child: ListTile(
              leading: Text("${lst[index]}"),
              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.delete),
              tooltip: 'Swipe LEFT/RIGHT to Delete'
              )
              
              )
            );
            },
            ),
            Align(
            alignment: FractionalOffset.bottomRight,
            
            child: FloatingActionButton(
                onPressed: () => _displayDialog(context),
                tooltip: 'Add Item',
                child: Icon(Icons.add)),
          ),
          ],  
        ),
      ) ,      
    );
  }
  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a task to your list'),
          content: TextField(
            controller: txt,
            onChanged: (value){
                gettext = value;
            decoration: const InputDecoration(hintText: 'Enter task here');
            }),
          actions: <Widget>[
            TextButton(
              child: const Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                submit();
                txt.clear();
              },
            ),
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      } 
      
    );
  }
}
