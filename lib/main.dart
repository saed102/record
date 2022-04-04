import 'package:flutter/material.dart';
import 'package:recordapp/save_name.dart';
import 'package:recordapp/view/recorder_home_view.dart';
import 'package:recordapp/const.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await savedata.init();
  if ((await savedata.getnamed("key")) != null) n = (await savedata.getnamed("key"))!;
  if ((await savedata.getiteamsdeled("key2")) != null) iteamsdeled = (await savedata.getiteamsdeled("key2"))!;

  print(n);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Recorder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RecorderHomeView(
        title: 'Call Recording',
      ),
    );
  }
}
