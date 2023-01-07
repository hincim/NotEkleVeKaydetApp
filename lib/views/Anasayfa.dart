import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notlaruyg/cubit/AnasayfaCubit.dart';
import 'package:notlaruyg/views/NotDetaySayfa.dart';
import 'package:notlaruyg/views/NotKayitSayfa.dart';
import 'package:notlaruyg/entity/Notlar.dart';

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> with TickerProviderStateMixin {
  Future<bool> uygulamayiKapat() async {
    await exit(0);
  }


  late AnimationController animasyonKontrol;

  late Animation<double> translateAnimasyonDegerleri;


  @override
  void initState() {
    super.initState();
    animasyonKontrol = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    translateAnimasyonDegerleri = Tween(begin: -800.0,end: 0.0).animate(CurvedAnimation(parent: animasyonKontrol, curve: Curves.easeInOut))..addListener(() {
      setState(() {});
    });
    context.read<AnasayfaCubit>().notlariYukle();
    animasyonKontrol.forward();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 25),
            child: Transform.translate(
              offset: Offset(-translateAnimasyonDegerleri.value, 0.0),
              child: Text("Dersin Ortalaması \nK: Kaldı  G: Geçti",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          // Text("Dersi geçme durumu K: Kaldı G: Geçti")
        ],
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Transform.translate(
            offset: Offset(translateAnimasyonDegerleri.value, 0.0),
            child: Text(
              "Notlar",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Transform.translate(
            offset: Offset(translateAnimasyonDegerleri.value,0.0),
            child: BlocBuilder<AnasayfaCubit, List<Notlar>>(
                builder: (context, notlarListesi) {
              if (notlarListesi.isNotEmpty) {
                double ort = 0.0;
                double toplam = 0.0;
                for (var n in notlarListesi) {
                  toplam = (n.not1 + n.not2) / 2 + toplam;
                }
                ort = toplam / notlarListesi.length;
                int ortalama = ort.toInt();
                return Text(
                  "Ortalama : $ortalama",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                );
              } else {
                return Text(
                  "Ortalama : 0",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                );
              }
            }),
          ),
        ]),
      ),
      body: WillPopScope(
        onWillPop: uygulamayiKapat,
        child: BlocBuilder<AnasayfaCubit, List<Notlar>>(
          builder: (context, notlarListesi) {
            if (notlarListesi.isNotEmpty) {
              return ListView.builder(
                itemCount: notlarListesi.length,
                itemBuilder: (context, index) {
                  var not = notlarListesi[index];
                  var dersOrt = (not.not1 + not.not2) / 2;
                  var gecme = false;
                  if (dersOrt >= 50) {
                    gecme = true;
                  } else {
                    gecme = false;
                  }
                  return SizedBox(
                    height: 50.0,
                    child: GestureDetector(
                      onTap: () {
                        animasyonKontrol.reverse();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotDetaySayfa(
                                not: not,
                              ),
                            )).then((value) => {
                              animasyonKontrol.forward()
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffef9a9a), Colors.red]
                          )
                        ),
                        child: Transform.translate(
                          offset: Offset(0.0, translateAnimasyonDegerleri.value),
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  not.ders_adi,
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                                Text(not.not1.toString()),
                                Text(not.not2.toString()),
                                Text(
                                  ((not.not1 + not.not2) / 2).toInt().toString(),
                                ),
                                gecme
                                    ? Text("G",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                        fontFamily: "Exo"))
                                    : Text("K",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                        fontFamily: "Exo"))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animasyonKontrol.reverse();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotKayitSayfa(),
              )).then((value) => {
                animasyonKontrol.forward()
          });
        },
        tooltip: "Not Ekle",
        child: Icon(Icons.add),
      ),
    );
  }
}
