import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recordapp/save_name.dart';
import 'package:recordapp/view/recorder_home_view.dart';

import '../const.dart';

class List_of_recorders extends StatefulWidget {
  late List<String> records;

  List_of_recorders({
    Key? key,
    required this.records,
  }) : super(key: key);

  @override
  _List_of_recordersState createState() => _List_of_recordersState();
}

class _List_of_recordersState extends State<List_of_recorders> {
  bool _isPlaying = false;
  int _selectedIndex = -1;
  AudioPlayer _audioPlayer = AudioPlayer();
  late Duration _Duration = Duration();
  late Duration _Postion = Duration();
  var c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return widget.records.isEmpty &&
            n.isEmpty &&
            n.length == widget.records.length
        ? Center(child: Text('No records yet'))
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: widget.records.length,
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                onLongPress: () {
                  showmasge(i);
                },
                child: Dismissible(
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.red,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Delete this Iteam",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          )
                        ]),
                  ),
                  key: Key(n[i]),
                  onDismissed: (d) {
                    Deletitaem(i);
                  },
                  child: ListTile(
                    onTap: (){
                      setState(() {
                        _selectedIndex=i;
                         _isPlaying=false;
                         _Postion=Duration(seconds: 0);
                      });
                      _onPlay(
                          filePath: widget.records.elementAt(i),
                          index: i);
                    },
                    title: Text(n[i]),
                    subtitle:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_getDateFromFilePatah(filePath: widget.records[i])),
                        if(_selectedIndex==i)
                          Slider(
                              value: _selectedIndex == i
                                  ? _Postion.inSeconds.toDouble()
                                  : 0,
                              min: 0.0,
                              max: _Duration.inSeconds.toDouble(),
                              onChanged: (v) {
                                _seek(v.toInt());
                              }),
                        if(_selectedIndex==i)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if(_selectedIndex==i)
                                  Text("${_Postion.inHours}:${_Postion.inMinutes}:${_Postion.inSeconds.remainder(60)}"),

                                if(_selectedIndex==i)
                                  Text("${_Duration.inHours}:${_Duration.inMinutes}:${_Duration.inSeconds.remainder(60)}"),

                              ],),

                          )
                        ,
                        if(_selectedIndex==i)
                        Center(
                          child: IconButton(
                            icon: _selectedIndex == i
                                ? _isPlaying
                                ? Icon(Icons.pause)
                                : Icon(Icons.play_arrow)
                                : Icon(Icons.play_arrow),
                            onPressed: () {
                              setState(() {
                                _selectedIndex = i;
                              });
                              _onPlay(
                                  filePath: widget.records.elementAt(i),
                                  index: i);
                            },
                          ),
                        ),

                      ],
                    ),

                  )

                  // ExpansionTile(
                  //   initiallyExpanded:_selectedIndex == i?true:false,
                  //   title: Text(n[i]),
                  //   subtitle: Text(_getDateFromFilePatah(
                  //       filePath: widget.records.elementAt(i))),
                  //   onExpansionChanged: ((newState) {
                  //     if (newState) {
                  //       setState(() {
                  //         _selectedIndex = i;
                  //       });
                  //     }
                  //   }),
                  //   children: [
                  //     Container(
                  //       height: 116,
                  //       padding: const EdgeInsets.all(10),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Slider(
                  //               value: _selectedIndex == i
                  //                   ? _Postion.inSeconds.toDouble()
                  //                   : 0,
                  //               min: 0.0,
                  //               max: _Duration.inSeconds.toDouble(),
                  //               onChanged: (v) {
                  //                 _seek(v.toInt());
                  //               }),
                  //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               if(_selectedIndex==i)
                  //             Text("${_Postion.inSeconds}:${_Postion.inMinutes}:${_Postion.inHours}"),
                  //             IconButton(
                  //               icon: _selectedIndex == i
                  //                   ? _isPlaying
                  //                   ? Icon(Icons.pause)
                  //                   : Icon(Icons.play_arrow)
                  //                   : Icon(Icons.play_arrow),
                  //               onPressed: () => _onPlay(
                  //                   filePath: widget.records.elementAt(i),
                  //                   index: i),
                  //             ),
                  //             if(_selectedIndex==i)
                  //             Text("${_Duration.inSeconds}:${_Duration.inMinutes}:${_Duration.inHours}"),
                  //
                  //           ],)
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              );
            },
          );
  }

  showmasge(int i) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              TextButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        n[i] = c.text;
                        Navigator.pop(context);
                        savedata.savenamed(n);
                      });
                    }
                  },
                  child: Text("OK",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))),
            ],
            actionsAlignment: MainAxisAlignment.end,
            backgroundColor: Colors.white,
            alignment: AlignmentDirectional.center,
            title: Form(
              key: formkey,
              child: TextFormField(
                controller: c,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Title mustn't empty";
                  }
                },
                maxLines: 5,
                minLines: 1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'New Title',
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

  _seek(int s) {
    Duration newDuration = Duration(seconds: s);
    _audioPlayer.seek(newDuration);
  }

  Deletitaem(i) async {
    iteamsdeled.add(widget.records[i]);
    n.removeAt(i);
    await savedata.savenamed(n);
    await savedata.iteamsdeled(iteamsdeled);
    await getApplicationDocumentsDirectory().then((value) {
      appDirectory = value;
      widget.records.clear();
      appDirectory.list().listen((onData) {
        if (onData.path.contains('.aac')) widget.records.add(onData.path);
      }).onDone(() {
        widget.records.forEach((e) {
          if (iteamsdeled.contains(e)) toRemove.add(e);
        });
        widget.records.removeWhere((e) => toRemove.contains(e));
        widget.records = widget.records.reversed.toList();

        setState(() {});
      });
    });
    setState(() {});
  }

  Future<void> _onPlay({required String filePath, required int index}) async {

      if (_isPlaying)
      {
        _audioPlayer.pause();
        setState(() {
          _isPlaying = false;
        });
      }
      else {
        _audioPlayer.play(filePath, isLocal: true, position: _Postion,recordingActive: );
        setState(() {
          _isPlaying = true;
          _Postion = Duration(seconds: 0);
        });
        _audioPlayer.onAudioPositionChanged.listen((event) {
          setState(() {
            _Postion = event;
          });
        });
        _audioPlayer.onDurationChanged.listen((event) {
          setState(() {
            _Duration = event;

          });
        });
        _audioPlayer.onPlayerCompletion.listen((event) {
          setState(() {
            _isPlaying = false;
            _Postion = Duration(seconds: 0);
          });
        });
      }


  }

  String _getDateFromFilePatah({required String filePath}) {
    String fromEpoch = filePath.substring(
        filePath.lastIndexOf('/') + 1, filePath.lastIndexOf('.'));

    DateTime recordedDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(fromEpoch));
    int year = recordedDate.year;
    int month = recordedDate.month;
    int day = recordedDate.day;


    return ("$day- $month -$year ");
  }
}
