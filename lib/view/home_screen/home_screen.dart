import 'package:flutter/material.dart';
import 'package:quis_app_datause/view/DummyDp.dart';
import 'package:quis_app_datause/view/question_sreen/question_Screeen.dart';


import 'package:quis_app_datause/view/widgets/container.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,crossAxisSpacing: 20,mainAxisSpacing: 20,
                ), 
                itemCount: DummyDp.callList.length,
                itemBuilder: (context, index) => quiscontainer(questionimj: DummyDp.callList[index]["questionimj"],
                questionname: DummyDp.callList[index]["questionname"],
                oncategorytap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(category: DummyDp.callList[index]["questionname"]),));
                },
                  
                )),
            )
        
          ],
        ),
      )
    );
  }
}