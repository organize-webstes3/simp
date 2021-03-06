import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simp/ajuda.dart';
import 'package:simp/nwusr.dart';
import 'package:simp/util/database_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'chat.dart';
import 'homeb2cor.dart';
import 'listviewsamp.dart';
import 'model/note.dart';

class HomeSimp3 extends StatefulWidget {

  static Future<String> get _url async {

    var pref = await SharedPreferences.getInstance();
  String token = (pref.getString("tokenjwt") ?? "");


    await Future.delayed(Duration(seconds: 1));
    return 'https://dashboard.simp.agencialink.com/login/autologin/$token';
  } 


  static Future<String> get _usrnm async {

  var prefs = await SharedPreferences.getInstance();
  String nome = (prefs.getString("nome") ?? "");

    await Future.delayed(Duration(seconds: 1));
    return '$nome';
  }

  static Future<String> get _usremail async {

  var prefs = await SharedPreferences.getInstance();
  String email = (prefs.getString("email") ?? "");

    await Future.delayed(Duration(seconds: 1));
    return '$email';
  }

  static Future<String> get _usrimg async {

  var prefs = await SharedPreferences.getInstance();
  String logo = (prefs.getString("logo") ?? "");

    await Future.delayed(Duration(seconds: 1));
    return '$logo';
  }  

  static Future<String> get _usrid async {

  var prefs = await SharedPreferences.getInstance();
  String id = (prefs.getString("id") ?? "");

    await Future.delayed(Duration(seconds: 1));
    return '$id';
  }  

  static Future<String> get _uslog async {

  var prefs = await SharedPreferences.getInstance();
  String login = (prefs.getString("login") ?? "");

    await Future.delayed(Duration(seconds: 1));
    return '$login';
  }  
  

  @override
  _HomeSimp3State createState() => _HomeSimp3State();
}

class _HomeSimp3State extends State<HomeSimp3> {  

  DatabaseHelper db = DatabaseHelper();
  List<Contato> contatos = List<Contato>();

  @override
  initState() {
    super.initState();

    //  Contato c = Contato(1,"Maria","maria@uol.com.br",null);
    //  Contato c1 = Contato(2,"Pedro","pedro@uol.com.br",null);
    //  db.insertContato(c);
    //  db.insertContato(c1);
   
     _exibeTodosContatos();
  }  

   void _exibeTodosContatos(){
     db.getContatos().then( (lista) {
       setState(() {
         contatos = lista;
       });
     });
   }


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();  
  
  @override
  Widget build(BuildContext context) => Scaffold(
    key: _scaffoldKey,
    body: Center(
      child:FutureBuilder(
        future: HomeSimp3._url,
        builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
        ? WebViewWidget(url: snapshot.data,)
        : CircularProgressIndicator()),
    ),
    drawer: 
    ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: 
      Drawer(
        child: 
        Container(
          color: Colors.white,
          child: 
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: 
                SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 0, right: 80, left: 80),
                      child: Image.asset('imagens/logo.png'),
                    ),
                  ]
                )
              ),
              SliverList(
                delegate: 
                SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Divider(),
                    ),   
                  ]
                )
              ),
              SliverList(
                delegate: 
                SliverChildListDelegate(
                  [
                    ListTile(
                      leading: FutureBuilder(
                        future: HomeSimp3._usrimg,
                        builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
                        ? Container(width: 70, height: 100, decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(snapshot.data,) )),)
                        : CircularProgressIndicator()
                      ),
                      title: FutureBuilder(
                        future: HomeSimp3._usrnm,
                        builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
                        ? Text(snapshot.data, style: TextStyle(fontSize: 13),)
                        : CircularProgressIndicator()
                      ),
                      subtitle: FutureBuilder(
                        future: HomeSimp3._uslog,
                        builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
                        ? Text(snapshot.data, style: TextStyle(fontSize: 10),)
                        : CircularProgressIndicator()
                      ),
                    ),
                    Center(
                      child:
                      TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewSample()));}, child: Text('Usu??rios Salvos'))
                    )
                  ]
                )
              ),
              SliverList(
                delegate: 
                SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Divider(),
                    ),   
                  ]
                )
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                delegate: SliverChildListDelegate(
                  [
                    TextButton(
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomeSimp3()));},
                      child: 
                      Column(
                        children: [
                          Image.asset('imagens/ic_launcher.png', width: 50, height: 50,),
                          Text('SIMP', style: TextStyle(color: Colors.grey[700]))
                        ],
                      )
                    ),
                    TextButton(
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Homeb2cor()));},
                      child: 
                      Column(
                        children: [
                          Image.asset('imagens/b2cor.png', width: 50, height: 50,),
                          Text('B2Cor', style: TextStyle(color: Colors.grey[700]))
                        ],
                      )
                    ),
                    TextButton(
                      onPressed: null,
                      child: 
                      Column(
                        children: [
                          Image.asset('imagens/card.png', width: 50, height: 50,),
                          Text('CardCor', style: TextStyle(color: Colors.grey[700]))
                        ],
                      )
                    ),
                  ]
                )
              ),
              SliverList(
                delegate: 
                SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Divider(),
                    ),   
                  ]
                )
              ),
              SliverList(
                delegate: 
                SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Divider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('Suporte', style: TextStyle(fontSize: 20), textAlign: TextAlign.left,),
                          ),
                          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Ajuda()));}, child: Text('Base de Conhecimento')),
                          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()));}, child: Text('Atendimento via Chat')),                    
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        verticalDirection: VerticalDirection.up,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 95, right: 95),
                            child: Image.asset('imagens/ag.png'),
                          )
                        ],
                      ),
                    ) 
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    ),
    bottomNavigationBar: 
    SizedBox(
      height: 55,
      child: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(52, 58, 64, 1),
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              icon: Icon(Icons.home, color: Colors.white,), 
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomeSimp3()));}
            ) 
          ),
          BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              icon: Icon(Icons.apps, color: Colors.white,), 
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ) 
          ),
          BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white,), 
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NwUsr()));},
            ) 
          ),
        ],
      ),
    ),
  );
}

class WebViewWidget extends StatefulWidget {
  final String url;
  WebViewWidget({this.url});

  @override
  _WebViewWidget createState() => _WebViewWidget();
}

class _WebViewWidget extends State<WebViewWidget> {
  WebView _webView;
  @override
  void initState() {
    super.initState();
     _webView = WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onProgress: (int progress) {
        Center(
          child: CircularProgressIndicator(),
        );
        print("loading ($progress%)");
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _webView = null;
  }

  @override
  Widget build(BuildContext context) => _webView;
}




