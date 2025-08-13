class Member {
  final int? mNum; // Dart 규칙: lowerCamelCase
  final String mName;
  final String mNickname;
  final String mBirth;
  final String mPhone;
  final String mEmail;
  final String mId;
  final String mPassword;
  final String? mPaint;

  const Member({
    this.mNum,
    required this.mName,
    required this.mNickname,
    required this.mBirth,
    required this.mPhone,
    required this.mEmail,
    required this.mId,
    required this.mPassword,
    this.mPaint,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    mNum: (json['m_num'] as num?)?.toInt(), // JSON → Dart 매핑
    mName: json['m_name'] as String,
    mNickname: json['m_nickname'] as String,
    mBirth: json['m_birth'] as String,
    mPhone: json['m_phone'] as String,
    mEmail: json['m_email'] as String,
    mId: json['m_id'] as String,
    mPassword: json['m_password'] as String,
    mPaint: json['m_paint'] as String?,
  );

  Map<String, dynamic> toJson() => {
    // Dart → JSON 매핑
    'm_name': mName,
    'm_nickname': mNickname,
    'm_birth': mBirth,
    'm_phone': mPhone,
    'm_email': mEmail,
    'm_id': mId,
    'm_password': mPassword,
  };

  Map<String, dynamic> toJsonPaintOnly() => {'m_paint': mPaint};

  Map<String, dynamic> toJsonUpdate() => {
    // Dart → JSON 매핑
    'm_name': mName,
    'm_nickname': mNickname,
    'm_phone': mPhone,
    'm_email': mEmail,
    'm_password': mPassword,
  };
}
