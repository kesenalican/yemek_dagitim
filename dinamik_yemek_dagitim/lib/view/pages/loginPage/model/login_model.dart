class LoginModel {
  LoginModel({
    required this.userName,
    required this.password,
  });
  late final String userName;
  late final String password;

  LoginModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    return data;
  }
}
