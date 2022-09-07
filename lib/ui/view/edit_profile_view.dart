import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/viewmodel/angket_viewmodel.dart';
import 'package:simakan/core/viewmodel/auth_viewmodel.dart';
import 'package:simakan/core/viewmodel/home_viewmodel.dart';
import 'package:simakan/ui/base_view.dart';
import 'package:simakan/ui/view/photo_viewer_view.dart';
import 'package:simakan/ui/view/question_view.dart';
import 'package:simakan/ui/view/success_view.dart';
import 'package:simakan/ui/widget/modal_progress.dart';
import 'package:toast/toast.dart';

class EditProfileView extends StatefulWidget {

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _nisController = TextEditingController();
  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  File? _imageFile;
  dynamic _pickImageError;
  String? _retrieveDataError;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  _onImageButtonPressed(ImageSource? source) async {
    try {
      final pickedFile = await picker.getImage(source: source!);
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      _pickImageError = e;
    }
    if(_imageFile != null){
      await _cropImage();
    }
    setState(() {});
  }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _imageFile!.path,
        aspectRatioPresets: Platform.isAndroid ? [CropAspectRatioPreset.square]
            : [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            hideBottomControls: true,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image',
          cancelButtonTitle: 'Batal',
          doneButtonTitle: 'Gunakan',
          resetButtonHidden: true,
          rotateButtonsHidden: true,
          aspectRatioPickerButtonHidden: true,
          aspectRatioLockEnabled: false,
        )
    );

    if (croppedFile != null) {
      _imageFile = croppedFile;
      setState((){});
      await AuthViewModel().changePhotoProfile(
        file: _imageFile,
        onSuccess: () async {
          Toast.show("Foto berhasil diupdate", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          await AuthViewModel().getUser(context);
        },
        onError: (error) {
          Toast.show(error, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        },
        context: context
      );
    }else{
      _imageFile = null;
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profil"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: BaseView<AuthViewModel>(
        onModelReady: (data) async {
          await data.getUser(context);
          _nisController.text = data.user!.siswaNis!;
          _nameController.text = data.user!.siswaName!;
          _classController.text = data.user!.className!;
          _emailController.text = data.user!.siswaEmail!;
          _phoneController.text = data.user!.siswaPhoneNumber!;
        },
        builder: (context, data, child) =>
          ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: data.user == null ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: () {
                            showDialogPhotoProfile(data);
                          },
                          child: Container(
                            child: Image.network("${data.user!.siswaImages}", width: 100, height: 100, fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextField(
                      controller: _nisController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "NIS",
                        labelText: "Nomor Induk Siswa",
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Nama Siswa",
                        labelText: "Nama Siswa",
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _classController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Kelas",
                        labelText: "Kelas",
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: "Nomor Telepon",
                        labelText: "Nomor Telepon",
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: MaterialButton(
                        onPressed: () async {
                          await AuthViewModel().updateProfile(
                              name: _nameController.text,
                              email: _emailController.text,
                              phoneNumber: _phoneController.text,
                              onSuccess: () {
                                Toast.show("Data berhasil diupdate", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                data.getUser(context);
                              },
                              onError: (error) {
                                Toast.show(error, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                              },
                              context: context
                          );
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        color: Colors.deepPurple,
                        elevation: 0,
                        padding: EdgeInsets.all(0),
                        height: 50,
                        minWidth: double.infinity,
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
      ),
    );
  }

  showDialogPhotoProfile(AuthViewModel data) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (BuildContext bc){
          return SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.deepPurple,),
                        title: Text('Lihat foto profil', style: TextStyle(fontSize: 12),),
                        enabled: data.user!.siswaImages != null ? true : false,
                        onTap: () async {
                          if (data.user!.siswaImages != null) {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PhotoViewerView(path: data.user!.siswaImages),
                                )
                            );
                          }
                        }
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt, color: Colors.deepPurple),
                      title: Text('Ganti foto profil dari kamera', style: TextStyle(fontSize: 12),),
                      onTap: () async {
                        Navigator.pop(context);
                        await _onImageButtonPressed(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.photo, color: Colors.deepPurple),
                      title: Text('Ganti foto profil dari galeri', style: TextStyle(fontSize: 12),),
                      onTap: () async {
                        Navigator.pop(context);
                        await _onImageButtonPressed(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }
}