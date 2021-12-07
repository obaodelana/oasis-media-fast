import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oasis_bible_app/util/util.dart';
import 'package:video_player/video_player.dart';

class _VOD
{
  final String scripture, path;
  String videoURL;
  _VOD
  ({
    required this.scripture,
    required this.path,
    this.videoURL = "",
  })
  {
    if (videoURL.isEmpty)
      videoURL = "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";
  }
}

class VerseOfTheDay extends StatefulWidget
{
  const VerseOfTheDay({ Key? key }) : super(key: key);

  @override
  State<VerseOfTheDay> createState() => _VerseOfTheDayState();
}

class _VerseOfTheDayState extends State<VerseOfTheDay>
{
  late final VideoPlayerController _vc;
  late final Future<void> _vcFuture;
  late final _vods =
  [
    _VOD
    (
      path: "2 Corinthians 3:17",
      scripture: "Now the Lord is the Spirit; and where the Spirit of the Lord is, there is liberty.",
      videoURL: "assets/videos/day1.mp4"
    ),
    _VOD
    (
      path: "Ephesians 1:18",
      scripture: "Open the eyes of their hearts, and let the light of Your truth flood in. Shine Your light on the hope You are calling them to embrace. Reveal to them the glorious riches You are preparing as their inheritance.",
      videoURL: "assets/videos/day2.mp4"
    ),
  ];
  int _currentVod = 0;

  @override
  void initState()
  {
    int dateDiff = DateTime.now().difference(Util.startDate).inDays; 
    if (dateDiff >= 1)
      _currentVod = dateDiff % _vods.length;

    _vc = VideoPlayerController.asset(_vods[_currentVod].videoURL);
    _vcFuture = _vc.initialize();
    _vc.addListener(()
    {
      if (_vc.value.position == _vc.value.duration)
        setState(() {});
    });

    _vc.addListener(()
    {
      if (_vc.value.position == _vc.value.duration)
        setState(() {});
    });
    
    super.initState();
  }

  @override
  void dispose()
  {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      margin: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
      decoration: BoxDecoration
      (
        color: const Color(0xFF67A398).withOpacity(0.3),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Flexible
          (
            flex: 3,
            child: Padding
            (
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Column
              (
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  const Padding
                  (
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text
                    (
                      "Verse of the Day",
                      style: TextStyle
                      (
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text
                      (
                        _vods[_currentVod].scripture,
                        style: TextStyle
                        (
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          shadows:
                          [
                            const Shadow
                            (
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black87,
                            ),
                            Shadow
                            (
                              offset: const Offset(2.0, 2.0),
                              blurRadius: 5.0,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ]
                        ),
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.only(top: 7),
                        child: Text
                        (
                          _vods[_currentVod].path + " NKJV",
                          style: const TextStyle
                          (
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w100
                          )
                        ),
                      ),
                    ]
                  ),
                ]
              ),
            )
          ),
          Flexible
          (
            flex: 2,
            child: Padding
            (
              padding: const EdgeInsets.only(right: 20, top: 20, left: 20),
              child: Column
              (
                children:
                [
                  ClipRRect
                  (
                    borderRadius: BorderRadius.circular(10),
                    child: FutureBuilder
                    (
                      future: _vcFuture,
                      builder: (context, snapshot) 
                      {
                        if (snapshot.connectionState == ConnectionState.done)
                        {
                          return AspectRatio
                          (
                            aspectRatio: _vc.value.aspectRatio,
                            child: VideoPlayer(_vc)
                          );
                        }
                        else
                          return const CircularProgressIndicator();
                      }
                    ),
                  ),
                  IconButton
                  (
                    icon: Icon
                    (
                      (_vc.value.isPlaying)
                        ? FontAwesomeIcons.pause
                        : FontAwesomeIcons.play
                    ),
                    onPressed: ()
                    {
                      if (!_vc.value.isBuffering)
                      {
                        if (!_vc.value.isPlaying)
                          _vc.play();
                        else
                          _vc.pause();

                        setState(() {});
                      }
                    },
                  )
                ],
              )
            ),
          ),
        ]
      ),
    );
  }
}