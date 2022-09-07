class Api {
  static const endpoint = "http://192.168.100.2:8080/simakan/api/";
  final timeout = 20;

  String login = endpoint + "login";
  String user = endpoint + "user";
  String angket = endpoint + "angket";
  String question = endpoint + "question";
  String doing = endpoint + "doing";
  String answer = endpoint + "answer";
  String changePassword = endpoint + "changepassword";
  String changePhoto = endpoint + "changephoto";
  String updateprofile = endpoint + "updateprofile";
}