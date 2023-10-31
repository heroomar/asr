import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import '../../../backend/backend_utils/custom_snackbar.dart';
import '../../utils/Preference.dart';
import '../config/crypto/eip155.dart';
import '../config/models/chain_metadata.dart';

import '../config/crypto/eip155.dart';
import '../config/models/chain_metadata.dart';

class WalletConnectHelperV2 {
  WalletConnectHelperV2() {
    _initWallet();
  }

  Web3App? web3App;
  SessionData? sessionData;

  // //TODO:Chainthis to work with Sepolia test net
  // ChainMetadata chain = const ChainMetadata(
  //   type: ChainTypeEnum.eip155,
  //   chainId: 'eip155:11155111',
  //   name: 'Sepolia',
  //   logo: '',
  //   color: Colors.transparent,
  //   isTestnet: true,
  //   rpc: ['https://sepolia.infura.io/v3/'],
  // );
  // TODO:Uncomment these to work with biance main net
  ChainMetadata chain = const ChainMetadata(
    type: ChainTypeEnum.eip155,
    chainId: 'eip155:56',
    name: 'Binance',
    logo: '',
    color: Colors.transparent,
    isTestnet: false,
    rpc: ['https://bsc-dataseed4.binance.org/'],
  );




  Future<void> _initWallet() async {

    debugPrint("_initWallet 1");


    web3App = await Web3App.createInstance(
      projectId: '601fe60b50eb3fffa35f902e6d30b4b6',
      metadata: const PairingMetadata(
        name: 'ASR',
        description: 'ASr Coin for all User',
        url: 'https://www.ASR.org/',
        icons: [
          'https://coodes.org/wp-content/uploads/2020/07/ic.png'
        ],
      ),
    );
    debugPrint("_initWallet 2");

    web3App?.registerEventHandler(
        chainId: chain.chainId, event: EIP155.events.values.toList()[0]);

    web3App?.onSessionPing.subscribe(_onSessionPing);
    web3App?.onSessionEvent.subscribe(_onSessionEvent);
  }

  void _onSessionPing(SessionPing? args) {
    // Utils.showToast(Get.context!, 'Received Ping :::: ${args!.topic}');

    debugPrint("_onSessionPing$args");
  }

  void _onSessionEvent(SessionEvent? args) {
    // Utils.showToast(Get.context!,'Received Ping :::: Topic: ${args!.topic}\nEvent Name: ${args.name}\nEvent Data: ${args.data}');
    debugPrint("_onSessionEvent$args");
  }

  Future<String?> onWalletConnect() async {
    final Map<String, RequiredNamespace> requiredNamespaces = {};

    final String chainName = chain.chainId.split(':')[0];
    if (requiredNamespaces.containsKey(chainName)) {
      requiredNamespaces[chainName]!.chains!.add(chain.chainId);
    }
    final RequiredNamespace rNamespace = RequiredNamespace(
      chains: [chain.chainId],
      methods: EIP155.methods.values.toList(),
      events: EIP155.events.values.toList(),
    );
    requiredNamespaces[chainName] = rNamespace;

    debugPrint('Required namespaces:' '$requiredNamespaces');

     ConnectResponse res = await web3App!.connect(
      requiredNamespaces: requiredNamespaces,
    );

    debugPrint("ConnectResponse" "$res");

    /// NAVIGATE URL INTO THE WALLET
    debugPrint("URI ${res.uri}");
    await moveToWalletApp(res.uri);

    try {
      sessionData = await res.session.future;

      await Preference.shared
          .setString(Preference.sessionData, jsonEncode(sessionData));

      debugPrint("sessionData${sessionData?.toJson()}");

      var walletAddress =
          (sessionData?.namespaces[chainName]?.accounts.first ?? "")
              .split(":")
              .last;

      // WalletConnectSecureStorage().store(WalletConnectSession(
      //     accounts: sessionData?.namespaces[chainName]?.accounts ?? []));

      debugPrint("WALLET-ADDRESS FROM WALLET$walletAddress");

      return walletAddress;
    } catch (e) {
      debugPrint('Exexption: $e');
    }

    return null;
  }
  Future<void> moveToWalletApp(Uri? uri) async {
    Preference.shared.setString(Preference.connectionURL, uri.toString());

    bool isLaunch = await launchUrl(
      uri!,
      mode: LaunchMode.externalApplication,
    );
    if (!isLaunch) {
      throw 'Failure - Could not open URL $uri.';
    }
  }


}
