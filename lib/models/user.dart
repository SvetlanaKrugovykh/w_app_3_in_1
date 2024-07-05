// user.dart

class User {
  late String fullName;
  late String email;
  late String login;
  late String phoneNumber;
  late String password;
  late String country;
  late String story;

  User(
      {required this.email,
      required this.password,
      required this.phoneNumber,
      required this.fullName,
      required this.login,
      required this.country,
      required this.story});

  set name(String name) {}
}
