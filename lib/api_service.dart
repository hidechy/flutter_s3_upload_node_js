import 'package:http/http.dart' as http;

// ignore: avoid_classes_with_only_static_members
class ApiService {
  static http.Client client = http.Client();

  ///
  static Future<bool> uploadImages(String singleImageFile, List<String> multipleImages) async {
    final url = Uri.http('10.0.2.2:4000', '/api/image-upload');

    final request = http.MultipartRequest('post', url);

    if (singleImageFile.isNotEmpty) {
      final singleFile = await http.MultipartFile.fromPath('singlefile', singleImageFile);

      request.files.add(singleFile);
    }

    if (multipleImages.isNotEmpty) {
      multipleImages.forEach((element) async {
        final multiFile = await http.MultipartFile.fromPath('multiplefiles', element);

        request.files.add(multiFile);
      });
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
