import 'package:flutter/material.dart';

class MyCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  double height = 150;
  MyCustomAppBar({this.height});
  @override
  _MyCustomAppBarState createState() => _MyCustomAppBarState();
   @override
  Size get preferredSize => Size.fromHeight(height);
}

class _MyCustomAppBarState extends State<MyCustomAppBar>  {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {

    return Container(
      
      color: Colors.blueAccent,
      child: Column(
            children: [
            SizedBox(height: 30,),
                Row(
            children: [
              SizedBox(width: 10,),
              Icon(
                Icons.check_circle
              ),
              SizedBox(width: 10,),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['One', 'Toutes Categories', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(fontSize: 28),),
                  );
                }).toList(),
              ),
            ],

          ),
            ]
          )
    );

  }
}