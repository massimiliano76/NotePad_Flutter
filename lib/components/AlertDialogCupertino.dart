import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogCupertino extends StatelessWidget {
  final Function onPressed;
  final String firstTextButton;
  final String secondTextButton;
  final String title;
  final double fontSize;
  final TextEditingController firstController;
  final TextEditingController secondController;

  const AlertDialogCupertino({
    Key key,
    this.onPressed,
    this.firstTextButton = "Save",
    this.secondTextButton = "Cancel",
    this.firstController,
    this.secondController,
    this.title = "Add Anotation",
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        CupertinoButton(
          onPressed: () => Navigator.pop(context),
          child: Text(secondTextButton),
        ),
        CupertinoButton(onPressed: onPressed, child: Text(firstTextButton))
      ],
      title: Text(title, style: TextStyle(fontSize: fontSize)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoTextField(
            controller: firstController,
            autofocus: true,
            placeholder: "Digite o título...",
            placeholderStyle: TextStyle(color: CupertinoColors.systemGrey2),
            maxLines: 1,
            maxLength: 50,
            // keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10),
          CupertinoTextField(
            controller: secondController,
            placeholder: "Digite a descrição...",
            placeholderStyle: TextStyle(color: CupertinoColors.systemGrey2),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}
