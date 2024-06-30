import 'package:flutter/services.dart' show rootBundle, Uint8List;

export 'package:flutter/services.dart' show rootBundle, Uint8List;

class OverlayTexture {
  final String path;
  final int? x;
  final int? y;
  final int? width;
  final int? height;

  const OverlayTexture({
    required this.path,
    this.x,
    this.y,
    this.width,
    this.height,
  });

  Future<(Uint8List, int?, int?, int?, int?)> forRust() async {
    final overlayBytes = (await rootBundle.load(path)).buffer.asUint8List();
    return (overlayBytes, x, y, width, height);
  }
}
