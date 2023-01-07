import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notlaruyg/cubit/NotDetayCubit.dart';
import 'package:notlaruyg/entity/Notlar.dart';
import 'package:notlaruyg/views/Anasayfa.dart';

class NotDetaySayfa extends StatefulWidget {

  Notlar not;

  NotDetaySayfa({required this.not});

  @override
  State<NotDetaySayfa> createState() => _NotDetaySayfaState();
}

class _NotDetaySayfaState extends State<NotDetaySayfa> {

  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  @override
  void initState() {
    super.initState();

    tfDersAdi.text = widget.not.ders_adi;
    tfNot1.text = widget.not.not1.toString();
    tfNot2.text = widget.not.not2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Detay"),
        actions: [
          TextButton(onPressed: (){
            context.read<NotDetayCubit>().sil(widget.not.not_id);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Anasayfa(),));
          }, child: Text("Sil",style: TextStyle(color: Colors.white),)),

          TextButton(onPressed: (){
            if (tfDersAdi.text.isEmpty) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Ders adı boş olamaz"),
                  backgroundColor: Color(0xffef5350),
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),)));
            }
            else if (tfNot1.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Not 1 alanı boş olamaz"),
                    backgroundColor: Color(0xffef5350),
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),

                  ),));
            } else if (tfNot2.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Not 2 alanı boş olamaz"),
                      backgroundColor: Color(0xffef5350),
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),)));
            } else {
              context.read<NotDetayCubit>().guncelle(widget.not.not_id, tfDersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Anasayfa(),));
            }

          }, child: Text("Güncelle",style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0, left: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfDersAdi,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: "Ders Adı",
                    labelStyle: TextStyle(color: Colors.black)
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: tfNot1,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: "Not 1",
                    labelStyle: TextStyle(color: Colors.black)
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: tfNot2,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: Colors.red
                        )
                    ),
                    labelText: "Not 2",
                    labelStyle: TextStyle(color: Colors.black)
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
