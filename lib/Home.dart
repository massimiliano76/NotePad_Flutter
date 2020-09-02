import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  _showCreateRegister() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            CupertinoButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
              ),
              minSize: 5.2,
            ),
            CupertinoButton(
              onPressed: () {
                // Save
              },
              child: Text(
                "Save",
              ),
            )
          ],
          title: Text(
            "Add Anotation",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoTextField(
                controller: _titleController,
                autofocus: true,
                placeholder: "Digite o título...",
                placeholderStyle: TextStyle(color: CupertinoColors.systemGrey2),
                maxLines: 1,
                maxLength: 50,
              ),
              SizedBox(height: 10),
              CupertinoTextField(
                controller: _descriptionController,
                placeholder: "Digite a descrição...",
                placeholderStyle: TextStyle(color: CupertinoColors.systemGrey2),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Note Pad",
          style: TextStyle(
            color: CupertinoColors.white,
          ),
        ),
        backgroundColor: CupertinoColors.systemGrey,
        shadowColor: Colors.transparent,
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateRegister();
        },
        child: Icon(
          CupertinoIcons.add,
        ),
        backgroundColor: CupertinoColors.darkBackgroundGray,
        foregroundColor: CupertinoColors.white,
        mini: true,
      ),
    );
  }
}
