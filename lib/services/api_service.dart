import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ChatGPT/models/chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:ChatGPT/constants/api_consts.dart';
import 'package:ChatGPT/models/models_model.dart';
import 'package:ChatGPT/constants/constants.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      final response = await http.get(Uri.parse("$BASE_URL/models"),
          headers: {'Authorization': 'Bearer $API_KEY'});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw Exception(jsonResponse['error']['message']);
      }

      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
      }

      return ModelsModel.modelsFromSnapshot(temp);
    } catch (e) {
      rethrow;
    }
  }

  // Send MEssage using CHatGPT API
  static Future<List<ChatModel>> sendMessageGPT(
      {required String message,
      required String modelId,
      required List<ChatModel> chatsList,
      required bool memory}) async {
    try {
      log("modelId $modelId");

      final memChats = List<Map<String, String>>.empty(growable: true);
      if (memory) {
        // add all previous chats for model to process (consumes tokens)
        memChats.addAll(chatsList.map((chat) => {
              "role": chat.role,
              "content": chat.msg,
            }));
      } else {
        // if no memory, send only the new message
        memChats.add({
          "role": ResponseType.user.name,
          "content": message,
        });
      }

      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {"model": modelId, "messages": memChats},
        ),
      );

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
              msg: jsonResponse["choices"][index]["message"]["content"],
              chatIndex: 1,
              role: ResponseType.assistant.name),
        );
      }

      return chatList;
    } catch (e) {
      log("error $e");
      rethrow;
    }
  }

  // Send Message Fct
  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 300,
          },
        ),
      );

      // Map jsonResponse = jsonDecode(response.body);

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
              msg: jsonResponse["choices"][index]["text"],
              chatIndex: 1,
              role: ResponseType.assistant.name),
        );
      }
      return chatList;
    } catch (e) {
      rethrow;
    }
  }
}
