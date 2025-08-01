import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Register extends GetxController {
  final isLoading = false.obs;
  final message = ''.obs;

  Future<void> registeruser({
    required String Token,
    required String Name,
    required String Gender,
    required String Dob,
    required String Email,
    required String Password,
    required String Images,
    required String phone,
  }) async {
    final url = Uri.parse('https://friends.anklegaming.live/APIs/APIs.asmx/Register');
    isLoading.value = true;

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'token': Token,
          'Name': Name,
          'Gender': Gender,
          'Dob': Dob,
          'Email': Email,
          'Password': Password,
          'images': Images,
          'Phone': phone,
        },
      );

      if (response.statusCode == 200) {
        print("✅ Successfully registered");
        print(response.body);
        message.value = "Registration successful!";
      } else {
        print("❌ Failed with status: ${response.statusCode}");
        message.value = "Something went wrong.";
      }
    } catch (e) {
      print("❌ Exception: $e");
      message.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
