import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TranscriptViewModel extends GetxController {
  TextEditingController scriptController = TextEditingController();
  bool loadingAudioFile = false;

  updateAudioFile(bool val) {
    loadingAudioFile = val;
    update();
  }

  Future<Map<String, dynamic>> audioToTextRepo(
      {required String audioFile, Uint8List? audioFileForWeb}) async {
    updateAudioFile(true);

    var headers = {
      'Authorization':
          'Bearer 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'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.openai.com/v1/audio/transcriptions'));
    request.fields.addAll({'model': 'whisper-1'});
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      request.files.add(await http.MultipartFile.fromString('file', audioFile));
    } else {
      request.files
          .add(await http.MultipartFile.fromBytes('file', audioFileForWeb!));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode >= 200 && response.statusCode < 299) {
      var data = jsonDecode(await response.stream.bytesToString());
      scriptController.text = data['text'];
      update();
      updateAudioFile(false);
      print('-------DATA--200--${data}');
      return {'status': true, 'text': scriptController.text};
    } else {
      var data = jsonDecode(await response.stream.bytesToString());
      updateAudioFile(false);
      print('-------DATA--400--${data}');
      update();
      return {'status': false, 'text': data['error']['message']};
    }
  }
}
