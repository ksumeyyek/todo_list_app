import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_uygulamasi/entity/todo.dart';
import 'package:todo_uygulamasi/repo/isdao_repository.dart';

class MainCubit extends Cubit<List<Todo>> {
  MainCubit():super(<Todo>[]);

  var krepo = IsDaoRepository();

  Future<void> isleriYukle() async {
    var liste = await krepo.tumIsleriAl();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async {
    var liste = await krepo.isAra(aramaKelimesi);
    emit(liste);
  }

  Future<void> sil(int yapilacak_id) async {
    await krepo.isSil(yapilacak_id);
    await isleriYukle();

  }
}
