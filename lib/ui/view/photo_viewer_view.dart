import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerView extends StatelessWidget {
  String? path;

  PhotoViewerView({Key? key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Stack(
              children: [
                PhotoView(
                  imageProvider: NetworkImage(path!),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back, color: Colors.white,),
                    )
                ),
              ],
            )
        ),
      )
    );
  }
}