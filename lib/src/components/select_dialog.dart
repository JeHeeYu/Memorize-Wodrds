import 'package:flutter/material.dart';

class PopupDialog extends StatefulWidget {
  const PopupDialog({Key? key}) : super(key: key);

  @override
  _PopupDialogState createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog> {
  int _radioValue = 0;

  void _handleRadioValueChanged(int? value) {
    setState(() {
      _radioValue = value ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose an option'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<int>(
            title: const Text('Word'),
            value: 0,
            groupValue: _radioValue,
            onChanged: _handleRadioValueChanged,
          ),
          RadioListTile<int>(
            title: const Text('Sentence'),
            value: 1,
            groupValue: _radioValue,
            onChanged: _handleRadioValueChanged,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_radioValue);
          },
          child: const Text('OK'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}