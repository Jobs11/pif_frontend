class Follow {
  final String flId;
  final String frId;

  const Follow({required this.flId, required this.frId});

  factory Follow.fromJson(Map<String, dynamic> json) =>
      Follow(flId: json['fl_id'], frId: json['fr_id']);

  Map<String, dynamic> toJson() => {'fl_id': flId, 'fr_id': frId};
}
