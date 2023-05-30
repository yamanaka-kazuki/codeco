import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import 'object_box.dart';
import 'models/qr_model.dart';

late ObjectBox objectbox;

class AddQrCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddQrCodePageArea();
  }
}

class AddQrCodePageArea extends StatefulWidget {
  @override
  _AddQrCodePageAreaState createState() => _AddQrCodePageAreaState();
}

class _AddQrCodePageAreaState extends State<AddQrCodePageArea> {
  @override
  Future<void> initState() async {
    super.initState();
    objectbox = await ObjectBox.create();
    _selectedDate = DateTime.now();
    _image = null;
  }

  late Image? _image;
  late String _title;
  late DateTime _selectedDate;

  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final qrBox = objectbox.store.box<QrModel>();

  // DatePicker用
  final textEditingController = TextEditingController();

  Future _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        final imageForFile = File(pickedFile.path);
        _image = Image.file(imageForFile);
      }
    });
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2022),
  //     lastDate: DateTime(2025),
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  //   }
  // }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // フォームがバリデーションを通過した場合の処理
      // データの送信や保存を行うなどの処理を追加する
      final qrData = QrModel(
        title: _title,
        image: _image,
        deadline: _selectedDate,
        isUsed: false,
      );

      qrBox.put(qrData);
    }
  }

  Future _getDate(BuildContext context) async {
    final initialDate = DateTime.now();
    String pickedDate = '';

    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
    );

    if (newDate != null) {
      // 選択した日付をTextFormFieldに設定
      pickedDate = DateFormat('yyyy年M月d日').format(newDate);
      textEditingController.text = DateFormat('yyyy年M月d日').format(newDate);
      setState(() {
        _selectedDate = newDate;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 180,
                height: 300,
                margin: const EdgeInsets.only(top: 30, bottom: 40),
                child: _displaySelectionImageOrGreyImage(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _getImageFromGallery();
                },
                icon: Icon(CupertinoIcons.camera, size: 14),
                label: Text('画像をアップロード'),
              ),
              CupertinoTextField(
                onChanged: (value) {
                  _title = value;
                },
                placeholder: 'タイトルを入力',
              ),
              CupertinoTextField(
                controller: textEditingController,
                placeholder: '日付を選択',
                onTap: () {
                  _getDate(context);
                },
              ),
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
    );
  }

  Widget _displaySelectionImageOrGreyImage() {
    if (_image == null) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xffdfdfdf),
          border: Border.all(
            width: 1,
            color: const Color(0xff000000),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xff000000),
          ),
        ),
        child: Image.asset('assets/images/no-image.jpeg'),
      );
    }
  }
}
