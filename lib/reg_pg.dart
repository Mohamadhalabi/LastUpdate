import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utility.dart';
import 'loading.dart';

class Reg_pg extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<Reg_pg> {
  Future<File> imageFile;
  Image imageFromPreferences;
  Timer timer1;
  Timer timer2;
  TextEditingController namecontroler = new TextEditingController();
  TextEditingController surenamecontroler = new TextEditingController();

  Future<File> imageFile1;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile1 = ImagePicker.pickImage(source: ImageSource.gallery);
      Timer(Duration(seconds: 1), () => loadImageFromPreferences());
    });
  }

  pickImageFromCamera(ImageSource source) {
    setState(() {
      imageFile1 = ImagePicker.pickImage(source: ImageSource.camera);
      Timer(Duration(seconds: 1), () => loadImageFromPreferences());
    });
  }

  loadImageFromPreferences() {
    Utility.getImageFromPreferences().then((img) {
      if (null == img) {
        return;
      }

      setState(() {
        imageFromGallery();
        imageFromPreferences = Utility.imageFromBase64String(img);
      });
    });
  }

  imageFromCamera() {
    return FutureBuilder<File>(
      future: imageFile1,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          Utility.saveImageToPreferences(
              Utility.base64String(snapshot.data.readAsBytesSync()));
          return const Text(
            '',
            textAlign: TextAlign.center,
          );
        } else if (null != snapshot.error) {
          return const Text(
            '',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            '',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  imageFromGallery() {
    return FutureBuilder<File>(
      future: imageFile1,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          //print(snapshot.data.path);
          Utility.saveImageToPreferences(
              Utility.base64String(snapshot.data.readAsBytesSync()));
          return const Text(
            '',
            textAlign: TextAlign.center,
          );
        } else if (null != snapshot.error) {
          return const Text(
            '',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            '',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  void storeData(String name, String surename) async {
    print(name);
    print(surename);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(prefs.getString("surename"));

    prefs.setString('user_name', name);
    prefs.setString('surename', surename);

    print("data stored");
  }

  Future<void> _ShowChoiseDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Make your choise'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.image),
                    onPressed: () {},
                    label: Text('Image'),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  FlatButton.icon(
                    icon: Icon(Icons.camera),
                    onPressed: () {},
                    label: Text('Camera'),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget nameval() {
    return TextFormField(
      controller: namecontroler,
      validator: (value) {
        if (value.isEmpty) return "name is not empty";
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.lightBlue,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.lightBlue,
          ),
          labelText: "Name",
          helperText: "Name Cant Be Empty",
          hintText: "example"),
    );
  }

  Widget sureName() {
    return TextFormField(
      controller: surenamecontroler,
      validator: (value) {
        if (value.isEmpty) return "surename is not empty";
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.lightBlue,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.lightBlue,
          ),
          labelText: "Surename",
          helperText: "Surename Cant Be Empty",
          hintText: "example"),
    );
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Center(
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage('assets/image.png'),
            ),
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: InkWell(
                onTap: () async {
                  _ShowChoiseDialog(context);
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.lightBlue,
                  size: 28.0,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 80.0,
              child: imageFromGallery(),
            ),
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: InkWell(
                onTap: () async {
                  _decideImageView();
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.lightBlue,
                  size: 28.0,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _ShowChoise(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Make your choise'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      pickImageFromGallery(ImageSource.gallery);
                      setState() {
                        imageFromGallery();
                        loadImageFromPreferences();
                        Timer(Duration(seconds: 1),
                            () => loadImageFromPreferences());
                      }
                    },
                    label: Text('Image'),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  FlatButton.icon(
                    icon: Icon(Icons.camera),
                    onPressed: () {
                      pickImageFromCamera(ImageSource.camera);
                      setState() {
                        // imageFromPreferences = null;
                        imageFromCamera();
                        loadImageFromPreferences();
                        Timer(Duration(seconds: 1),
                            () => loadImageFromPreferences());
                      }
                    },
                    label: Text('Camera'),
                  )
                ],
              ),
            ),
          );
        });
  }

  void logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();

    setState(() {
      imageFromPreferences = null;
    });
  }

  int i = 0;

  void loadimage() {
    if (imageFromPreferences == null) {
      loadImageFromPreferences();
    }

    if (imageFromPreferences != null) {
      for (i; i < 2; i++) {
        loadImageFromPreferences();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadImageFromPreferences();

    imageFromGallery();
    timer1 = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              imageFromPreferences;
            }));
    timer2 = Timer.periodic(Duration(seconds: 1), (Timer t) => loadimage());
  }

  @override
  void dispose() {
    timer1.cancel();
    timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              loadImageFromPreferences();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              logout();
            },
          ),
        ],
        title: Text('Registration Page'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // _decideImageView(),

              imageFromGallery(),

              null == imageFromPreferences
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200.0,
                          height: 200.0,
                          decoration: new BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.white70,
                            size: 200,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.lightBlue,
                            size: 28.0,
                          ),
                          onPressed: () {
                            _ShowChoise(context);
                          },
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200.0,
                          height: 200.0,
                          decoration: new BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: imageFromPreferences,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.teal,
                            size: 28.0,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),

              nameval(),
              sureName(),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  storeData(namecontroler.text, surenamecontroler.text);

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Loadingpg()));
                },
                child: Text('save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
