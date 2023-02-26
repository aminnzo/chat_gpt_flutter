const String OPEN_AI_KEY = "";

const String baseURL = "https://api.openai.com/v1";

String endPoint(String endPoint) => "$baseURL/$endPoint";

Map<String, String> headerBearerOption(String token) => {
      "Content-Type": "application/json",
      "Accept-Charset": "utf-8",
      "charset": "utf-8",
      'Authorization': 'Bearer $token',
    };

enum ApiState { loading, success, error, notFound }
