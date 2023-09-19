import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipapi/const/loader.dart';
import 'package:ipapi/model/create_talk_res_model.dart';
import 'package:ipapi/model/get_all_talk_res_model.dart';
import 'package:ipapi/model/get_talk_api_res_model.dart';
import 'package:ipapi/service/api_service/api_response.dart';
import 'package:ipapi/view_model/chat_view_model.dart';
import 'package:video_player/video_player.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatViewModel chatViewModel = Get.put(ChatViewModel());
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    chatViewModel.getAllTalkViewModel(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.withAlpha(200),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.history),
        ),
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
                          if (controller.promptController.text.isNotEmpty) {
                            controller.updateShowSendButton(false);
                            controller.updateShowLottiAnimation(true);

                            createTalkApiCalling(
                                controller: controller, context: context);
                          }
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
      drawer: Container(
        width: 300,
        height: Get.height,
        color: Colors.white,
        child: GetBuilder<ChatViewModel>(
          builder: (controller) {
            if (controller.getAllTalkApiResponse.status == Status.LOADING) {
              return LottieAnimAnimation();
            }
            if (controller.getAllTalkApiResponse.status == Status.COMPLETE) {
              GetAllTalkResponseModel getAllTalkResponseModel =
                  controller.getAllTalkApiResponse.data;
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: getAllTalkResponseModel.talks == null
                    ? 0
                    : getAllTalkResponseModel.talks!.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              scaffoldKey.currentState?.closeDrawer();
                              controller.initializeVideoPlayer(
                                  url: getAllTalkResponseModel
                                      .talks![index].resultUrl);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue.withAlpha(30),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Text(
                                '${getAllTalkResponseModel.talks![index].resultUrl}',
                                maxLines: 2,
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                              ),
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
              );
            } else {
              return Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
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
                      'https://wallpapercave.com/dwp1x/wp11455901.jpg',
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

/// CREATE TALK API
createTalkApiCalling(
    {required ChatViewModel controller, required BuildContext context}) async {
  await controller.updatePromptList(controller.promptController.text);

  Map<String, dynamic> body = {
    "script": {"type": "text", "input": "${controller.promptList.last}"},
    "source_url": controller.faceUrl
  };
  try {
    await controller.createTalkViewModel(
      context: context,
      body: body,
    );
    if (controller.createTalkApiResponse.status == Status.COMPLETE) {
      CreateTalkResponseModel talkResponseModel =
          controller.createTalkApiResponse.data;
      await Future.delayed(
        Duration(seconds: controller.promptList.last.length > 50 ? 20 : 5),
        () async {
          await getTalkApi(
              controller: controller,
              context: context,
              id: talkResponseModel.id);
        },
      );
    }
    if (controller.createTalkApiResponse.status == Status.ERROR) {
      print('----ERROR----');
      controller.clearValue();
    }
  } catch (e) {
    controller.clearValue();

    print('----ERROR---1-$e');
  }
}

/// GET TALK API
Future<void> getTalkApi(
    {ChatViewModel? controller, BuildContext? context, String? id}) async {
  try {
    await controller!.getTalkViewModel(
      context: context,
      fileId: id,
    );
    if (controller.getTalkApiResponse.status == Status.COMPLETE) {
      GetTalkResponseModel videoData = controller.getTalkApiResponse.data;
      log('---videoData-----${videoData.toJson()}-----${videoData.resultUrl}');
      controller.initializeVideoPlayer(url: videoData.resultUrl);
      await controller.getAllTalkViewModel(context: context);
    }
    if (controller.getTalkApiResponse.status == Status.ERROR) {
      controller.clearValue();

      print('--GET--ERROR----');
    }
  } catch (e) {
    controller!.clearValue();

    print('--GET--ERROR---1-$e');
  }
}
