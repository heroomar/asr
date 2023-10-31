import 'package:flutter/services.dart';
import '../contract/contarct_address_constant.dart';
import 'package:web3dart/web3dart.dart';

class ContractService {
  late final DeployedContract erc20Contract;

  ContractService() {
    _init();
  }

  Future<void> _init() async {
    erc20Contract = await _loadABI(
      'assets/contract_abi/MCT.json',
      'MCT',
      ContractAddressConstant.erc20Address,
    );
  }

  Future<DeployedContract> _loadABI(
    String path,
    String name,
    String contractAddress,
  ) async {
    String abiString = await rootBundle.loadString(path);

    final contract = DeployedContract(
      ContractAbi.fromJson(abiString, name),
      EthereumAddress.fromHex(contractAddress),
    );

    return contract;
  }
}
