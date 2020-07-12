import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  const ImageSourceSheet({Key key, this.onImageSelected}) : super(key: key);

  void imageSelected(File file) {
    if (file != null) {
      onImageSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            child: Text('Câmera'),
            onPressed: () async {
              File file =
                  await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 70, maxHeight: 480, maxWidth: 480);
              imageSelected(file);
            },
          ),
          FlatButton(
            child: Text('Galeria'),
            onPressed: () async {
              File file =
                  await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 480, maxWidth: 480);
              imageSelected(file);
            },
          ),
        ],
      ),
    );
  }
}
