import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:task/model/data.dart';

import 'model/class.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<News> news = List<News>();
  DataBase dataBase;
  RefreshController _refreshController;
  int _show;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataBase = DataBase("authenticating");
    _refreshController = RefreshController(initialRefresh: false);
    _initilizeData();

    //get headline
  }

  _initilizeData() async {
    news = await dataBase.getNews();
    _show = news.length - 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropMaterialHeader(
        backgroundColor: Colors.blueGrey[900],
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (news.length == _show)
            body = Text("No more data");
          else if (mode == LoadStatus.idle) {
            body = Text("pull up to Load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 50.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: news.length == 0
          ? Container()
          : ListView.builder(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              itemCount: _show,
              itemBuilder: (context, s) => GestureDetector(
                child: _newsContainer(news[s]),
                onTap: _newsWidgetTapped(news[s]),
              ),
            ),
    );
  }

  Widget _newsContainer(News _currentNews) {
    Size size = MediaQuery.of(context).size;
    double _small = size.height / 7.5;
    return Container(
      height: size.height / 6,
      width: size.width - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: _small,
            width: _small,
            decoration: BoxDecoration(
              //color: Colors.blue,
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(_currentNews.thumbnail)),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: _small,
              child: Column(
                children: [
                  Container(
                    height: _small / 3,
                    width: size.width - _small - 30,
                    child: Text(
                      _currentNews.headline,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    height: _small / 3,
                    width: size.width - _small - 30,
                    child: Text(
                      _currentNews.textBody,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                      height: _small / 3,
                      width: size.width - _small - 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.black38,
                          ),
                          Text(_currentNews.getDate()),
                          Text(
                            "   ${_currentNews.category}   ",
                            style: TextStyle(
                                backgroundColor: Colors.red,
                                color: Colors.white,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            child: Icon(
                              _currentNews.isBookMarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: _currentNews.isBookMarked
                                  ? Colors.blue
                                  : Colors.black38,
                            ),
                            onTap: _bookmarkTapped(),
                          )
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

  _bookmarkTapped() {}

  _newsWidgetTapped(News _current) {}

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    setState(() {});
  }

  _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (_show < news.length)
      _show++;
    else
      _refreshController.loadNoData();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
}

/*

      body: 
    );
  }
*/
