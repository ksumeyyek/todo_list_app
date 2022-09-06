import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_uygulamasi/repo/isdao_repository.dart';
class KayitCubit extends Cubit<void> {
  KayitCubit():super(0);

  var krepo = IsDaoRepository();

  Future<void> entry(String yapilacak_is) async {
    await krepo.doEntry(yapilacak_is);
  }
}
