import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notlaruyg/entity/Notlar.dart';
import 'package:notlaruyg/repo/NotlardaoRepository.dart';

class AnasayfaCubit extends Cubit<List<Notlar>>{


  AnasayfaCubit():super(<Notlar>[]);

  var krepo = NotlardaoRepository();

  Future<void> notlariYukle() async{

    var liste = await krepo.tumNotlar();
    emit(liste);
  }
}