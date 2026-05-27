
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/constants/app_strings/input_bar_audio_hight.dart';
import 'package:coice/state/provider/audio_preview_provider.dart';
import 'package:coice/state/provider/chat_provider.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/audio_bubble/wave_bars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({super.key, required this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.brandSubtle,               
        borderRadius: BorderRadius.circular(30),
      ),
      child: Consumer<AudioPreviewProvider>(
        builder: (context, c, child) {
          final isLoading = c.isLoadingFor(path);
          final isPlaying = c.isPlayingFor(path);
          final progress = c.progressFor(path);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => c.togglePlay(path),
                icon: Icon(
                  isLoading
                      ? Icons.refresh
                      : isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                  color: AppColors.white,              
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 3, vertical: 10),
                child: Flexible(
                  child: WaveBarsSimple(
                    heights: inputBarAudioHight,
                    progress: progress,
                    played: AppColors.black,            
                    dim: AppColors.white,                 
                    animated: true,
                  ),
                ),
              ),
              IconButton(
                onPressed: () =>
                    context.read<ChatProvider>().clearPath(),
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  color: AppColors.chatDeleteIcon,      
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

