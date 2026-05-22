import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/audio_preview_provider.dart';
import 'package:coice/state/provider/chat_provider.dart';
import 'package:coice/ui/screens/chat/messages/widgets/input_area/audio_preview_bar/send_button.dart';
import 'package:coice/ui/screens/chat/messages/widgets/input_area/message_icon_button/message_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPreviewBar extends StatelessWidget {
  const AudioPreviewBar({super.key, required this.ctrl});

  final ChatProvider ctrl;

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPreviewProvider>(
      builder: (context, c, child) {
        return Row(
          children: [
            MessageIconBtn(
              icon: Icons.delete_outline,
              onTap: ctrl.discardAudio,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.chatPreviewBarBg,    
                  borderRadius: BorderRadius.circular(22),
                  border:
                      Border.all(color: AppColors.textMuted), 
                ),
                child: Row(
                  children: [
                    IconButton(                        
                      padding: EdgeInsets.zero,
                      onPressed: () async =>
                          await c.togglePlay(ctrl.audioPath),
                      icon: Icon(
                        c.playing ? Icons.pause : Icons.play_arrow,
                        color: AppColors.chatTextReceiverAlt,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppColors.textMuted,  
                          borderRadius:
                              BorderRadius.circular(1),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: c.playing ? 0.5 : 0,
                          child: Container(
                            color: AppColors.chatTextReceiverAlt,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Voice',
                      style: TextStyle(
                        color: AppColors.textSubdued,   
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            SendButton(onTap: () => ctrl.sendMessage(context)),
          ],
        );
      },
    );
  }
}