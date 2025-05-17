import 'package:flutter/material.dart';
import 'package:instagram/UI/Widgets/buttonNavigationBar_widget.dart';
import 'package:video_player/video_player.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  _ReelsScreenState createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 2;

  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF181818) : Colors.white;
    final overlayTextColor = Colors.white;
    final iconColor = Colors.white;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/reels.png',
              width: 32,
              height: 32,
              color: Colors.redAccent,
            ),
            const SizedBox(width: 8),
            const Text(
              'Reels',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
            onPressed: () {},
            tooltip: 'Create Reel',
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return ReelVideoPlayer(
            videoUrl: videoUrls[index],
            overlayTextColor: overlayTextColor,
            iconColor: iconColor,
          );
        },
      ),
      bottomNavigationBar: NavBar(
        onItemSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

class ReelVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final Color overlayTextColor;
  final Color iconColor;
  const ReelVideoPlayer(
      {super.key,
      required this.videoUrl,
      this.overlayTextColor = Colors.white,
      this.iconColor = Colors.white});

  @override
  _ReelVideoPlayerState createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  late VideoPlayerController _controller;
  bool _showControls = false;
  bool _isLiked = false;
  int _likeCount = 1200;
  int _commentCount = 254;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      }).catchError((error) {
        print("Error loading video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showControls = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _controller.value.isInitialized
            ? GestureDetector(
                onTap: _toggleControls,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                    if (_showControls)
                      AnimatedOpacity(
                        opacity: _showControls ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: IconButton(
                          iconSize: 64,
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause_circle
                                : Icons.play_circle,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                        ),
                      ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),

        // UI Overlay (Like Instagram)
        Positioned(
          right: 16,
          bottom: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: const AssetImage(
                    'assets/images/3D Animation Style lofi style character of a young….jpeg'),
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 18),
              IconButton(
                icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? Colors.red : widget.iconColor, size: 32),
                onPressed: _toggleLike,
              ),
              Text("${_likeCount ~/ 1}K",
                  style: TextStyle(
                      color: widget.overlayTextColor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              IconButton(
                icon: Icon(Icons.comment, color: widget.iconColor, size: 32),
                onPressed: () {},
              ),
              Text("$_commentCount",
                  style: TextStyle(
                      color: widget.overlayTextColor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              IconButton(
                icon: Icon(Icons.send, color: widget.iconColor, size: 32),
                onPressed: () {},
              ),
              const SizedBox(height: 18),
              IconButton(
                icon:
                    const Icon(Icons.more_vert, color: Colors.white, size: 28),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Video info and progress
        Positioned(
          left: 16,
          bottom: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "username",
                    style: TextStyle(
                      color: widget.overlayTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.verified, color: Colors.blue, size: 18),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: size.width * 0.6,
                child: Text(
                  "Amazing nature video! #nature #wildlife",
                  style:
                      TextStyle(color: widget.overlayTextColor, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "37.2K views · $_commentCount comments",
                style: TextStyle(
                    color: widget.overlayTextColor.withOpacity(0.8),
                    fontSize: 13),
              ),
            ],
          ),
        ),

        // Progress Bar
        if (_controller.value.isInitialized)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: VideoProgressIndicator(_controller,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  playedColor: widget.iconColor,
                  backgroundColor: Colors.white24,
                  bufferedColor: Colors.white38,
                )),
          ),
      ],
    );
  }
}
