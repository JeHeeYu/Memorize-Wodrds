import 'package:flutter/material.dart';

import '../static/strings_data.dart';

class SelectDialog extends StatelessWidget {
  final String mainText;
  final String okButtonText;
  final String cancelButtonText;
  final void Function(int)? onPressed;

  const SelectDialog({
    Key? key,
    required this.mainText,
    required this.okButtonText,
    required this.cancelButtonText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 150,
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

void showSelectDialog(
    BuildContext context, void Function(int)? callback, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SelectDialog(
        mainText: text,
        okButtonText: Strings.STR_COMMON_OK,
        cancelButtonText: Strings.STR_COMMON_CANCEL,
        onPressed: callback,
      );
    },
  );
}
