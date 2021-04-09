import 'dart:io';

import '../../models/imageupload.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class SingleImageEdit extends StatefulWidget {
  final List<Object> images;
  final void Function(int, Object) notifyParent;
  SingleImageEdit(this.notifyParent, this.images);
  @override
  _SingleImageEditState createState() {
    return _SingleImageEditState();
  }
}

class _SingleImageEditState extends State<SingleImageEdit> {
  Dio dio = Dio();
  // ignore: deprecated_member_use
  List<Object> images = List<Object>();
  Future<PickedFile> _imageFile;
  File _image;
  ImagePicker _imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
    setState(() {
      for (var i = 0; i < widget.images.length; i++) {
        print(widget.images[i]);
        images.add(NetworkImage(widget.images[i]));
        print("added ${i + 1}");
      }
      for (var i = widget.images.length; i < 3; i++) {
        images.add("Add Image");
        print("added add image ${i + 1}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: buildGridView(),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel ||
            images[index] is NetworkImage) {
          ImageUploadModel uploadModel;
          if (images[index] is ImageUploadModel) {
            uploadModel = images[index];
          }
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                if (images[index] is NetworkImage)
                  Image(
                    image: images[index],
                    width: 300,
                    height: 300,
                  )
                else if (images[index] is ImageUploadModel)
                  Image.file(
                    uploadModel.imageFile,
                    width: 300,
                    height: 300,
                  ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = _imagePicker.getImage(source: ImageSource.gallery);
      if (_imageFile != null) getFileImage(index);
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      print(images);
      setState(() {
        if (file != null) {
          _image = File(file.path);
          ImageUploadModel imageUpload = new ImageUploadModel();
          imageUpload.isUploaded = false;
          imageUpload.uploading = false;
          imageUpload.imageFile = _image;
          imageUpload.imageUrl = '';
          images.replaceRange(index, index + 1, [imageUpload]);
          widget.notifyParent(index, _image);
        }
      });
    });
  }
}
