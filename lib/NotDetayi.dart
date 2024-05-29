import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basari_notlari_app_http/Notlar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'main.dart';

class NotDetay extends StatefulWidget {

  Notlar not;

  NotDetay({required this.not});

  @override
  State<NotDetay> createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {

  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  Future<void> sil(int not_id) async{
    var url = Uri.parse("http://kasimadalan.pe.hu/notlar/delete_not.php");
    var veri ={"not_id" : not_id.toString(), };
    var yanit = await http.post(url, body: veri);
    print("Not Silme Cevabı : ${yanit.body}");
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  Future<void> guncelle(int not_id,String ders_adi, int not1, int not2) async{
    var url = Uri.parse("http://kasimadalan.pe.hu/notlar/update_not.php");
    var veri ={"not_id" : not_id.toString(), "ders_adi" : ders_adi, "not1" : not1.toString(), "not2" : not2.toString()};
    var yanit = await http.post(url, body: veri);
    print("Not Güncelleme Cevabı : ${yanit.body}");
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }



  @override
  void initState() {
    super.initState();

    var not = widget.not;
    tfDersAdi.text = not.ders_adi;
    tfNot1.text = not.not1.toString();
    tfNot2.text = not.not2.toString();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey4,
      appBar: AppBar(
        title:  Text("Not Detayı",style: TextStyle(color: Colors.indigo.shade800),),
        actions: [


          TextButton(
            onPressed: (){
              sil(int.parse(widget.not.not_id));
            },
            child: Text("Sil",style: TextStyle(color: Colors.indigo.shade800),),),


          TextButton(
              onPressed: (){
                guncelle(int.parse(widget.not.not_id), tfDersAdi.text, int.parse(tfNot1.text),  int.parse(tfNot2.text));
              },
              child: Text("Güncelle",style: TextStyle(color: Colors.indigo.shade800),))
        ],



      ),






      body:  Center(
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

    );
  }
}
