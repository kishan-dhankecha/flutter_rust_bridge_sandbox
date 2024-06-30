import 'dart:typed_data' show Uint8List;

import 'package:equatable/equatable.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageProcessing extends ImageState {}

class ImageProcessingFailed extends ImageState {}

class ImageProcessed extends ImageState {
  final Uint8List image;

  const ImageProcessed(this.image);

  @override
  List<Object> get props => [image];
}
