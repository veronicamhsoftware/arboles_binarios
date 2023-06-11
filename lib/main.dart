import 'package:arboles_binarios/paintTree.dart';
import 'package:flutter/material.dart';
import 'tree.dart';
import 'node.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Representación árbol binario de búsqueda',
      theme: ThemeData(
        primarySwatch:Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity        
      ),
      home: const MyHomePage(title: 'Tree'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Tree objTree;  
  final _textFieldController = TextEditingController();
  var _dato;
  var info;
  late TreePainter _painter;  
  
  @override
  void initState() {
    super.initState();
    objTree = new Tree();
    _painter = new TreePainter(objTree);
    info = "BST";    
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 44, 34),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60,
                  width: 60,
                ),
                Center(child:  Text("Árbol Binario de Búsqueda", style: TextStyle(color: Colors.white, fontSize: 20),),),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Container(
                  child: CustomPaint(
                    painter: _painter,
                    size: Size(MediaQuery.of(context).size.width, 250),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                      controller: _textFieldController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Ingresa un número",hintStyle: TextStyle(color: Colors.white), ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 2),                          
                            onPressed: () {
                              setState(() {
                                _dato = _textFieldController.text;
                                var exist_n = objTree.exist(int.parse(_dato));
                                if (exist_n){
                                  info = "El nodo ya se encuentra en el arból";
                                }else{
                                  objTree.insert_node(int.parse(_dato));
                                  info = "";
                                }                               
                                _textFieldController.text = "";
                              });
                            },
                            child: Text(
                              "Agregar",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xfffff5a5),
                              ),
                            ),
                          ),
                        ),
                      ),
                       Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 2),                          
                            onPressed: () {
                              setState(() {
                                _dato = _textFieldController.text;                                
                                var exist_n = objTree.exist(int.parse(_dato));
                                if (!exist_n){
                                  info = "No se encontró el nodo";
                                }else{
                                  objTree.delete(int.parse(_dato));
                                  info = "";
                                }
                                _textFieldController.text = "";
                                //Eliminar
                              });
                            },
                            child: Text(
                              "Eliminar",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xfffff5a5),
                              ),
                            ),
                          ),
                        ),
                      ),
                       Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 2),                          
                            onPressed: () {
                              setState(() {
                                _dato = _textFieldController.text;
                                var exist =objTree.exist(int.parse(_dato));
                                if(exist){
                                  info = "Nodo encontrado";
                                }else{
                                  info = "No se encontró el nodo";
                                }
                                _textFieldController.text = "";
                                
                              });
                            },
                            child: Text(
                              "Buscar",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xfffff5a5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      objTree.resetTree();
                    });
                  },
                  child: Text("Resetear Árbol",style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                Center(child:  Text(' $info', style: TextStyle(color: Colors.white, fontSize: 20),),),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}
