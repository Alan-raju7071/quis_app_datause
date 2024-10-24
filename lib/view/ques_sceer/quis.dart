import 'package:flutter/material.dart';
import 'package:quis_app_datause/view/DummyDp.dart';






class Quis extends StatefulWidget {
   final String item;
 const  Quis({super.key,required this.item});

  @override
  State<Quis> createState() => _QuisState();
}

class _QuisState extends State<Quis> {
  int currentindex = 0;
  int rightanswercount = 0;
  int? selectedanswerindex;
  var questionlist=[]; 
  
  

  @override
   void initState() {
    item();
    super.initState();
    
    
  }

  void item() {
   
     
    print(widget.item);
    if (widget.item == "Sports") {
      questionlist =DummyDp.SportList;
    } else if (widget.item == "Chemistry") {
      questionlist = DummyDp.chemistryList;
    } else if (widget.item == "Mathematics") {
      questionlist = DummyDp.mathematicsList;
    } else if (widget.item == "History") {
      questionlist = DummyDp.historyList;
    } else if (widget.item == "Biology") {
      questionlist = DummyDp.biologyList;
    } else if (widget.item == "Geography") {
      questionlist = DummyDp.geographyList;
    }
    ;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("${currentindex + 1} / ${questionlist.length}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: Center(
                          child: Text(
                        questionlist[currentindex]["question"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                    ),
                    // if (selectedanswerindex ==
                    //     DummyDp.questionList[currentindex]["answerindex"])
                    //    Lottie.asset(AnimationConstants.rightansAnimation,
                    //      fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
                children: List.generate(
                    
            questionlist[currentindex]["options"].length,
                    (optionindex) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    if (selectedanswerindex == null) {
                      selectedanswerindex = optionindex;
                      setState(() {});
                        if (optionindex ==
                           questionlist[currentindex]["answer index"]) {
                          rightanswercount++;
                        }
                      
                    }
                  },
                  child: Container(
                   
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: getColor(optionindex), width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                      questionlist[currentindex]["options"]
                                  [optionindex],
                              style: TextStyle(color: Colors.white)),
                          Spacer(),
                          Icon(Icons.circle_outlined, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
            SizedBox(height: 20),
            selectedanswerindex == null
                ? SizedBox()
                :
                // or if(selectedanswerindex!=null)
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        selectedanswerindex = null;
                        setState(() {});
                        if (currentindex <questionlist.length - 1) {
                          currentindex++;
                        } else {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => MathsResult(
                          //         rightanswercount: rightanswercount,
                          //       ),
                          //     ));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Text(
                          "Next",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Color getColor(int currentoptionindex) {
    if (selectedanswerindex != null &&
        currentoptionindex ==
            questionlist[currentindex]["answer index"]) {
               
      return Colors.green;
    }
    if (selectedanswerindex == currentoptionindex) {
      if (selectedanswerindex ==
        questionlist[currentindex]["answer index"]) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.grey;
    }
  }
}