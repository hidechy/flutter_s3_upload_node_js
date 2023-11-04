import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';

import 'api_service.dart';

class S3UploadPage extends StatefulWidget {
  const S3UploadPage({super.key});

  @override
  State<S3UploadPage> createState() => _S3UploadPageState();
}

class _S3UploadPageState extends State<S3UploadPage> {
  bool isApiCallProcess = false;

  String singleImageFile = '';

  List<String> selectedMultiImages = [];

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('S3 Uploading')),
      body: ProgressHUD(
        key: UniqueKey(),
        inAsyncCall: isApiCallProcess,
        child: uploadUi(),
      ),
    );
  }

  ///
  Widget uploadUi() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //=======================//

          const Text(
            'Single Image',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            child: MultiImagePicker(
              totalImages: 1,
              initialValue: const [],
              imageSource: ImagePickSource.camera,
              onImageChanged: (images) {
                // ignore: avoid_dynamic_calls
                singleImageFile = images[0].imageFile;
              },
            ),
          ),

          //=======================//

          const Text(
            'Multi Image',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            child: MultiImagePicker(
              totalImages: 5,
              initialValue: const [],
              imageSource: ImagePickSource.camera,
              onImageChanged: (images) {
                selectedMultiImages = [];
                // ignore: avoid_dynamic_calls
                images.forEach((dynamic image) {
                  if (image is ImageUploadModel) {
                    selectedMultiImages.add(image.imageFile);
                  }
                });
              },
            ),
          ),

          //=======================//

          Center(
            child: FormHelper.submitButton(
              'upload',
              () async {
                setState(() => isApiCallProcess = true);

                await ApiService.uploadImages(singleImageFile, selectedMultiImages).then((value) {
                  setState(() => isApiCallProcess = false);
                });
              },
              borderRadius: 10,
            ),
          ),

          //=======================//

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
