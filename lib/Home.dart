import 'package:NotePad/components/AlertDialogCupertino.dart';
import 'package:NotePad/database/notepad_helper.dart';
import 'package:NotePad/database/models/Notepad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  var _database = NotepadHelper();

  List<Notepad> _notepads = List<Notepad>();

  _showCreateRegister({Notepad notepad}) {
    String textSaveUpdate = "";

    if (notepad == null) {
      textSaveUpdate = "Save";

      _titleController.text = "";
      _descriptionController.text = "";
    } else {
      textSaveUpdate = "Update";

      _titleController.text = notepad.title;
      _descriptionController.text = notepad.description;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogCupertino(
          title: "$textSaveUpdate Anotation",
          onPressed: () {
            _saveUpdateNotepad(notepad: notepad);
            Navigator.pop(context);
          },
          firstTextButton: textSaveUpdate,
          // secondTextButton: textSaveUpdate,
          firstController: _titleController,
          secondController: _descriptionController,
        );
      },
    );
  }

  _getNotePadList() async {
    List notepadsList = await _database.getNotePadListHelper();

    List<Notepad> notepadsTemp = List<Notepad>();
    for (var item in notepadsList) {
      Notepad notepad = Notepad.fromMap(item);
      notepadsTemp.add(notepad);
    }

    setState(() {
      _notepads = notepadsTemp;
    });

    notepadsTemp = null;

    print(notepadsList.toString());
  }

  _saveUpdateNotepad({Notepad notepad}) async {
    String title = _titleController.text;
    String description = _descriptionController.text;

    String dataConvert = DateTime.now().toString();

    if (notepad == null) {
      Notepad newNotepad = Notepad(title, description, dataConvert);
      int result = await _database.saveNotepadHelper(newNotepad);
    } else {
      notepad.title = title;
      notepad.description = description;
      int result = await _database.updateNotepad(notepad);
    }

    _titleController.clear();
    _descriptionController.clear();

    _getNotePadList();
  }

  _convertData(String data) {
    initializeDateFormatting('pt_BR', null);

    // year: y - month: M - Day: d
    // var formatador = DateFormat("dd/MMMM/y \'às' H:mm");
    var formatador = DateFormat.yMd("pt_BR");

    DateTime dataConverted = DateTime.parse(data);
    String resultConversion = formatador.format(dataConverted);

    return resultConversion;
  }

  @override
  void initState() {
    super.initState();
    _getNotePadList();
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notepads.length,
              itemBuilder: (context, index) {
                final item = _notepads[index];

                return Card(
                  child: ListTile(
                    title: Text("${item.title} - ${_convertData(item.data)}"),
                    subtitle: Text(item.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showCreateRegister(notepad: item);
                          },
                          child: Icon(
                            MdiIcons.pencilCircle,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            MdiIcons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
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
