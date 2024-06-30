import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/image_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rust Bridge Demo'),
      ),
      body: Center(
        child: BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
          return switch (state) {
            ImageProcessing() => const CircularProgressIndicator(),
            ImageProcessingFailed() => const ProcessingFailedWidget(),
            ImageInitial() => const InitialWidget(),
            ImageProcessed(image: Uint8List image) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.memory(image),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          // TODO: Save the image
                        },
                        child: const Text('Save'),
                      ),
                      TextButton(
                        onPressed: () {
                          final bloc = BlocProvider.of<ImageBloc>(context);
                          bloc.add(const ResetImage());
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ),
            _ => const SizedBox(),
          };
        }),
      ),
    );
  }
}

class InitialWidget extends StatelessWidget {
  const InitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Image.asset('assets/images/background.jpeg'),
        ),
        ElevatedButton(
          onPressed: () {
            final bloc = BlocProvider.of<ImageBloc>(context);
            bloc.add(
              const ProcessImage(
                imagePath: 'assets/images/background.jpeg',
                overlays: [
                  OverlayTexture(path: 'assets/images/cycle.png', height: 220, x: 20, y: 300),
                  OverlayTexture(path: 'assets/images/dog.png', x: 420, y: 360, width: 150),
                ],
              ),
            );
          },
          child: const Text('Process'),
        ),
      ],
    );
  }
}

class ProcessingFailedWidget extends StatelessWidget {
  const ProcessingFailedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Failed to process image!'),
        TextButton(
          onPressed: () {
            final bloc = BlocProvider.of<ImageBloc>(context);
            bloc.add(const ResetImage());
          },
          child: const Text('Restart'),
        ),
      ],
    );
  }
}
