import 'package:flutter/material.dart';
import 'package:notlaruyg/views/Anasayfa.dart';

class YuklemeSayfasi extends StatefulWidget {
  const YuklemeSayfasi({Key? key}) : super(key: key);

  @override
  State<YuklemeSayfasi> createState() => _YuklemeSayfasiState();
}

class _YuklemeSayfasiState extends State<YuklemeSayfasi>
    with TickerProviderStateMixin {
  late AnimationController animasyonKontrol;

  late Animation<double> translateAnimasyonDegerleri;

  @override
  void initState() {
    super.initState();
    animasyonKontrol = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    translateAnimasyonDegerleri = Tween(begin: -800.0, end: 0.0).animate(
        CurvedAnimation(parent: animasyonKontrol, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
    animasyonKontrol.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animasyonKontrol.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xffef5350), Color(0xffffebee)])),
        child: Center(
          child: Transform.translate(
            offset: Offset(0.0, -translateAnimasyonDegerleri.value),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not Ekle Ve Hesapla",
                  style: TextStyle(
                      fontFamily: "Exo", fontSize: 26, color: Colors.white),
                ),
                SizedBox(height: 15,),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Anasayfa(),));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width /4,
                      height: 45,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xffef5350), Color(0xffef9a9a)],
                             ),
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xff2d2f3a),
                                offset: Offset(0, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ]),
                      child: Center(
                        child: Text("Hesapla",
                            style: TextStyle(fontFamily: "Exo",fontSize: 18,
                            color: Colors.white)),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
