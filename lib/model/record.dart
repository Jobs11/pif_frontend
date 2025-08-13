class Records {
  final String mId;
  final int? rNum;
  final String rDate;
  final String rTime;
  final String rDecoration;

  const Records({
    required this.mId,
    this.rNum,
    required this.rDate,
    required this.rTime,
    required this.rDecoration,
  });

  factory Records.fromJson(Map<String, dynamic> json) => Records(
    mId: json['m_id'],
    rNum: (json['r_num'] as num?)?.toInt(),
    rDate: json['r_date'],
    rTime: json['r_time'],
    rDecoration: json['r_decoration'],
  );

  Map<String, dynamic> toJson() => {
    'm_id': mId,
    'r_date': rDate,
    'r_time': rTime,
    'r_decoration': rDecoration,
  };
}
