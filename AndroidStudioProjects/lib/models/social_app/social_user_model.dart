class SocialUserModel {
  late String? name;
  late String? email;
  late String? phone;
  late String? uid;

  bool? isEmailVerified;

  SocialUserModel(
      {this.name, this.email, this.phone, this.uid, this.isEmailVerified});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'isEmailVerified': isEmailVerified,
    };
  }
}
