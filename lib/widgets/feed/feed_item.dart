import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

enum FeedType
{
  youtube,
  article,
  spotify,
  link
}

extension on FeedType
{
  IconData getIcon()
  {
    if (this == FeedType.youtube)
      return FontAwesomeIcons.youtube;
    else if (this == FeedType.article)
      return FontAwesomeIcons.solidNewspaper;
    else if (this == FeedType.spotify)
      return FontAwesomeIcons.spotify;
    else
      return FontAwesomeIcons.link;
  }
}

class FeedItem extends StatelessWidget
{
  final String title, link, imageURL;
  final FeedType feedType;
  const FeedItem
  ({
    Key? key,
    required this.title,
    required this.link,
    required this.imageURL,
    required this.feedType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MouseRegion
    (
      cursor: SystemMouseCursors.click,
      child: GestureDetector
      (
        onTap: () async
        {
          if (!await launch(link)) throw "Couldn't launch URL";
        },
        child: Column
        (
          children:
          [
            Image.network(imageURL, width: 320, height: 180,),
            Row
            (
              children:
              [
                Padding
                (
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                  child: Icon
                  (
                    feedType.getIcon(),
                    color: (feedType == FeedType.youtube)
                      ? Colors.red
                      : (feedType == FeedType.spotify)
                        ? Colors.green
                        : (feedType == FeedType.article)
                          ? Colors.brown[300]
                          : Colors.blue,
                  ),
                ),
                Flexible
                (
                  child: Text
                  (
                    title,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: const TextStyle
                    (
                      color: Colors.black
                    ),
                  )
                )
              ],
            )
          ]
        ),
      ),
    );
  }
}