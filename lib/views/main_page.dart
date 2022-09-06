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
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().isleriYukle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
        TextField(decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu){
            context.read<MainCubit>().ara(aramaSonucu);
          },) :
        const Text("Yapılacaklar"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() { aramaYapiliyorMu = false; });
            context.read<MainCubit>().isleriYukle();
          }, icon: const Icon(Icons.clear)) :
          IconButton(onPressed: (){
            setState(() { aramaYapiliyorMu = true; });
          }, icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocBuilder<MainCubit,List<Todo>>(
        builder: (context,kisilerListesi){
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: kisilerListesi.length,
              itemBuilder: (context,indeks){
                var iss = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(iss: iss))).
                  then((value) => {context.read<MainCubit>().isleriYukle()});},
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
                                    onPressed: (){ context.read<MainCubit>().sil(iss.yapilacak_id); },
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
          {context.read<MainCubit>().isleriYukle()});
        },
      ),
    );
  }
}
