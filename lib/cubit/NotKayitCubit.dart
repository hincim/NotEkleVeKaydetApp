import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notlaruyg/repo/NotlardaoRepository.dart';

class NotKayitCubit extends Cubit<void>{

  NotKayitCubit():super(0);

  var krepo = NotlardaoRepository();


  Future<void> ekle(String ders_adi, int not1, int not2) async{

    await krepo.notEkle(ders_adi, not1, not2);

  }
}