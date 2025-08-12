class Heart {
  final String hId;
  final int hNum;

  const Heart({required this.hId, required this.hNum});

  factory Heart.fromJson(Map<String, dynamic> json) =>
      Heart(hId: json['h_id'], hNum: (json['h_num'] as num).toInt());

  Map<String, dynamic> toJson() => {'h_id': hId, 'h_num': hNum};
}
