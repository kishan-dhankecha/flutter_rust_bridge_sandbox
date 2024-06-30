import 'package:equatable/equatable.dart';

import '../models/overlay_texture.dart';

export '../models/overlay_texture.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class ProcessImage extends ImageEvent {
  final String imagePath;
  final List<OverlayTexture> overlays;

  const ProcessImage({required this.imagePath, this.overlays = const []});

  @override
  List<Object> get props => [imagePath];
}

class ResetImage extends ImageEvent {
  const ResetImage();
  @override
  List<Object> get props => [];
}
