import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/models/song.dart';
import 'package:spotify_app/utils/assets.dart';
import 'package:spotify_app/widgets/profile_clipper.dart';
import 'package:spotify_app/widgets/side_menu.dart';
import 'package:spotify_app/widgets/song_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShowMenu = false;
  String currentSelectTab = Assets.homeIcon;
  List<Song> songTrendingList = [];
  List<String> categories = [];

  Widget _buildCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Categories',
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            runSpacing: 20,
            children: categories.map((category) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.6)),
                child: Text(
                  category,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(40), top: ScreenUtil().setHeight(40)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white.withOpacity(0.08)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SvgPicture.asset(
                  Assets.circleIcon,
                  color: Colors.white,
                  width: ScreenUtil().setWidth(50),
                  height: ScreenUtil().setHeight(50),
                ),
              ),
              Expanded(
                  child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Seach...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                    contentPadding: EdgeInsets.zero),
              ))
            ],
          ),
        )),
        Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(40),
              right: ScreenUtil().setWidth(40),
              top: ScreenUtil().setHeight(40)),
          child: ClipOval(
            clipper: ProfileClipper(),
            child: Image.network(
              'https://hinhanhdepvai.com/wp-content/uploads/2017/04/tai-anh-gai-xinh-de-thuong.jpg',
              width: ScreenUtil().setWidth(140),
              height: ScreenUtil().setHeight(140),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOpenMenuButton() {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: SvgPicture.asset(
        isShowMenu ? Assets.chevronLeftIcon : Assets.chevronRightIcon,
        color: Colors.white,
        height: ScreenUtil().setHeight(66),
      ),
      onPressed: () {
        setState(() {
          isShowMenu = !isShowMenu;
        });
      },
    );
  }

  Widget _buildListTrending() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Top Trending',
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(900),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: songTrendingList.length,
            itemBuilder: (context, index) {
              Song song = songTrendingList[index];
              return Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                child: SongCard(
                  song: song,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _fakeData();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Body
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(isShowMenu ? 200 : 0)),
              alignment: Alignment.topLeft,
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.6),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildHeader(),
                    SizedBox(
                      height: 30,
                    ),
                    _buildListTrending(),
                    SizedBox(
                      height: 30,
                    ),
                    _buildCategory()
                  ],
                ),
              ),
            ),

            // Side tab
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: ScreenUtil().setWidth(isShowMenu ? 200 : 0),
              color: Colors.black,
              child: SideMenu(
                currentSelectTab: currentSelectTab,
                isShowMenu: isShowMenu,
                selectTabCallBack: (tab) {
                  setState(() {
                    currentSelectTab = tab;
                  });
                },
              ),
            ),

            Positioned(
              left: ScreenUtil().setWidth(45),
              bottom: ScreenUtil().setHeight(45),
              child: isShowMenu
                  ? _buildOpenMenuButton()
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black),
                      child: _buildOpenMenuButton(),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _fakeData() {
    songTrendingList = [
      Song(
          imageUrl:
              'https://images-na.ssl-images-amazon.com/images/I/81Ii6u2neLL._AC_SX679_.jpg',
          title: 'A Gift Of a Friend',
          subtitle: 'Demi Lovato. ...'),
      Song(
          imageUrl:
              'https://cms-assets.tutsplus.com/uploads/users/114/posts/34296/image/Final-image.jpg',
          title: 'A Thousand Years',
          subtitle: 'Christina Perri. ...'),
      Song(
          imageUrl:
              'https://i.pinimg.com/originals/3a/f0/e5/3af0e55ea66ea69e35145fb108b4a636.jpg',
          title: 'Apologize ',
          subtitle: 'Timbaland. ...'),
      Song(
          imageUrl:
              'https://m.media-amazon.com/images/I/91bVXTuO8dL._AC_SS450_.jpg',
          title: 'Big Big World ',
          subtitle: 'Emilia. ...'),
      Song(
          imageUrl:
              'https://cdn.music-artworks.com/wp-content/uploads/2020/05/neurofunk-purple-overlay-360x360.jpg',
          title: 'Count On Me ',
          subtitle: 'Bruno Mars. ...'),
    ];

    categories = [
      'Pop',
      'Rock',
      'Bolero',
      'Lofi',
      'EDM',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano',
      'Piano'
    ];
  }
}
