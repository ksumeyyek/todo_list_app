import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_uygulamasi/entity/todo.dart';
import 'package:todo_uygulamasi/cubit/detail_cubit.dart';

class DetailPage extends StatefulWidget {
  Todo iss;


  DetailPage({required this.iss});

  @override
  State<DetailPage> createState() => _DetailPageState();
}


class _DetailPageState extends State<DetailPage> {
  var tfIsadi=TextEditingController();

  @override
  void initState(){
    super.initState();
    var iss=widget.iss;
    tfIsadi.text=iss.yapilacak_is;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yapılacak İş Detay"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfIsadi,decoration: const InputDecoration(hintText: "Yapılacak İş"),),

              ElevatedButton(onPressed: (){
                context.read<DetayCubit>().update(widget.iss.yapilacak_id, tfIsadi.text);
              }, child: const Text("GÜNCELLE"))
            ],
          ),
        ),
      ),
    );
  }
}
