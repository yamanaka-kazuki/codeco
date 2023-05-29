import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddQrCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: AddQrCodePageArea(),
    );
  }
}

class AddQrCodePageArea extends StatefulWidget {
  @override
  _AddQrCodePageAreaState createState() => _AddQrCodePageAreaState();
}

class _AddQrCodePageAreaState extends State<AddQrCodePageArea> {
  late File? _image;
  late String _title;
  late DateTime _selectedDate;

  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // フォームがバリデーションを通過した場合の処理
      // データの送信や保存を行うなどの処理を追加する
      print('Image: $_image');
      print('Title: $_title');
      print('Date: $_selectedDate');
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Text('画像をアップロード'),
                ),
                SizedBox(height: 16.0),
                _image != null
                    ? Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      )
                    : Container(),
                SizedBox(height: 16.0),
                CupertinoTextField(
                  onChanged: (value) {
                    _title = value;
                  },
                  placeholder: 'タイトル',
                ),
                SizedBox(height: 16.0),
                CupertinoButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  color: CupertinoColors.systemGrey5,
                  child: Text(
                    '日付を選択',
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text('選択された日付: $_selectedDate'),
                SizedBox(height: 16.0),
                CupertinoButton.filled(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text('送信'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
