import 'package:NotePad/database/notepad_helper.dart';

class Notepad {
  int id;
  String title;
  String description;
  String data;

  Notepad(this.title, this.description, this.data);

  Notepad.fromMap(Map map) {
    this.id = map[NotepadHelper.columnID];
    this.title = map[NotepadHelper.title];
    this.description = map[NotepadHelper.description];
    this.data = map[NotepadHelper.data];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      NotepadHelper.title: this.title,
      NotepadHelper.description: this.description,
      NotepadHelper.data: this.data,
    };

    if (this.id != null) {
      map[NotepadHelper.columnID] = this.id;
    }

    return map;
  }
}
