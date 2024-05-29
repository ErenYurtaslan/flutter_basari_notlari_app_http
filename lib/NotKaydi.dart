import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basari_notlari_app_http/main.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class NotKayit extends StatefulWidget {
  const NotKayit({Key? key}) : super(key: key);

  @override
  State<NotKayit> createState() => _NotKayitState();
}

class _NotKayitState extends State<NotKayit> {

  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();


  Future<void> kayit(String ders_adi, int not1, int not2) async{
    var url = Uri.parse("http://kasimadalan.pe.hu/notlar/insert_not.php");
    var veri ={"ders_adi" : ders_adi, "not1" : not1.toString(), "not2" : not2.toString()};
    var yanit = await http.post(url, body: veri);
    print("Not Ekleme Cevabı : ${yanit.body}");
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey4,
      appBar: AppBar(
        title: Text("Not Kayıt",style: TextStyle(color: Colors.indigo.shade800),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 43.0, right: 43.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  <Widget>[
              TextField(
                controller: tfDersAdi,
                decoration: InputDecoration(hintText: "Ders Adı"),
              ),
              TextField(
                controller: tfNot1,
                decoration: InputDecoration(hintText: "Vize"),
              ),
              TextField(
                controller: tfNot2,
                decoration: InputDecoration(hintText: "Final"),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){
          kayit(tfDersAdi.text, int.parse(tfNot1.text),  int.parse(tfNot2.text));
        },
        tooltip: 'Not Kayıt',
        icon: const Icon(Icons.save, color: CupertinoColors.systemGrey4,),
        label: Text("Kaydet",style: TextStyle(color: Colors.indigo.shade800),),
      ),
    );
  }
}
