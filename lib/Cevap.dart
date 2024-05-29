import 'package:flutter_basari_notlari_app_http/Notlar.dart';

class Cevap{
   int success;
   List<Notlar> notlarListesi;

   Cevap(this.success, this.notlarListesi);

   factory Cevap.fromJson(Map<String,dynamic> json){
      var jsonDizisi = json["notlar"] as List;

      List<Notlar> yerelNotlarListesi =jsonDizisi.map((e) => Notlar.fromJson(e)).toList();
      return Cevap(json["success"] as int, yerelNotlarListesi);
   }
}