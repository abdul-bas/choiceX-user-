import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/constants/app_strings/wave_bars_hights.dart';
import 'package:coice/state/provider/audio_preview_provider.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/audio_bubble/wave_bars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioBubble extends StatelessWidget {
  const AudioBubble({
    super.key,
    required this.isSender,
    required this.path,
  });

  final bool isSender;
  final String? path;

  @override
  Widget build(BuildContext context) {
    final bg = isSender
        ? AppColors.shadowDark                         
        : AppColors.iconDark;                          
    final fg = isSender
        ? AppColors.chatTextSender                    
        : AppColors.chatTextReceiverAlt;             

    return Consumer<AudioPreviewProvider>(
      builder: (context, c, child) {
        final isLoading = c.isLoadingFor(path);
        final isPlaying = c.isPlayingFor(path);
        final prog = c.progressFor(path);

        return GestureDetector(
          onHorizontalDragUpdate: (d) {
            final box =
                context.findRenderObject() as RenderBox?;
            if (box == null) return;
            c.seekTo(d.localPosition.dx / box.size.width);
          },
          child: Container(
            padding:
                const EdgeInsets.fromLTRB(12, 9, 14, 9),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                SizedBox(
                  width: 26,
                  height: 26,
                  child: IconButton(                     
                    padding: EdgeInsets.zero,
                    onPressed:
                        isLoading ? null : () => c.togglePlay(path),
                    icon: isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(3),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: fg,
                            ),
                          )
                        : Icon(
                            isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            size: 26,
                            color: fg,
                          ),
                  ),
                ),
                const SizedBox(width: 10),

              
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: 120,
                        height: 26,
                        child: WaveBarsSimple(
                          progress: prog,
                          played: AppColors.brand,       
                          dim: AppColors.grey400,      
                          animated: true,
                          heights: hights,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      path == c.currentPath
                          ? '${c.posLabel}  /  ${c.durLabel}'
                          : 'Voice message',
                      style: const TextStyle(
                          fontSize: 9.5,
                          color: AppColors.black),     
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}