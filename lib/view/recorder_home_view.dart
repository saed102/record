import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recordapp/save_name.dart';
import 'package:recordapp/view/recorded_list_view.dart';
import 'package:recordapp/view/recorder_view.dart';
import 'package:recordapp/const.dart';

class RecorderHomeView extends StatefulWidget {
  final String _title;

  const RecorderHomeView({Key? key, required String title})
      : _title = title,
        super(key: key);

  @override
  _RecorderHomeViewState createState() => _RecorderHomeViewState();
}

class _RecorderHomeViewState extends State<RecorderHomeView> {
  List<String> records = [];

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((value) {
      appDirectory = value;
      appDirectory.list().listen((onData) {
        if (onData.path.contains('.aac')) records.add(onData.path);
      }).onDone(() {
        records.forEach((e) {
          if (iteamsdeled.contains(e)) toRemove.add(e);
        });
        records.removeWhere((e) => toRemove.contains(e));
        records = records.reversed.toList();
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    appDirectory.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: List_of_recorders(
              records: records,
            ),
          ),
          Recorder(
            onSaved: _onSave,
          ),
        ],
      ),
    );
  }

  _onSave() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        n = n.reversed.toList();
                        n.add(control.text);
                        n = n.reversed.toList();
                        print(n);
                        records.clear();
                        appDirectory.list().listen((onData) {
                          if (onData.path.contains('.aac'))
                            records.add(onData.path);
                        }).onDone(() {
                          records.forEach((e) {
                            if (iteamsdeled.contains(e)) toRemove.add(e);
                          });
                          records.removeWhere((e) => toRemove.contains(e));
                          records = records.reversed.toList();
                          setState(() {});
                          Navigator.pop(context);
                          control.clear();
                          savedata.savenamed(n);
                        });
                      });
                    }
                  },
                  child: Text("OK",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))),
            ],
            actionsAlignment: MainAxisAlignment.end,
            backgroundColor: Colors.white,
            alignment: AlignmentDirectional.center,
            title: Form(
              key: formkey,
              child: TextFormField(
                controller: control,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Title mustn't empty";
                  }
                },
                maxLines: 5,
                minLines: 1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(20),
                      left: Radius.circular(20),
                    ))),
              ),
            ),
            elevation: 17,
          );
        });
  }
}
