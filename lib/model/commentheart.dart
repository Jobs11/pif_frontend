class Commentheart {
  final String chId;
  final int chNum;

  const Commentheart({required this.chId, required this.chNum});

  factory Commentheart.fromJson(Map<String, dynamic> json) =>
      Commentheart(chId: json['ch_id'], chNum: (json['ch_num'] as num).toInt());

  Map<String, dynamic> toJson() => {'ch_id': chId, 'ch_num': chNum};
}
