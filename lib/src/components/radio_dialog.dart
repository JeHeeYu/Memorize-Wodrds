import 'package:flutter/material.dart';

import '../statics/strings_data.dart';

enum RadioList {
  first,
  second,
  third,
}

class RadioDialog extends StatefulWidget {
  final String mainText;
  final String firstRadioText;
  final String secondRadioText;
  final String thirdRadioText;
  final String okButtonText;
  final String cancelButtonText;
  final void Function(int)? onPressed;

  const RadioDialog({
    Key? key,
    required this.mainText,
    required this.firstRadioText,
    required this.secondRadioText,
    required this.thirdRadioText,
    required this.okButtonText,
    required this.cancelButtonText,
    this.onPressed,
  }) : super(key: key);

  @override
  _RadioDialogState createState() => _RadioDialogState();
}

class _RadioDialogState extends State<RadioDialog> {
  int? selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  Widget RadioListBuild(int radioIndex) {
    String radioText = "";

    if(radioIndex == RadioList.first.index) {
      radioText = widget.firstRadioText;
    }
    else if(radioIndex == RadioList.second.index) {
      radioText = widget.secondRadioText;
    }
    else {
      radioText = widget.thirdRadioText;
    }

    return Row(
      children: [
        Radio<int>(
          value: radioIndex,
          groupValue: selectedRadio,
          onChanged: (value) {
            setState(() {
              selectedRadio = value;
            });
          },
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedRadio = radioIndex;
            });
          },
          child: Text(
            radioText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.mainText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  RadioListBuild(RadioList.first.index),
                  RadioListBuild(RadioList.second.index),
                  RadioListBuild(RadioList.third.index),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(100, 40),
                        ),
                        onPressed: () {
                          if (widget.onPressed != null) {
                            widget.onPressed!(selectedRadio ?? 0);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(widget.okButtonText),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          minimumSize: const Size(100, 40),
                        ),
                        onPressed: () {
                          // if (widget.onPressed != null) {
                          //   widget.onPressed!(selectedRadio ?? 1);
                          //   Navigator.pop(context);
                          // }
                        },
                        child: Text(widget.cancelButtonText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showRadioDialog(
    BuildContext context,
    void Function(int)? callback,
    String text,
    String firstRadioText,
    String secondRadioText,
    String thirdRadioText) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return RadioDialog(
        mainText: text,
        firstRadioText: firstRadioText,
        secondRadioText: secondRadioText,
        thirdRadioText: thirdRadioText,
        okButtonText: Strings.STR_COMMON_OK,
        cancelButtonText: Strings.STR_COMMON_CANCEL,
        onPressed: callback,
      );
    },
  );
}
