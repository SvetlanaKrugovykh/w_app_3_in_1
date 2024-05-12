// user.dart

class User {
  late String fullName;
  late final String email;
  late final String phoneNumber;
  late String login;
  late String password;
  late String address;
  late String country;
  late String story;

  User(
      {required this.email,
      required this.login,
      required this.password,
      required this.phoneNumber});

  set name(String name) {}
}
