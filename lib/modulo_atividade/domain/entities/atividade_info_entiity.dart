class AtividadeResponse {
  final bool status;
  final String message;

  AtividadeResponse({
    required this.status,
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AtividadeResponse &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
