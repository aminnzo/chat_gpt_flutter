class TextCompletionModel {
  final num created;
  final List<TextCompletionData> choices;
  final TextCompletionUsage usage;

  TextCompletionModel({
    required this.created,
    required this.choices,
    required this.usage,
  });

  factory TextCompletionModel.fromJson(Map<String, dynamic> json) {
    final textCompletionItems = json['choices'] as List;
    List<TextCompletionData> choices = textCompletionItems
        .map((singleItem) => TextCompletionData.fromJson(singleItem))
        .toList();
    final textUsages = TextCompletionUsage.fromJson(json['usage']);

    return TextCompletionModel(
      choices: choices,
      created: json['created'],
      usage: textUsages,
    );
  }
}

class TextCompletionData {
  final String text;
  final num index;
  final String finish_reason;

  TextCompletionData(
      {required this.text, required this.index, required this.finish_reason});

  factory TextCompletionData.fromJson(Map<String, dynamic> json) {
    return TextCompletionData(
      text: json['text'],
      index: json['index'],
      finish_reason: json['finish_reason'],
    );
  }
}

class TextCompletionUsage {
  final int prompt_tokens;
  final int completion_tokens;
  final int total_tokens;

  TextCompletionUsage({
    required this.prompt_tokens,
    required this.completion_tokens,
    required this.total_tokens,
  });

  factory TextCompletionUsage.fromJson(Map<String, dynamic> json) {
    return TextCompletionUsage(
      prompt_tokens: json['prompt_tokens'],
      completion_tokens: json['completion_tokens'],
      total_tokens: json['total_tokens'],
    );
  }
}
