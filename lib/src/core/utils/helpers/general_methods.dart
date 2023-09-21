import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

String errorParser(DioException error) {
  final message = error.response?.data?['message'];
  if (message is Map) {
    return message[message.keys.first]?.first ?? '';
  } else if (message is String) {
    return message;
  }
  return 'no_internet'.tr;
}

Future<XFile> compressImage(
    String path,
    ) async {
  String extension = path.split('.').last;

  final dir = await getTemporaryDirectory();
  final tmpDir = dir.path;
  final target =
      "$tmpDir/${DateTime.now().millisecondsSinceEpoch}.$extension";
  var result = await FlutterImageCompress.compressAndGetFile(
    path,
    target,
    quality: 70,
    minWidth: 1024,
    minHeight: 1024,
    rotate: 0,
  );

  return result!;
}