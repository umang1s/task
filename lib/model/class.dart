class News {
  String thumbnail;
  String headline;
  DateTime date;
  String textBody;
  bool isBookMarked;
  String category;
  String videoLocation;

  News(
      {this.category,
      this.date,
      this.headline,
      this.isBookMarked,
      this.textBody,
      this.thumbnail,
      this.videoLocation});
  String getDate() {
    String ret = "";
    if (date.day < 10) ret += "0";
    ret += date.day.toString()+"-";
    if (date.month < 10) ret += "0";
    ret += date.month.toString()+"-";
    ret += date.year.toString();

    return ret;
  }
}

class User {
  String firstName;
  String lastName;
  String location;
  int pincode;
  DateTime birth;
  String gender;
  String whatsAppNo;
  int coutryCode;

  String email;

  User(
      {this.birth,
      this.email,
      this.firstName,
      this.gender,
      this.lastName,
      this.location,
      this.pincode,
      this.whatsAppNo,
      this.coutryCode});
}
