import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AddTasksScreen extends StatefulWidget {
  const AddTasksScreen({Key key}) : super(key: key);

  @override
  _AddTasksScreenState createState() => _AddTasksScreenState();
}

class _AddTasksScreenState extends State<AddTasksScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  _dateFormatter(DateTime data) {
    initializeDateFormatting('en_US', null);

    var formatador = DateFormat.yMMMMd("en_US");

    DateTime dataConverted = data;
    String resultConversion = formatador.format(dataConverted);

    return resultConversion;
  }

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: 30.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Add task',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (input) => input.trim().isEmpty
                        ? 'Please enter a task title'
                        : null,
                    onSaved: (input) => _title = input,
                    initialValue: _title,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: TextFormField(
                    onTap: _handleDatePicker,
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (input) => input.trim().isEmpty
                        ? 'Please enter a task title'
                        : null,
                    onSaved: (input) => _title = input,
                    initialValue: _title,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
