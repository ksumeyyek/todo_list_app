import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_uygulamasi/repo/isdao_repository.dart';
class DetayCubit extends Cubit<void> {
  DetayCubit():super(0);

  var krepo = IsDaoRepository();

  Future<void> guncelle(int yapilacak_id,String yapilacak_is) async {
    await krepo.isGuncelle(yapilacak_id, yapilacak_is);
  }
}
