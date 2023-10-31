import 'package:flutter/material.dart';

import '../contract/contract_function.dart';
import '../wallet_services/helpers/wallet_connect_helper_v2.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  static WalletConnectHelperV2 walletConnectHelper = WalletConnectHelperV2();

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  String? chainName;
  String? walletAddress;

  final  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    CryptoPage.walletConnectHelper = WalletConnectHelperV2();

    chainName = CryptoPage.walletConnectHelper.chain.chainId.split(':')[0];
    walletAddress = (CryptoPage.walletConnectHelper.sessionData
        ?.namespaces[chainName]?.accounts.first ??
        "")
        .split(":")
        .last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SizedBox(
        width: double.infinity,
        child: Column()
      ),
    );
  }

  void connectWallet() async {
    await CryptoPage.walletConnectHelper.onWalletConnect().then((value) async {
      if (value != null) {
        chainName = CryptoPage.walletConnectHelper.chain.chainId.split(':')[0];
        walletAddress = value;
        setState(() {});
      }
    });
  }
}