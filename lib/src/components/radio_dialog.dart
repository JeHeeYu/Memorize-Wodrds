import 'package:flutter/material.dart';

import '../statics/strings_data.dart';

class RadioDialog extends StatelessWidget {
  final String mainText;
  final String okButtonText;
  final String cancelButtonText;
  final void Function(int)? onPressed;

  const RadioDialog({
    Key? key,
    required this.mainText,
    required this.okButtonText,
    required this.cancelButtonText,
    this.onPressed,
  }) : super(key: key);

  Widget radioButton() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                mainText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Radio<int>(
                      value: 0,
                      groupValue: 0,
                      onChanged: (value) {},
                    ),
                    Text('Option 1'),
                  ],
                ),
              ],
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
                          if (onPressed != null) {
                            onPressed!(0);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(okButtonText),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          minimumSize: const Size(100, 40),
                        ),
                        onPressed: () {
                          if (onPressed != null) {
                            onPressed!(1);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(cancelButtonText),
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
    BuildContext context, void Function(int)? callback, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return RadioDialog(
        mainText: text,
        okButtonText: Strings.STR_COMMON_OK,
        cancelButtonText: Strings.STR_COMMON_CANCEL,
        onPressed: callback,
      );
    },
  );
}
