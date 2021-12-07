import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intrinsic_grid_view/intrinsic_grid_view.dart';
import 'package:oasis_bible_app/util/util.dart';
import 'package:oasis_bible_app/widgets/feed/feed_item.dart';

class Feed extends StatefulWidget
{
  final bool smallScreen;
  const Feed({ Key? key, this.smallScreen = false }) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with TickerProviderStateMixin
{
  final List<Widget> _ytFeed = [];
  final List<Widget> _spotifyFeed = [];
  final List<Widget> _articleFeed = [];
  final List<Widget> _linkFeed = [];

  late final TabController _tabC = TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context)
  {
    return Padding
    (
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column
      (
        children:
        [
          Padding
          (
            padding: const EdgeInsets.only(top: 10),
            child: TabBar
            (
              controller: _tabC,
              tabs: const
              [
                Tab(icon: Icon(FontAwesomeIcons.youtube), child: Text("Sermons")),
                Tab(icon: Icon(FontAwesomeIcons.spotify), child: Text("Playlists")),
                Tab(icon: Icon(FontAwesomeIcons.solidNewspaper), child: Text("Writing")),
                Tab(icon: Icon(FontAwesomeIcons.link), child: Text("Extra resources")),
              ]
            ),
          ),
          Flexible
          (
            child: FutureBuilder
            (
              future: _getFeed(),
              builder: (context, snapshot)
              {
                if (snapshot.connectionState == ConnectionState.done)
                {
                  return _tabView();
                }
          
                else
                  return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabView()
  {
    return TabBarView
    (
      controller: _tabC,
      children:
      [
        (!widget.smallScreen)
        ? IntrinsicGridView.vertical
          (
            verticalSpace: 10,
            horizontalSpace: 20,
            children: _ytFeed,
          )
        : Column(children: _ytFeed),
        (!widget.smallScreen)
        ? IntrinsicGridView.vertical
          (
            verticalSpace: 10,
            horizontalSpace: 20,
            children: _spotifyFeed,
          )
        : Column(children: _spotifyFeed),
       (!widget.smallScreen)
        ? IntrinsicGridView.vertical
          (
            verticalSpace: 10,
            horizontalSpace: 20,
            children: _articleFeed,
          )
        : Column(children: _articleFeed),
        (!widget.smallScreen)
        ? IntrinsicGridView.vertical
          (
            verticalSpace: 10,
            horizontalSpace: 20,
            children: _linkFeed,
          )
        : Column(children: _linkFeed),
      ]
    );
  }

  Future<void> _getFeed() async
  {
    for (var item in await Util.getOnlineDB("yt_resources"))
    {
      final String title = item.get<String>("title") ?? "Youtube Video";
      final String videoID =
        (item.get<String>("videoID") ?? "V_RhcKtM73s").replaceAll(" ", "");
      _ytFeed.add
      (
        FeedItem
        (
          title: title,
          link: "http://youtube.com/watch?v=$videoID",
          imageURL: "https://img.youtube.com/vi/$videoID/mqdefault.jpg",
          feedType: FeedType.youtube
        )
      );
    }

    for (var item in await Util.getOnlineDB("spotify_resources"))
    {
      final String title = item.get<String>("title") ?? "Spotify Playlist";
      final String link = item.get<String>("link") ?? "https://open.spotify.com/playlist/6BkEUnaP9hZRB4UbLEygjG?si=KiiRuvAORZuD28NiuKcJTQ";
      final String coverImageURL =
        item.get<String>("coverImageURL") ?? "https://www.scdn.co/i/_global/open-graph-default.png";
      _spotifyFeed.add
      (
        FeedItem
        (
          title: title,
          link: link,
          imageURL: coverImageURL,
          feedType: FeedType.spotify
        )
      );
    }

    for (var item in await Util.getOnlineDB("link_resources"))
    {
      final String title = item.get<String>("title") ?? "Link";
      final String link = item.get<String>("link") ?? "https://www.desiringgod.org/interviews/when-should-i-get-rid-of-my-smartphone";
      final String imageURL =
        item.get<String>("imageURL") ?? "https://dg.imgix.net/when-should-i-get-rid-of-my-smartphone-en/landscape/when-should-i-get-rid-of-my-smartphone.jpg?w=320&h=180";
      _linkFeed.add
      (
        FeedItem
        (
          title: title,
          link: link,
          imageURL: imageURL,
          feedType: FeedType.link
        )
      );
    }

    for (var item in await Util.getOnlineDB("article_resources"))
    {
      final String title = item.get<String>("title") ?? "Article";
      final String link = item.get<String>("link") ?? "https://www.bible.com/reading-plans/14706";
      final String imageURL =
        item.get<String>("imageURL") ?? "https://imageproxy.youversionapi.com/https://s3.amazonaws.com/yvplans/14706/320x180.jpg";
      _articleFeed.add
      (
        FeedItem
        (
          title: title,
          link: link,
          imageURL: imageURL,
          feedType: FeedType.article
        )
      );
    }
  }
}