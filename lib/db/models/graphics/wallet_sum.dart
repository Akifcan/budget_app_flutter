import 'package:flutter/material.dart';

class WalletSum {
  final String label;
  final Color color;
  final num value;

  WalletSum(this.label, this.color, this.value);
}

class WalletGroup {
  final String label;
  final num value;
  WalletGroup(this.label, this.value);
}
