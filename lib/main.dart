import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basari_notlari_app_http/Cevap.dart';
import 'package:flutter_basari_notlari_app_http/NotDetayi.dart';
import 'package:flutter_basari_notlari_app_http/NotKaydi.dart';
import 'package:flutter_basari_notlari_app_http/Notlar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {


  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  List<Notlar> parseCevap(String cevap){
    return Cevap.fromJson(json.decode(cevap)).notlarListesi;
  }



  Future<List<Notlar>> showAllAchievementScores() async{
    var url = Uri.parse("http://kasimadalan.pe.hu/notlar/tum_notlar.php");
    var yanit = await http.get(url);
    return parseCevap(yanit.body);
  }



  Future<bool> closeApp() async{
    await exit(0);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey4,



      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            closeApp();
          }, icon: const Icon(Icons.arrow_back_ios, color: CupertinoColors.systemGrey4,),),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notlar Uygulaması", style: TextStyle(color: Colors.indigo.shade800, fontSize: 16),),
            FutureBuilder<List<Notlar>>(
              future: showAllAchievementScores(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  var notlarListesi = snapshot.data;

                  double ortalama = 0.0;

                  if(notlarListesi!.isNotEmpty){
                    double toplam = 0.0;

                    for(var n in notlarListesi){
                      toplam = toplam + (int.parse(n.not1)+int.parse(n.not2))/2;
                    }

                    ortalama = toplam/notlarListesi.length;

                  }

                  return  Text("Ortalama : $ortalama", style: TextStyle(color: Colors.indigo.shade800, fontSize: 14),);


                }else{
                  return  Text("Ortalama : null", style: TextStyle(color: Colors.indigo.shade800, fontSize: 14),);

                }
              },
            ),
          ],
        ),
      ),






      body: WillPopScope(
        onWillPop: closeApp,
        child: FutureBuilder<List<Notlar>>(
            future: showAllAchievementScores(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var notlarListesi = snapshot.data;
                return ListView.builder(
                    itemCount: notlarListesi!.length,
                    itemBuilder: (context, index){
                      var not = notlarListesi[index];

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotDetay(not: not,)));
                        },
                        child: Card(
                          color: Colors.cyanAccent,
                          child: SizedBox(
                            height: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(not.ders_adi, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo.shade800),),
                                Text(not.not1.toString(), style: TextStyle(fontWeight: FontWeight.normal, color: Colors.indigo.shade800),),
                                Text(not.not2.toString(), style: TextStyle(fontWeight: FontWeight.normal, color: Colors.indigo.shade800),),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );
              }else{
                return const Center();
              }
            }
        ),
      ),


      floatingActionButton:  FloatingActionButton(
        backgroundColor: Colors.indigo.shade700,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const NotKayit()));
        },
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add, color: CupertinoColors.systemGrey4,),
      ),


    );
  }
}
