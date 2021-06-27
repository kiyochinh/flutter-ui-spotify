import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/models/song.dart';
import 'package:spotify_app/utils/assets.dart';

class SongCard extends StatelessWidget {
  SongCard({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              song.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              left: 12,
              bottom: 12,
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          Assets.spotifyLogo,
                          color: Colors.green,
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22),
                      ),
                      Text(
                        song.subtitle,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
