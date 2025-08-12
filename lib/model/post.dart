class Post {
  final int? pNum;
  final String pId;
  final int rNum;
  final String pContent;

  const Post({
    this.pNum,
    required this.pId,
    required this.rNum,
    required this.pContent,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    pNum: (json['p_num'] as num?)?.toInt(),
    pId: json['p_id'],
    rNum: (json['r_num'] as num).toInt(),
    pContent: json['p_content'],
  );

  Map<String, dynamic> toJson() => {
    'p_id': pId,
    'r_num': rNum,
    'p_content': pContent,
  };
}
