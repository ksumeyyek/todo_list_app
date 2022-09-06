import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../cubit/entry_cubit.dart';
class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  var tfIsadi=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yapılacak İş Kayıt"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfIsadi,decoration: const InputDecoration(hintText: "Yapılacak İş"),),

              ElevatedButton(onPressed: (){
                context.read<KayitCubit>().entry(tfIsadi.text, );
              }, child: const Text("KAYIT"))
            ],
          ),
        ),
      ),
    );
  }
}
