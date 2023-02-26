import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../../../model/text_completion_model.dart';

class ChatTextController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  // @override
  // void onReady() {
  //   super.onReady();
  // }
  //
  // @override
  // void onClose() {
  //   super.onClose();
  // }

  List<TextCompletionData> messages = [];

  final totalTokenUsed = 0.obs;
  final totalDollarUsed = 0.0.obs;

  var state = ApiState.notFound.obs;

  getTextCompletion(String query) async {
    addMyMessage();

    state.value = ApiState.loading;

    // List<String> topics = ["dream interpretation", "Psychology", "mindfulness"];
    // String topicFilters = topics.map((topic) => 'topic:$topic').join(' | ');

    final queryWithFirstWord =
        "متنی که در زیر گفته شده است توصیف یک خواب است. تعبیر خواب را بگو"
        "\n"
        "$query";

    try {
      // final openAI = OpenAI.instance.build(
      //   token: OPEN_AI_KEY,
      //   baseOption: HttpSetup(receiveTimeout: 6000),
      //   isLogger: true,
      // );
      //
      // final request =
      //     CompleteText(prompt: queryWithFirstWord, model: kTranslateModelV3);
      //
      // final response = await openAI.onCompleteText(request: request);
      // print(response);
      //
      // if (response != null) {
      //   addServerMessage(TextCompletionModel(
      //       created: response.created,
      //       choices: [
      //         TextCompletionData(
      //           text: response.choices.first.text,
      //           finish_reason: response.choices.first.finish_reason,
      //           index: response.choices.first.index,
      //         )
      //       ],
      //       usage: TextCompletionUsage(
      //         completion_tokens: response.usage.completionTokens ?? 0,
      //         prompt_tokens: response.usage.promptTokens,
      //         total_tokens: response.usage.totalTokens,
      //       )).choices);
      //
      //   state.value = ApiState.success;
      //   totalTokenUsed.value += response.usage.totalTokens;
      //   totalDollarUsed.value =
      //       ((totalTokenUsed.value * 0.02) / 1000).toDouble();
      // } else {
      //   // throw ServerException(message: "Image Generation Server Exception");
      //   state.value = ApiState.error;
      // }

      Map<String, dynamic> rowParams = {
        "model": "text-davinci-003",
        "prompt": queryWithFirstWord,
        'max_tokens': 500,
      };

      final encodedParams = json.encode(rowParams);

      final response = await http.post(
        Uri.parse(endPoint("completions")),
        body: encodedParams,
        headers: headerBearerOption(OPEN_AI_KEY),
      );
      String responseBody = utf8.decode(response.bodyBytes);
      debugPrint("Response  body utf-8     $responseBody");
      debugPrint("Response  Status Code     ${response.statusCode}");
      if (response.statusCode == 200) {
        // messages =
        //     TextCompletionModel.fromJson(json.decode(response.body)).choices;
        //
        final res = TextCompletionModel.fromJson(json.decode(responseBody));
        addServerMessage(res.choices);
        state.value = ApiState.success;
        totalTokenUsed.value += res.usage.total_tokens.toInt();
        totalDollarUsed.value = ((totalTokenUsed.value * 0.02) / 1000).toDouble();
      } else {
        // throw ServerException(message: "Image Generation Server Exception");
        state.value = ApiState.error;
      }
    } catch (e) {
      debugPrint("Errorrrrrrrrrrrrrrr  ");
      state.value = ApiState.error;
    } finally {
      // searchTextController.clear();
      update();
    }
  }

  addServerMessage(List<TextCompletionData> choices) {
    for (int i = 0; i < choices.length; i++) {
      messages.insert(i, choices[i]);
    }
  }

  addMyMessage() {
    // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
    TextCompletionData text = TextCompletionData(
        text: searchTextController.text, index: -999999, finish_reason: "");
    messages.insert(0, text);
  }

  TextEditingController searchTextController = TextEditingController();
}
