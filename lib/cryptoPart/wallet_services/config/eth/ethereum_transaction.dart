class EthereumTransaction {
  final String from;
  final String to;
  final String value;
  final String? nonce;
  final String? gasPrice;
  final String? maxFeePerGas;
  final String? maxPriorityFeePerGas;
  final String? gas;
  final String? gasLimit;
  final String? data;

  EthereumTransaction({
    required this.from,
    required this.to,
    required this.value,
    this.nonce,
    this.gasPrice,
    this.maxFeePerGas,
    this.maxPriorityFeePerGas,
    this.gas,
    this.gasLimit,
    this.data,
  });

  factory EthereumTransaction.fromJson(Map<String, dynamic> json) =>
      EthereumTransaction(
        from: json['from'] as String,
        to: json['to'] as String,
        value: json['value'] as String,
        nonce: json['nonce'] as String?,
        gasPrice: json['gasPrice'] as String?,
        maxFeePerGas: json['maxFeePerGas'] as String?,
        maxPriorityFeePerGas: json['maxPriorityFeePerGas'] as String?,
        gas: json['gas'] as String?,
        gasLimit: json['gasLimit'] as String?,
        data: json['data'] as String?,
      );

  Map<String, dynamic> toJson() => _$EthereumTransactionToJson(this);

  @override
  String toString() {
    return 'WCEthereumTransaction(from: $from, to: $to, nonce: $nonce, gasPrice: $gasPrice, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas, gas: $gas, gasLimit: $gasLimit, value: $value, data: $data)';
  }
}

Map<String, dynamic> _$EthereumTransactionToJson(EthereumTransaction instance) {
  final val = <String, dynamic>{
    'from': instance.from,
    'to': instance.to,
    'value': instance.value,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nonce', instance.nonce);
  writeNotNull('gasPrice', instance.gasPrice);
  writeNotNull('maxFeePerGas', instance.maxFeePerGas);
  writeNotNull('maxPriorityFeePerGas', instance.maxPriorityFeePerGas);
  writeNotNull('gas', instance.gas);
  writeNotNull('gasLimit', instance.gasLimit);
  writeNotNull('data', instance.data);
  return val;
}

class ContractCallTransaction extends EthereumTransaction {
  final String contractAddress;
  final String functionName;
  final List<dynamic> args;

  ContractCallTransaction({
    required this.contractAddress,
    required this.functionName,
    required this.args,
    required super.from,
    required super.to,
    required super.value,
    required super.nonce,
    required super.gasPrice,
    required super.maxFeePerGas,
    required super.maxPriorityFeePerGas,
    required super.gas,
    required super.gasLimit,
    required super.data,
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'contractAddress': contractAddress,
        'functionName': functionName,
        'args': args,
      };
}
