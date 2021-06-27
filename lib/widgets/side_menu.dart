import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/utils/assets.dart';
import 'package:spotify_app/widgets/menu_button.dart';

class SideMenu extends StatefulWidget {
  SideMenu(
      {Key? key,
      required this.currentSelectTab,
      required this.selectTabCallBack,
      required this.isShowMenu})
      : super(key: key);

  String currentSelectTab;
  bool isShowMenu;
  Function(String) selectTabCallBack;

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  void updateButton(String selectTab) {
    setState(() {
      widget.currentSelectTab = selectTab;
      widget.selectTabCallBack(selectTab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(45)),
              child: AnimatedContainer(
                width: ScreenUtil().setWidth(widget.isShowMenu ? 120 : 0),
                duration: Duration(milliseconds: 300),
                child: SvgPicture.asset(
                  Assets.spotifyLogo,
                  color: Colors.green,
                  height: ScreenUtil().setHeight(120),
                ),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(120))),
        Expanded(
            child: Column(
          children: [
            MenuButton(
              icon: Assets.homeIcon,
              currentSelect: widget.currentSelectTab,
              onPressed: () {
                updateButton(Assets.homeIcon);
              },
            ),
            MenuButton(
              icon: Assets.cloudIcon,
              currentSelect: widget.currentSelectTab,
              onPressed: () {
                updateButton(Assets.cloudIcon);
              },
            ),
            MenuButton(
              icon: Assets.microphoneIcon,
              currentSelect: widget.currentSelectTab,
              onPressed: () {
                updateButton(Assets.microphoneIcon);
              },
            ),
            MenuButton(
              icon: Assets.clockIcon,
              currentSelect: widget.currentSelectTab,
              onPressed: () {
                updateButton(Assets.clockIcon);
              },
            ),
          ],
        )),
      ],
    );
  }
}
