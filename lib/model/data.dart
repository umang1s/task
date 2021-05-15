import 'class.dart';

class DataBase {
  String authId;
  bool isAuthenticated;
  DataBase(this.authId) {
    isAuthenticated = true;
    //for authentication
  }

  Future<List<News>> getNews() async {
    List<News> news = List();
    if (!isAuthenticated) return news;
    String tempNews = "This is Heading of the realte news ws this is and go on";
    String temp2News = "This is Heading of the realte";
    String tempLine =
        "This is Heading of the realted news this is another Heading of the .. This will go like this when nothing";
    DateTime tempTime = DateTime(2021, 03, 03);
    String videoLocation =
        "https://github.com/umang1s/task/blob/main/images/video.mp4?raw=true";

    news = [
      News(
          category: "Sports",
          thumbnail: _getLink('1.jfif'),
          headline: tempNews,
          date: tempTime,
          isBookMarked: false,
          textBody: tempLine,
          videoLocation: videoLocation),
      News(
          category: "Sports",
          thumbnail: _getLink('2.jfif'),
          headline: temp2News,
          date: tempTime,
          isBookMarked: false,
          textBody: tempLine,
          videoLocation: videoLocation),
      News(
          category: "Sports",
          thumbnail: _getLink('3.jfif'),
          headline: tempNews,
          date: tempTime,
          isBookMarked: false,
          textBody: tempLine,
          videoLocation: videoLocation),
      News(
          category: "Sports",
          thumbnail: _getLink('1.jfif'),
          headline: temp2News,
          date: tempTime,
          isBookMarked: false,
          textBody: tempLine,
          videoLocation: videoLocation),
      News(
          category: "Sports",
          thumbnail: _getLink('2.jfif'),
          headline: tempNews,
          date: tempTime,
          isBookMarked: false,
          textBody: tempLine,
          videoLocation: videoLocation),
      News(
          category: "Sports",
          thumbnail: _getLink('3.jfif'),
          headline: temp2News,
          date: tempTime,
          isBookMarked: false,
          textBody: tempLine,
          videoLocation: videoLocation),
    ];

    return news;
  }

  String _getLink(String imageName) {
    String ret = "images/"; //location of website
    return ret + imageName;
  }

  User getUserData() {
    return User(
        coutryCode: 91,
        whatsAppNo: "XXXXXXXXXX",
        email: "xxxxx@xxx.com",
        firstName: "Umang",
        lastName: "Maurya",
        gender: "male",
        location: "Kanpur,Uttar-Pradesh ,India",
        pincode: 208000,
        birth: DateTime(2000, 01, 01));
  }
}
