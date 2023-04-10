import 'package:ChatGPT/models/chat_model.dart';
import 'package:ChatGPT/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:ChatGPT/constants/constants.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList => chatList;

  void addUserMessage({required String msg}) {
    chatList
        .add(ChatModel(msg: msg, chatIndex: 0, role: ResponseType.user.name));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg,
      required String chosenModelId,
      required bool memory}) async {
    if (chosenModelId.toLowerCase().startsWith("gpt")) {
      chatList.addAll(
        await ApiService.sendMessageGPT(
            message: msg,
            modelId: chosenModelId,
            chatsList: chatList,
            memory: memory),
      );
    } else {
      chatList.addAll(
        await ApiService.sendMessage(
          message: msg,
          modelId: chosenModelId,
        ),
      );
    }
    notifyListeners();
  }
}
