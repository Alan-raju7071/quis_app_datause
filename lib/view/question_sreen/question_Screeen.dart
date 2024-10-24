import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:quis_app_datause/view/DummyDp.dart';
import 'package:quis_app_datause/view/Result_sceen/Resultscreen.dart';

class QuestionScreen extends StatefulWidget {
  final String category;
  const QuestionScreen({super.key, required this.category});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int count = 0;
  int? selectedAnswerIndex;
  int rightAnswerCount = 0;
  double progress = 0.0; // Progress percentage
  List questionList = [];
  Timer? timer; // Timer reference
  int timeLeft = 10; // Time in seconds for each question

  @override
  void initState() {
    super.initState();
    Category(); // Populate questions based on category
    startTimer(); // Start the timer for the first question
  }

  @override
  void dispose() {
    timer?.cancel(); // Ensure timer is cancelled to avoid memory leaks
    super.dispose();
  }

  // Populate questions based on the selected category
  void Category() {
    switch (widget.category) {
      case "Sports":
        questionList = DummyDp.SportList;
        break;
      case "Chemistry":
        questionList = DummyDp.chemistryList;
        break;
      case "Mathematics":
        questionList = DummyDp.mathematicsList;
        break;
      case "History":
        questionList = DummyDp.historyList;
        break;
      case "Biology":
        questionList = DummyDp.biologyList;
        break;
      case "Geography":
        questionList = DummyDp.geographyList;
        break;
    }
  }

  // Start or restart the timer
  void startTimer() {
    timer?.cancel(); // Cancel any existing timer
    timeLeft = 10; // Reset time for the new question

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          goToNextQuestion(); // Move to next question when time is up
        }
      });
    });
  }

  // Navigate to the next question or show the result screen
  void goToNextQuestion() {
    if (count < questionList.length - 1) {
      setState(() {
        count++;
        selectedAnswerIndex = null; // Reset selection
        startTimer(); // Restart timer for the next question
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            RightansCount: rightAnswerCount,
          ),
        ),
      );
    }
  }

  // Update progress whenever a correct answer is selected
  void updateProgress() {
    setState(() {
      progress = rightAnswerCount / questionList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Text(
            "${count + 1} / ${questionList.length}",
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // Timer Display
            Text(
              "Time Left: $timeLeft s", // Show the timer prominently
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),

            // Progress Indicator
            LinearProgressIndicator(
              value: progress, // Show progress as percentage
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            const SizedBox(height: 20),

            // Question Box
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        questionList[count]["question"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Options
            Column(
              children: List.generate(
                questionList[count]["options"].length,
                (index) => Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () {
                      if (selectedAnswerIndex == null) {
                        setState(() {
                          selectedAnswerIndex = index;

                          if (index == questionList[count]["answer index"]) {
                            rightAnswerCount++;
                            updateProgress(); // Update progress if correct
                          }
                        });
                        timer?.cancel(); // Cancel the timer on answer selection
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: getColor(index),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            questionList[count]["options"][index],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const Icon(
                            Icons.circle_outlined,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Next Button
            if (selectedAnswerIndex != null)
              InkWell(
                onTap: goToNextQuestion,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueGrey,
                  ),
                  child: const Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Get the color based on the selected answer
  Color getColor(int optionIndex) {
    if (selectedAnswerIndex != null &&
        optionIndex == questionList[count]["answer index"]) {
      return Colors.green; // Correct answer
    }
    if (selectedAnswerIndex == optionIndex) {
      return Colors.red; // Wrong answer
    }
    return Colors.grey; 
  }
}