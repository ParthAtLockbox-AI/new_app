import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipapi/const/loader.dart';
import 'package:ipapi/view_model/audio_to_text_view_model.dart';

class AudioToTextScreen extends StatefulWidget {
  const AudioToTextScreen({Key? key}) : super(key: key);

  @override
  State<AudioToTextScreen> createState() => _AudioToTextScreenState();
}

class _AudioToTextScreenState extends State<AudioToTextScreen> {
  TranscriptViewModel transcriptViewModel = Get.put(TranscriptViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<TranscriptViewModel>(
        builder: (controller) {
          return Container(
            height: 100,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  await ConvertAudioToTextFunction(controller, context);
                },
                child: Text('Pick audio'),
              ),
            ),
          );
        },
      ),
      body: GetBuilder<TranscriptViewModel>(
        builder: (controller) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.loadingAudioFile) LottieAnimAnimation(),
                  Text('${controller.scriptController.text}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> ConvertAudioToTextFunction(
      TranscriptViewModel controller, BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'wav',
        'aiff',
        'alac',
        'flac',
        'mp3',
        'aac',
        'wma',
        'ogg'
      ],
    );

    if (result != null) {
      controller.scriptController.clear();
      controller.update();
      if (GetPlatform.isIOS || GetPlatform.isAndroid) {
        try {
          File audioFile = File(result.files.single.path!);
          Map<String, dynamic> data =
              await controller.audioToTextRepo(audioFile: audioFile.path);
          if (data['status'] == false) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(data['text'].toString())));
          }
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Server error')));
          controller.updateAudioFile(false);
        }
      } else {
        try {
          Uint8List audioFile = result.files.single.bytes!;
          Map<String, dynamic> data = await controller.audioToTextRepo(
              audioFileForWeb: audioFile, audioFile: '');
          if (data['status'] == false) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(data['text'].toString())));
          }
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Server error')));
          controller.updateAudioFile(false);
        }
      }
    } else {
      controller.updateAudioFile(false);
    }
  }
}
