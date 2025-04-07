class DocumentosResponse {
  final String status;
  final String message;

  DocumentosResponse({
    required this.status,
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DocumentosResponse &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
