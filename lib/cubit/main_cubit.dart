import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_uygulamasi/entity/todo.dart';
import 'package:todo_uygulamasi/repo/isdao_repository.dart';

class MainCubit extends Cubit<List<Todo>> {
  MainCubit():super(<Todo>[]);

  var krepo = IsDaoRepository();

  Future<void> downDo() async {
    var liste = await krepo.takeAllDo();
    emit(liste);
  }

  Future<void> search(String searchWord) async {
    var liste = await krepo.doSearch(searchWord);
    emit(liste);
  }

  Future<void> delete(int yapilacak_id) async {
    await krepo.doDelete(yapilacak_id);
    await downDo();

  }
}
