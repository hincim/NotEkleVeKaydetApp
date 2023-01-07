
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notlaruyg/repo/NotlardaoRepository.dart';

class NotDetayCubit extends Cubit<void>{

  NotDetayCubit():super(0);

  var krepo = NotlardaoRepository();

  Future<void> guncelle (int not_id, String ders_adi, int not1, int not2)async{

    await krepo.notGuncelle( not_id, ders_adi, not1, not2);
  }

  Future<void> sil (int not_id) async{
    await NotlardaoRepository().notSil(not_id);
  }
}