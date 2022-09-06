class Api {
  static const endpoint = "http://192.168.100.3:8080/simakan/api/";
  final timeout = 20;

  String login = endpoint + "login";
  String user = endpoint + "user";
  String angket = endpoint + "angket";
}