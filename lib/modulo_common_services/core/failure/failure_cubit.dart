import 'package:flutter/material.dart';

abstract class FailureCubit {
  final String errorMessage;
  FailureCubit({
    this.errorMessage = '',
    StackTrace? stackTrace,
    String? label,
  }) {
    if (stackTrace != null) {
      debugPrintStack(stackTrace: stackTrace, label: label);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FailureCubit && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}
