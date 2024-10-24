import 'package:flutter/material.dart';


class quiscontainer extends StatelessWidget {
  final String questionimj;
  final String questionname;
  final void Function()? oncategorytap;
  const quiscontainer({
    super.key,
    required this.questionimj,
    required this.questionname,
    required this.oncategorytap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: oncategorytap,
      child: Container(
        height: 110,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: 100,
                width: 180,
                child: Image(
                  image: AssetImage(questionimj),
                  fit: BoxFit.cover,
                ),
              ),
              Spacer(),
              Text(questionname,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("5 Questions"),
            ],
          ),
        ),
      ),
    );
  }
}