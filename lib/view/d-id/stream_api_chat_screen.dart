import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipapi/const/loader.dart';
import 'package:ipapi/view_model/chat_view_model.dart';
import 'package:video_player/video_player.dart';

class StreamChatScreen extends StatefulWidget {
  const StreamChatScreen({Key? key}) : super(key: key);

  @override
  State<StreamChatScreen> createState() => _StreamChatScreenState();
}

class _StreamChatScreenState extends State<StreamChatScreen> {
  ChatViewModel chatViewModel = Get.put(ChatViewModel());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.withAlpha(200),
        title: Text('D - ID'),
      ),
      bottomSheet: GetBuilder<ChatViewModel>(
        builder: (controller) {
          return Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.promptController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          hintText: 'Enter a prompt here',
                        ),
                      ),
                    ),
                    if (controller.showSendButton == true)
                      IconButton(
                        splashRadius: 20,
                        onPressed: () async {
                          if (controller.promptController.text.isNotEmpty) {}
                        },
                        icon: Icon(Icons.send),
                      )
                  ],
                ),
              ],
            ),
          );
        },
      ),
      body: GetBuilder<ChatViewModel>(
        builder: (controller) {
          return Center(
            child: Column(
              children: [
                if (controller.loadingVideo == true)
                  VideoPlayerData(controller: controller),
                if (controller.loadingVideo == false)
                  Container(
                    height: 300,
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    child: Image.network(
                      'https://create-images-results.d-id.com/DefaultPresenters/Emma_f/image.jpeg',
                      height: 300,
                      width: 300,
                    ),
                  ),
                if (controller.showLottiAnimation == true)
                  LottieAnimAnimation(),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.promptList.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue.withAlpha(30),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Text(
                                  '${controller.promptList[index]}',
                                  maxLines: 10,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16);
                    },
                  ),
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

/// VIDEO PLAYER FOR AI SPEAKING
class VideoPlayerData extends StatefulWidget {
  final ChatViewModel controller;
  const VideoPlayerData({Key? key, required this.controller}) : super(key: key);

  @override
  State<VideoPlayerData> createState() => _VideoPlayerDataState();
}

class _VideoPlayerDataState extends State<VideoPlayerData> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 1),
      () {
        widget.controller.videoPlayerController!.addListener(() {
          if (!widget.controller.videoPlayerController!.value.isPlaying &&
              widget.controller.videoPlayerController!.value.isInitialized &&
              (widget.controller.videoPlayerController!.value.duration ==
                  widget.controller.videoPlayerController!.value.position)) {
            widget.controller.updateLoadingValue(false);
            widget.controller.updateShowSendButton(true);
            widget.controller.videoPlayerController!.dispose();
          }
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      padding: const EdgeInsets.all(20),
      child: VideoPlayer(widget.controller.videoPlayerController!),
    );
  }
}
