import 'package:cinephileproject/widgets/mainRefactoring.dart';
import 'package:flutter/material.dart';

class AdminModule extends StatefulWidget {
  const AdminModule({super.key});

  @override
  State<AdminModule> createState() => _AdminModuleState();
}

class _AdminModuleState extends State<AdminModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
        title: maintitle(),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(248,249,250,1.000)),
                    // child: ,
              ),
            );
          }),
    );
  }
}
