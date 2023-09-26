import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/padding.dart';
import '../constants/font_family.dart';

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    super.key,
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  });

  @override
  PositionSeekWidgetState createState() => PositionSeekWidgetState();
}

class PositionSeekWidgetState extends State<PositionSeekWidget> {
  late Duration visibleValue;
  bool listenOnlyUserInteraction = false;

  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInteraction) {
      visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        kPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: kSpacingDuration,
            child: Text(
              durationToString(
                widget.currentPosition,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: kSpartanMB,
              ),
            ),
          ),
          Expanded(
            child: Slider(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              min: 0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: percent * widget.duration.inMilliseconds.toDouble(),
              onChangeEnd: (newValue) {
                setState(() {
                  listenOnlyUserInteraction = false;
                  widget.seekTo(visibleValue);
                });
              },
              onChangeStart: (_) {
                setState(() {
                  listenOnlyUserInteraction = true;
                });
              },
              onChanged: (newValue) {
                setState(() {
                  final to = Duration(
                    milliseconds: newValue.floor(),
                  );
                  visibleValue = to;
                });
              },
            ),
          ),
          SizedBox(
            width: kSpacingDuration,
            child: Text(
              durationToString(
                widget.duration,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: kSpartanMB,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds =
      twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}
