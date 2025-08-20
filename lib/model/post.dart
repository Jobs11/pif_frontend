class Post {
  final int? pNum;
  final String pId;
  final int rNum;
  final String pContent;
  final String pPublic;
  final String? pRegisterdate;

  const Post({
    this.pNum,
    required this.pId,
    required this.rNum,
    required this.pContent,
    required this.pPublic,
    this.pRegisterdate,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    pNum: (json['p_num'] as num?)?.toInt(),
    pId: json['p_id'],
    rNum: (json['r_num'] as num).toInt(),
    pContent: json['p_content'],
    pPublic: json['p_public'],
    pRegisterdate: json['p_registerdate'],
  );

  Map<String, dynamic> toJson() => {
    'p_id': pId,
    'r_num': rNum,
    'p_content': pContent,
    'p_public': pPublic,
  };

  Map<String, dynamic> toUpdate() => {
    'p_id': pId,
    'r_num': rNum,
    'p_content': pContent,
    'p_public': pPublic,
    'p_num': pNum,
  };
}
