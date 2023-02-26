import 'package:chat_gpt_flutter/app/modules/chat_text/views/widgets/text_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/headers.dart';
import '../../../common/search_text_field_widget.dart';
import '../controllers/chat_text_controller.dart';

class ChatTextView extends GetView<ChatTextController> {
  const ChatTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Dream Interpretation'),
        centerTitle: true,
      ),
      body: Obx(() => Column(children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final textData = controller.messages[index];
                  return textData.index == -999999
                      ? MyTextCard(textData: textData)
                      : TextCard(textData: textData);
                },
              ),
            ),
            controller.state.value == ApiState.loading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator()),
                    ))
                : const SizedBox(),
            const SizedBox(height: 12),
            SearchTextFieldWidget(
                color: Colors.black,
                textEditingController: controller.searchTextController,
                onTap: () {
                  controller
                      .getTextCompletion(controller.searchTextController.text);
                }),
            const SizedBox(height: 10),
            Text("Tokens used: ${controller.totalTokenUsed.value} == Price: \$${controller.totalDollarUsed.value}",
                style: const TextStyle(color: Colors.red, fontSize: 8)),
            const SizedBox(height: 10),
          ])),
    );
  }
}
