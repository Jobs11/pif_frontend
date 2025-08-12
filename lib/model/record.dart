class Record {
  final String miD;
  final int? rNum;
  final String rDate;
  final String rTime;
  final String rDecoration;

  const Record({
    required this.miD,
    this.rNum,
    required this.rDate,
    required this.rTime,
    required this.rDecoration,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    miD: json['m_id'],
    rNum: (json['r_num'] as num?)?.toInt(),
    rDate: json['r_date'],
    rTime: json['r_time'],
    rDecoration: json['r_decoration'],
  );

  Map<String, dynamic> toJson() => {
    'm_id': miD,
    'r_date': rDate,
    'r_time': rTime,
    'r_decoration': rDecoration,
  };
}
