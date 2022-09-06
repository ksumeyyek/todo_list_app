import 'package:flutter/material.dart';
import 'package:todo_uygulamasi/cubit/main_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_uygulamasi/entity/todo.dart';
import 'package:todo_uygulamasi/views/detail_page.dart';
import 'package:todo_uygulamasi/views/entry_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool search = false;

  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().downDo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: search ?
        TextField(decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (resultSearch){
            context.read<MainCubit>().search(resultSearch);
          },) :
        const Text("Yapılacaklar"),
        actions: [
          search ?
          IconButton(onPressed: (){
            setState(() { search = false; });
            context.read<MainCubit>().downDo();
          }, icon: const Icon(Icons.clear)) :
          IconButton(onPressed: (){
            setState(() { search = true; });
          }, icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocBuilder<MainCubit,List<Todo>>(
        builder: (context,doList){
          if(doList.isNotEmpty){
            return ListView.builder(
              itemCount: doList.length,
              itemBuilder: (context,indeks){
                var iss = doList[indeks];
                return GestureDetector(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(iss: iss))).
                  then((value) => {context.read<MainCubit>().downDo()});},
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("${iss.yapilacak_is} "),
                          const Spacer(),
                          IconButton(onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${iss.yapilacak_is} silinsin mi?"),
                                  action: SnackBarAction(
                                    label: "Evet",
                                    onPressed: (){ context.read<MainCubit>().delete(iss.yapilacak_id); },
                                  ),
                                ));
                          }, icon: const Icon(Icons.delete_outline,color: Colors.black45,))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const EntryPage())).then((value) =>
          {context.read<MainCubit>().downDo()});
        },
      ),
    );
  }
}
