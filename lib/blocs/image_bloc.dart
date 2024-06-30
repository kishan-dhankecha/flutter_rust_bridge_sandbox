import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/image_event.dart';
import '../src/rust/api/simple.dart' as bridge;
import '../states/image_state.dart';

export '../events/image_event.dart';
export '../states/image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ProcessImage>(_onProcessImage);
    on<ResetImage>((event, emit) => emit(ImageInitial()));
  }

  Future<void> _onProcessImage(ProcessImage event, Emitter<ImageState> emit) async {
    emit(ImageProcessing());
    Uint8List? processedImage;
    try {
      processedImage = await _processImage(
        background: event.imagePath,
        overlays: event.overlays,
      );
      emit(ImageProcessed(processedImage!));
    } catch (e) {
      print(e.toString());
      emit(ImageProcessingFailed());
    }
  }

  Future<Uint8List?> _processImage({
    required String background,
    List<OverlayTexture> overlays = const [],
  }) async {
    Uint8List bytes = (await rootBundle.load(background)).buffer.asUint8List();
    for (final overlay in overlays) {
      bytes = await bridge.addOverlay(
        background: bytes,
        texture: await overlay.forRust(),
      );
    }
    return bytes;
  }
}
