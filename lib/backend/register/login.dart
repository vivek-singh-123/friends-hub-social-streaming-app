import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class AuthService {
  static const String _baseUrl =
      'https://friends.anklegaming.live/APIs/APIs.asmx/LoginUser';

  // Observables for feedback and loading state
  static RxString message = ''.obs;
  static RxBool isLoading = false.obs;

  static Future<int?> loginUser({
    required String Token,
    required String Email,
    required String Password,
  }) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'token': Token,
          'Email': Email,
          'Password': Password,
        },
      );

      if (response.statusCode == 200) {
        print("✅ Successfully received response");
        print("API Response: ${response.body}");
        message.value = "Login request successful.";

        // Extract JSON array from XML-wrapped response
        final body = response.body;
        final jsonStart = body.indexOf('[');
        final jsonEnd = body.lastIndexOf(']') + 1;
        final jsonString = body.substring(jsonStart, jsonEnd);

        final data = json.decode(jsonString);

        if (data is List && data.isNotEmpty) {
          final result = data[0]['Column1'];

          if (result == 1) {
            message.value = "✅ Login successful!";
            return 1;
          } else if (result == 0) {
            message.value = "ℹ️ User not found. Please sign up.";
            return 0;
          } else {
            print('❌ Unexpected result value: $result');
            message.value = "Unexpected server response.";
            return null;
          }
        } else {
          print('❌ Unexpected data format: $data');
          message.value = "Invalid data format.";
          return null;
        }
      } else {
        print("❌ Failed with status: ${response.statusCode}");
        message.value = "Something went wrong.";
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      message.value = "Error: $e";
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
