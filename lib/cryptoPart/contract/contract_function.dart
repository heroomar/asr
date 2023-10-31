
import 'dart:math';

import 'package:convert/convert.dart';
import 'package:crypinvest/controller/wallet_transaction_controller/wallet_transaction%20controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:get/get.dart';
import '../../backend/services/api_services.dart';
import '../../main.dart';
import '../utils/Constant.dart';
import '../utils/Preference.dart';

import 'package:web3dart/web3dart.dart';


import '../pages/CryptoPage.dart';
import '../wallet_services/config/crypto/eip155.dart';
import '../wallet_services/config/eth/ethereum_transaction.dart';
import 'contarct_address_constant.dart';

class ContractFunctionsName {
  static const String executeInstantOrder = "executeInstantOrder";
  static const String createInstantOrder = "createInstantOrder";
  static const String cancelInstantOrder = "cancelIwalletAddresswnstantOrder";
  static const String transfer = "transfer";
  static const String balanceOf = "balanceOf";
  static const String ownerOf = "ownerOf";
  static const String approve = "approve";
  static const String allowance = "allowance";
  static const String increaseAllowance = "increaseAllowance";
  static const String totalSupply = "totalSupply";
  static const String claimMagicBoxReward = "claimMagicBoxReward";
  static const String claimWeeklyReward = "claimWeeklyReward";
  static const String blend = "blend";
}

class ContractFunctions {
  final client = Web3Client(Constant.netWorkEndpoints, Client());

  final String chainName =
      CryptoPage.walletConnectHelper.chain.chainId.split(':')[0];

  int chainId = int.parse(
      CryptoPage.walletConnectHelper.chain.chainId.split(':')[1].toString());

  ContractFunctions();

  _initGoToWallet() async {
    String prfURI = Preference.shared.getString(Preference.connectionURL) ?? "";

    debugPrint("prfURI Bebiiiii  $prfURI");

    Uri uri = Uri.parse(prfURI);
    await CryptoPage.walletConnectHelper.moveToWalletApp(uri);
  }


  Future<bool> sendErc20Token(double value,walletConnectHelper) async {

    String? transactionId;

    try {
      String walletAddress = (walletConnectHelper.sessionData
          ?.namespaces[chainName]?.accounts.first ??
          "")
          .split(":")
          .last;

      ///١ MAKE TRANSACTION USING web3dart
      Transaction transaction = Transaction.callContract(
        from: EthereumAddress.fromHex(walletAddress),
        contract: contractService.erc20Contract,
        function:
        contractService.erc20Contract.function(ContractFunctionsName.transfer),
        parameters: [
          // EthereumAddress.fromHex(walletAddress),"0x4b54487FeB51706e76541E4042171236d470Fa69"
          //SenderCollector
          EthereumAddress.fromHex("0x7Aafd13f3d7eA7045C0D2aD934D4dDfc5bFAF6b6"),

          BigInt.from((value) * pow(10, 18) )
          // BigInt.from((price) * pow(10, 18))

        ],
      );

      /// MAKE ETHEREUM TRANSACTION USING THE walletconnect_flutter_v2
      EthereumTransaction ethereumTransaction = EthereumTransaction(
        from: walletAddress,
        to: ContractAddressConstant.erc20Address,

        value: "0x0",
        data: hex.encode(List<int>.from(transaction.data!)),
      );

      await _initGoToWallet();

      ///  REQUEST TO WALLET FOR TRANSACTION USING vwalletconnect_flutter_v2

      transactionId = await walletConnectHelper.web3App?.request(
        topic: walletConnectHelper.sessionData?.topic ?? "",
        chainId: walletConnectHelper.chain.chainId,
        request: SessionRequestParams(
          method: EIP155.methods[EIP155Methods.ethSendTransaction] ?? "",
          params: [ethereumTransaction.toJson()],
        ),
      );

      //TODO: the api function to send the transaction data to ASR panel
      print (" is that function is Called");
    // Get.find<WalletTransactionController>().walletTransaction(
    // amount: value.toString(),
    // payment_processed: transactionId.toString(),
    // receiver: ContractAddressConstant.erc20Address,
    // selected_network: '38',
    // sender: walletAddress.toString(),
    // token_address: '0x7Aafd13f3d7eA7045C0D2aD934D4dDfc5bFAF6b6');


      Map<String, dynamic> inputBody = {
        'amount': value.toString(),
        'payment_processed': transactionId.toString(),
        'receiver': ContractAddressConstant.erc20Address,
        'selected_network': '38',
        'sender': walletAddress.toString(),
        'token_address': '0x7Aafd13f3d7eA7045C0D2aD934D4dDfc5bFAF6b6',
      };
      await ApiServices.MetaMaskSuccess(body: inputBody).then((value) {
        // print(value);
      }).catchError((onError) {

      });


      debugPrint("transactionId   $transactionId");
    } on Exception catch (_, e) {
      debugPrint("Catch E    $e");
    }
    bool isApproved = transactionId != null;

    return isApproved;
  }



}
