import 'package:flutter/material.dart';
import 'package:gestionnaire_de_tache/widget/my_custom_appBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> listDeTache = List();
  List<bool> _checked = List();
  @override
  void initState() {
    for (var i = 0; i < 100; i++) {
          _checked.add(false);
    }
    listDeTache.add("Tache1");
    listDeTache.add("Tache1");
    listDeTache.add("Tache1");
    listDeTache.add("Tache1");
    listDeTache.add("Tache1");
    listDeTache.add("Tache1");
    super.initState();
  }
  createAlertDialog(BuildContext context){
    return showDialog(context: context,builder:(context){
      return AlertDialog(
        title: Text("Etes-vous sûr"),
        content: Text("Terminer la tâche?"),
        actions: [
          MaterialButton(
            child: Text("Annuler"),
            onPressed: null
          ),
          MaterialButton(
            child: Text("Terminer"),
            onPressed: null
          ),
        
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(height: 60,),
      body: ListView.builder(
        itemCount: listDeTache.length,
        itemBuilder: (context,index){
          return CheckboxListTile(
            value: _checked[index],
            onChanged: (bool value){
              if(value == true)
                createAlertDialog(context);
              setState(() {
                _checked[index] = value;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(listDeTache[index]),

          );
        }
        ),
    );
  }
}
