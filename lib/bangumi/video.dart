import 'package:fijkplayer/fijkplayer.dart';
import 'package:fijkplayer_skin/fijkplayer_skin.dart';
import 'package:fijkplayer_skin/schema.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    Key? key,
    required this.name,
    required this.url,
    this.live = false,
    this.headers,
  }) : super(key: key);

  final String name;
  final String url;
  final bool live;
  final Map<String, String>? headers;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool drawerBtn = true;
  @override
  bool nextBtn = true;
  @override
  bool speedBtn = true;
  @override
  bool topBar = true;
  @override
  bool lockBtn = true;
  @override
  bool autoNext = true;
  @override
  bool bottomPro = true;
  @override
  bool stateAuto = true;
  @override
  bool isAutoPlay = true;
}

class _VideoPlayerState extends State<VideoPlayer> {
  FijkPlayer player = FijkPlayer();

  int _curTabIdx = 0;
  int _curActiveIdx = 0;

  @override
  initState() {
    super.initState();
    if (kReleaseMode) {
      // 日志记录级别
      FijkLog.setLevel(FijkLogLevel.Silent);
    }
    // 默认播放速度
    speed = 1.0;
    // 设置播放源
    player.setDataSource(widget.url, autoPlay: false, showCover: false);
    // 设置请求头
    if (widget.headers != null && widget.headers!.isNotEmpty) {
      var headers = "";
      widget.headers!.forEach((key, value) {
        headers += key + ": " + value + " \r\n";
      });
      player.setOption(FijkOption.formatCategory, "headers", headers);
    }
    // 通过立即清理数据包来减少等待时长
    player.setOption(FijkOption.formatCategory, "flush_packets", 1);
    // 如果是rtsp协议，可以优先用tcp(默认是用udp)
    player.setOption(FijkOption.formatCategory, "rtsp_transport", "tcp");
    // 清空DNS,有时因为在APP里面要播放多种类型的视频
    player.setOption(FijkOption.formatCategory, "dns_cache_clear", 1);
    // 播放前的探测Size，默认是1M, 改小一点会出画面更快
    player.setOption(FijkOption.formatCategory, "probesize", 5120);
    // 设置播放前的探测时间1
    player.setOption(FijkOption.formatCategory, "analyzeduration", 1);
    // 设置播放前的最大探测时间
    player.setOption(FijkOption.formatCategory, "analyzemaxduration", 100);
    // 自动转屏开关
    player.setOption(FijkOption.formatCategory, "auto_convert", 0);
    //
    player.setOption(FijkOption.formatCategory, "ijkapplication", 2147483646);
    //
    player.setOption(FijkOption.formatCategory, "ijkiomanager", 2147483647);

    // 直播
    if (widget.live) {
      // 无限读 0:禁用  1:开启
      player.setOption(FijkOption.playerCategory, "infbuf", 1);
      // 设置缓冲 0:禁用  1:开启
      player.setOption(FijkOption.playerCategory, "packet-buffering", 0);
      // 最大缓存大小
      player.setOption(FijkOption.playerCategory, "max_cached_duration", 4000);
    } else {
      // 无限读 0:禁用  1:开启
      player.setOption(FijkOption.playerCategory, "infbuf", 0);
      // 设置缓冲 0:禁用  1:开启
      player.setOption(FijkOption.playerCategory, "packet-buffering", 1);
      // 最大缓存大小
      player.setOption(FijkOption.playerCategory, "max_cached_duration", 0);
    }
    // 跳帧处理,防CPU处理较慢时，进行跳帧处理，保证播放流程，画面和声音同步
    player.setOption(FijkOption.playerCategory, "framedrop", 1);
    // 设置硬解码方式 0:禁用  1:开启
    player.setOption(FijkOption.playerCategory, "mediacodec", 1);
    // 设置H265硬解 0:禁用  1:开启
    player.setOption(FijkOption.playerCategory, "mediacodec-hevc", 1);
    // 设置旋转屏幕 0:禁用 1:启用
    player.setOption(FijkOption.playerCategory, "mediacodec-auto-rotate", 1);
    //
    player.setOption(
        FijkOption.playerCategory, "mediacodec-handle-resolution-change", 1);
    // 最大缓冲大小,单位kb
    player.setOption(FijkOption.playerCategory, "max-buffer-size", 20480);
    // 是否禁止图像显示(只输出音频)
    player.setOption(FijkOption.playerCategory, "nodisp", 0);

    // 监听
    player.addListener(() async {
      await _playStateListener();
    });
  }

  _playStateListener() async {
    if (FijkState.started == player.state) {
      // CPU锁定
      await Wakelock.enable();
      // 屏幕常亮
      await FijkPlugin.keepScreenOn(true);
    } else if (FijkState.stopped == player.state) {
      // 取消CPU锁定
      await Wakelock.disable();
      // 取消屏幕常亮
      await FijkPlugin.keepScreenOn(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FijkView(
        player: player,
        color: Colors.black,
        panelBuilder: (FijkPlayer player,
            FijkData data,
            BuildContext context,
            Size viewSize,
            Rect texturePos,) {
          return CustomFijkPanel(
            player: player,
            pageContent: context,
            viewSize: viewSize,
            texturePos: texturePos,
            playerTitle: widget.name,
            onChangeVideo: (int curTabIdx, int curActiveIdx) {
              setState(() {
                _curTabIdx = curTabIdx;
                _curActiveIdx = curActiveIdx;
              });
            },
            curTabIdx: _curTabIdx,
            curActiveIdx: _curActiveIdx,
            showConfig: PlayerShowConfig(),
            videoFormat: VideoSourceFormat.fromJson({
              "video": [
                {
                  'name': widget.name,
                  'list': [
                    {'name': widget.name, 'url': widget.url}
                  ]
                }
              ]
            }),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.removeListener(_playStateListener);
    player.release();
  }
}