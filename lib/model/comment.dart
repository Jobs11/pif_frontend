class Comment {
  final int? cNum;
  final String cId;
  final int cGetnum;
  final String cContent;

  const Comment({
    this.cNum,
    required this.cId,
    required this.cGetnum,
    required this.cContent,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    cNum: (json['c_num'] as num?)?.toInt(),
    cId: json['c_id'],
    cGetnum: (json['c_getnum'] as num).toInt(),
    cContent: json['c_content'],
  );

  Map<String, dynamic> toJson() => {
    'c_id': cId,
    'c_getnum': cGetnum,
    'c_content': cContent,
  };
}
