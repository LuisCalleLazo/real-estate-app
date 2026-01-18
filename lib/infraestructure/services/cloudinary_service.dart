import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudinaryService {
  final String cloudName;
  final String uploadPreset;

  CloudinaryService({required this.cloudName, required this.uploadPreset});

  Future<String> uploadImage(File image) async {
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Error al subir imagen a Cloudinary');
    }

    final responseData = json.decode(await response.stream.bytesToString());

    return responseData['secure_url'];
  }

  Future<List<String>> uploadImages(List<File> images) async {
    final urls = <String>[];

    for (final image in images) {
      final url = await uploadImage(image);
      urls.add(url);
    }

    return urls;
  }
}
