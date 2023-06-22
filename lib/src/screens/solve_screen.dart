import 'dart:math';

import 'package:flutter/material.dart';

import '../network/firebase_manager.dart';
import '../statics/common_data.dart';
import '../statics/images_data.dart';
import '../statics/strings_data.dart';

enum Result {
  correct,
  incorrect,
}

enum SolveListNumber { one, two, three, four }

class SolveScreen extends StatefulWidget {
  const SolveScreen({Key? key}) : super(key: key);

  @override
  _SolveScreenState createState() => _SolveScreenState();
}

class _SolveScreenState extends State<SolveScreen> {
  final FirebaseManager firebaseManager = FirebaseManager();
  late String randomQuestionWord;
  List<int> resultList =
      List<int>.filled(Common.questionListMaxCount, Result.incorrect.index);
  List<String> meaningList =
      List<String>.filled(Common.questionListMaxCount, "");

  late bool resultImageShow = false;
  late double opacityValue = 0.0;
  late bool resultCorrect = false;

  int solveListMaxCount = 50;
  int currentSolveCount = 0;
  int correctCount = 0;
  int incorrectCount = 0;

  @override
  void initState() {
    super.initState();
    getRandomQuestionWord();
  }

  void getRandomQuestionWord() async {
    final word = await firebaseManager.getRandomWord();
    setState(() {
      randomQuestionWord = word;
    });

    questionListInit();
  }

  void questionListInit() async {
    final int randomNumber = getRandomCorrectNumber();
    final String correctMeaning =
        await firebaseManager.getWordMeaning(randomQuestionWord);

    if (randomNumber >= resultList.length) {
      return;
    }

    if (meaningList.length < Common.questionListMaxCount) {
      meaningList = List<String>.filled(Common.questionListMaxCount, "");
    }

    for (int i = 0; i < Common.questionListMaxCount; i++) {
      final String randomMeaning = await firebaseManager.getRandomWordMeaning();

      if (i != randomNumber) {
        meaningList[i] = randomMeaning;
      }
    }

    setState(() {
      meaningList[randomNumber] = correctMeaning;
      resultList[randomNumber] = Result.correct.index;
    });

    for (int i = 0; i < Common.questionListMaxCount; i++) {
      final String randomMeaning = await firebaseManager.getRandomWordMeaning();

      if (meaningList[i] == "") {
        meaningList[i] = randomMeaning;
      }
    }
  }

  int getRandomCorrectNumber() {
    Random random = Random();
    int randomNumber = random.nextInt(Common.questionListMaxCount);
    return randomNumber;
  }

  void resultCheck(int listIndex) async {
    currentSolveCount++;

    final String correctMeaning =
        await firebaseManager.getWordMeaning(randomQuestionWord);

    if (correctMeaning == meaningList[listIndex]) {
      setState(() {
        resultImageShow = true;
        resultCorrect = true;
        opacityValue = 1.0;
        correctCount++;
        resultImageTimer();
      });
    } else {
      setState(() {
        resultImageShow = false;
        resultCorrect = false;
        opacityValue = 1.0;
        incorrectCount++;
        resultImageTimer();
      });
    }
  }

  Widget _showResultImage() {
    AssetImage image;

    if (resultCorrect == true) {
      image = const AssetImage(Images.IMG_SOLVE_CORRECT);
    } else {
      image = const AssetImage(Images.IMG_SOLVE_INCORRECT);
    }

    return Positioned.fill(
      child: IgnorePointer(
        //ignoring: !resultImageShow,
        child: AnimatedOpacity(
          opacity: opacityValue,
          duration: const Duration(milliseconds: 2000),
          child: Image(
            image: image,
          ),
        ),
      ),
    );
  }

  void resultImageTimer() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        opacityValue = 0.0;
        getRandomQuestionWord();
        questionListInit();

        resultImageShow = false;
      });
    });
  }

  Widget _solveList(int listIndex, String meaning) {
    AssetImage image;

    if (listIndex == SolveListNumber.one.index) {
      image = const AssetImage(Images.IMG_NUMBER_ONE);
    } else if (listIndex == SolveListNumber.two.index) {
      image = const AssetImage(Images.IMG_NUMBER_TWO);
    } else if (listIndex == SolveListNumber.three.index) {
      image = const AssetImage(Images.IMG_NUMBER_THREE);
    } else {
      image = const AssetImage(Images.IMG_NUMBER_FOUR);
    }

    return GestureDetector(
      onTap: () {
        if (resultImageShow == false) {
          resultCheck(listIndex);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: SizedBox(
              width: 50,
              child: Image(
                image: image,
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Text(
              meaning,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (randomQuestionWord.isEmpty) {
      return const CircularProgressIndicator();
    }
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  randomQuestionWord,
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                _solveList(SolveListNumber.one.index, meaningList[0]),
                _solveList(SolveListNumber.two.index, meaningList[1]),
                _solveList(SolveListNumber.three.index, meaningList[2]),
                _solveList(SolveListNumber.four.index, meaningList[3]),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${currentSolveCount.toString()} / ${solveListMaxCount.toString()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 19,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(
                        text: Strings.STR_SOLVE_CORRECT_FORMAT,
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      TextSpan(text: correctCount.toString()),
                      const TextSpan(
                        text: Strings.STR_SOLVE_INCORRECT_FORMAT,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(text: incorrectCount.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _showResultImage(),
        ],
      ),
    );
  }
}
