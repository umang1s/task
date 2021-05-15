import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/model/class.dart';
import 'package:task/model/data.dart';
import 'package:video_player/video_player.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  List<News> _suggestion = List();
  DataBase _dataBase;
  bool _fullView = false;
  int _current = 0;
  bool _isInitilized = false;

  VideoPlayerController _playerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataBase = DataBase("Authenticating");
    _getSuggestedNews();
  }

  _getSuggestedNews() async {
    _suggestion = await _dataBase.getNews();
    _isInitilized = true;
    setState(() {});
    _playerController =
        VideoPlayerController.network(_suggestion[_current].videoLocation);

    _initializeVideoPlayerFuture = _playerController.initialize();
    _playerController.setLooping(false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isInitilized
        ? Column(
            children: [
              Container(
                  height: 50,
                  width: size.width,
                  child: Center(
                    child: Text('Videos',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  )),
              Container(
                height: 5,
                width: size.width,
                color: Colors.black12,
              ),
              Container(
                  height: 200,
                  width: size.width,
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return GestureDetector(
                          child: Stack(
                            children: [
                              if (_playerController.value.initialized)
                                Container(
                                  height: 200,
                                  width: size.width,
                                  child: Center(
                                    child: AspectRatio(
                                      aspectRatio:
                                          _playerController.value.aspectRatio,
                                      child: VideoPlayer(
                                        _playerController,
                                      ),
                                    ),
                                  ),
                                ),
                              if (_playerController.value.isBuffering)
                                Positioned(
                                  top: 65,
                                  left: size.width / 2 - 35,
                                  child: CircularProgressIndicator(),
                                ),
                              if (_playerController.value.hasError)
                                Container(
                                  child: Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 70,
                                    ),
                                  ),
                                ),
                              if (!_playerController.value.isPlaying)
                                Positioned(
                                    top: 65,
                                    left: size.width / 2 - 35,
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      size: 70,
                                      color: Colors.white,
                                    ))
                            ],
                          ),
                          onTap: () {
                            if (_playerController.value.isPlaying) {
                              _playerController.pause();
                            } else {
                              _playerController.play();
                            }
                            setState(() {});
                          },
                        );
                      } else {
                        return Stack(
                          children: [
                            Container(
                              height: 200,
                              width: size.width,
                              child: Image.asset(
                                _suggestion[_current].thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ],
                        );
                      }
                    },
                  )),
              SizedBox(
                height: 15,
              ),
              Expanded(
                  child: ListView.builder(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                itemCount: _suggestion.length + 1,
                itemBuilder: (context, len) {
                  if (len == 0) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      width: size.width - 40,
                      height: _fullView ? 360 : 210,
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            width: size.width - 40,
                            child: Text(
                              _suggestion[_current].headline,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 20,
                              width: size.width - 40,
                              child: Text(_suggestion[_current].getDate())),
                          SizedBox(
                            height: 10,
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            height: _fullView ? 200 : 60,
                            width: size.width - 40,
                            child: Text(_suggestion[_current].textBody),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            child: Container(
                              width: size.width - 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[400],
                                        blurRadius: 4.0,
                                        offset: Offset(2, 5))
                                  ]),
                              child: Center(
                                child: Text(
                                  'Information',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _fullView = !_fullView;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  }
                  if (_suggestion.length == 1)
                    return Center(
                      child: Text('No Suggested Video Found !'),
                    );
                  if (len - 1 == _current) return SizedBox();
                  return GestureDetector(
                    child: _newsContainer(_suggestion[len - 1]),
                    onTap: () => _suggestedVideoTapped(len - 1),
                  );
                },
              ))
            ],
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _newsContainer(News _currentNews) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height / 7;
    return Container(
      height: _height,
      width: size.width - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: _height - 30,
            width: _height + 20,
            decoration: BoxDecoration(
              //color: Colors.blue,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(_currentNews.thumbnail)),
            ),
            // child: Image.asset(_currentNews.thumbnail),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: _height,
              child: Column(
                children: [
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: _height / 4,
                    padding: EdgeInsets.only(top: 5),
                    width: size.width - 70 - _height,
                    child: Text(
                      _currentNews.headline,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                      height: _height / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.black38,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(_currentNews.getDate()),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "   info   ",
                            style: TextStyle(
                                backgroundColor: Colors.deepOrange,
                                color: Colors.white,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _suggestedVideoTapped(int num) {
    _suggestion.removeAt(_current);
    _current = num - 1;
    setState(() {});

    _playerController =
        VideoPlayerController.network(_suggestion[_current].videoLocation);
    _initializeVideoPlayerFuture = _playerController.initialize();
  }
}
