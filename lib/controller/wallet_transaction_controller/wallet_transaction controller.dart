import 'dart:convert';

import 'package:crypinvest/utils/basic_screen_imports.dart';
import 'package:http/http.dart' as http;

import '../../backend/local_storage/local_storage.dart';
class WalletTransactionController extends GetxController{


  Future<void> walletTransaction({
    required String payment_processed,
    required String selected_network,
    required String sender,
    required String token_address,
    required String receiver,
    required String amount,

  }) async{
    String accessToken = LocalStorage.getToken()!;
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${accessToken}'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://asrcoin.io/api/v1/user/add-money/metamask'));
    request.fields.addAll({
      'payment_processed': payment_processed,
      'selected_network': selected_network,
      'sender': sender,
      'token_address': token_address,
      'receiver': receiver,
      'amount': amount,
    });


    request.headers.addAll(headers);
    try{
      http.StreamedResponse response = await request.send();
      var data = await http.Response.fromStream(response);
      print("before if create logbook");
      if (response.statusCode == 200) {
        try {
          Map<String, dynamic> map = jsonDecode(data.body);

        } catch (e) {
          Get.snackbar(
            "Message",
            data.body,
            snackPosition: SnackPosition.TOP, // Position of the snackbar
            duration: Duration(seconds: 3), // Duration for which the snackbar will be visible
            backgroundColor: CustomColor.primaryDarkColor,
            colorText: Colors.black,
            borderRadius: 10,
            margin: EdgeInsets.all(10),
            dismissDirection: DismissDirection.up, // Swipe direction to dismiss

          );
        }
        print("if create logbook   ${response.statusCode}");
        print("bodyresponse    ${data.body}");


      }
      else {
        Map<String, dynamic> map = jsonDecode(data.body);
        Get.snackbar(
          "Message",
          data.body,
          snackPosition: SnackPosition.TOP, // Position of the snackbar
          duration: Duration(seconds: 3), // Duration for which the snackbar will be visible
          backgroundColor: CustomColor.primaryDarkColor,
          colorText: Colors.black,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          dismissDirection: DismissDirection.up, // Swipe direction to dismiss

        );
        print(response.reasonPhrase);
        print("else create logbook   ${response.statusCode}");
      }

    }
    catch(error){
      print("error ${error.toString()}");
    }



  }

}