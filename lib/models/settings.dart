class Settings {
  final int? id;
  final String? username;
  final String? uuidLogged;
  final String? token;
  final String uuidInstalation;
  final String appVersion;

  const Settings({
    this.id,
    this.username,
    this.uuidLogged,
    this.token,
    required this.uuidInstalation,
    required this.appVersion
  });
}