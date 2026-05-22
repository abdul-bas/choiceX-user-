import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/state/provider/chat_provider.dart';
import 'package:coice/ui/screens/chat/messages/widgets/input_area/audio_preview_bar/audio_preview_bar.dart';
import 'package:coice/ui/screens/chat/messages/widgets/input_area/audio_widget.dart';
import 'package:coice/ui/screens/chat/messages/widgets/input_area/message_icon_button/message_icon_button.dart';
import 'package:coice/ui/screens/chat/messages/widgets/input_area/send_messages.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget messageInputArea(
  BuildContext context,
  ValueNotifier<bool> isFocus,
  ValueNotifier<ProductModel?> product,
  int? variantIndex,
  String chatId,
  String sellerId,
  dynamic scrollController,
) {
  return SafeArea(
    child: Consumer<ChatProvider>(
      builder: (context, p, child) {
        if (p.audioPath != null) AudioPreviewBar(ctrl: p);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Selector<ChatProvider, String?>(
                      selector: (context, provider) => provider.audioPath,
                      builder: (context, value, child) {
                        if (p.isRecording) {
                          return Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: AppColors.brand.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AudioWaveforms(
                              enableGesture: false,
                              size: Size(
                                  MediaQuery.of(context).size.width - 10, 45),
                              recorderController: p.recorderController,
                              waveStyle: const WaveStyle(
                                waveColor: AppColors.white,
                                extendWaveform: true,
                                showMiddleLine: false,
                                waveThickness: 3,
                                spacing: 4,
                              ),
                            ),
                          );
                        }
                        if (value != null) {
                          return AudioWidget(path: value);
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColors.brand.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              MessageIconBtn(
                                icon: Icons.tag_faces_outlined,
                                onTap: context.read<ChatProvider>().toggleEmoji,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: p.messageCtrl,
                                  onChanged: (v) {
                                    isFocus.value =
                                        p.messageCtrl.text.isNotEmpty;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Type a message...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              MessageIconBtn(
                                icon: Icons.attach_file,
                                onTap: () =>
                                    context.read<ChatProvider>().pickFile(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Send / mic button
                  ValueListenableBuilder<bool>(
                    valueListenable: isFocus,
                    builder: (context, focused, _) {
                      final isSend = focused ||
                          p.fileUpload != null ||
                          p.audioPath != null;
                      return IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (!isSend) p.handleMicTap();
                          if (isSend) {
                            sendMessage(
                              context,
                              p.messageCtrl,
                              product,
                              variantIndex,
                              chatId,
                              sellerId,
                              isFocus,
                              scrollController,
                              p.audioPath,
                              p.fileUpload,
                              isSend,
                              () {
                                if (p.fileUpload != null) {
                                  p.removeFile();
                                }
                                if (p.audioPath != null) {
                                  p.discardAudio();
                                }
                              },
                            );
                          }
                        },
                        icon: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSend || p.isRecording
                                ? AppColors.brand
                                : AppColors.brand.withValues(alpha: 0.1),
                          ),
                          child: Icon(
                            isSend
                                ? Icons.send_rounded
                                : Icons.mic_none_rounded,
                            color: isSend || p.isRecording
                                ? AppColors.white
                                : AppColors.grey400,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            p.showEmoji
                ? EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      isFocus.value = p.messageCtrl.text.isNotEmpty;
                    },
                    onBackspacePressed: () {
                      final txt = p.messageCtrl.text;
                      isFocus.value = p.messageCtrl.text.isNotEmpty;
                      if (txt.isEmpty) return;
                      p.messageCtrl
                        ..text = txt.characters.skipLast(1).toString()
                        ..selection = TextSelection.collapsed(
                            offset: p.messageCtrl.text.length);
                    },
                    textEditingController: p.messageCtrl,
                    config: Config(
                      height: 256,
                      checkPlatformCompatibility: true,
                      emojiViewConfig: EmojiViewConfig(
                        emojiSizeMax: 28 *
                            (foundation.defaultTargetPlatform ==
                                    TargetPlatform.iOS
                                ? 1.20
                                : 1.0),
                      ),
                      viewOrderConfig: const ViewOrderConfig(
                        middle: EmojiPickerItem.categoryBar,
                        bottom: EmojiPickerItem.emojiView,
                        top: EmojiPickerItem.searchBar,
                      ),
                      skinToneConfig: SkinToneConfig(
                          dialogBackgroundColor: AppColors.brand),
                      categoryViewConfig: CategoryViewConfig(
                        backgroundColor: AppColors.brand.withValues(alpha: 0.1),
                        iconColor: AppColors.brand.withValues(alpha: 0.3),
                        iconColorSelected: AppColors.brand,
                        indicatorColor: AppColors.brand,
                        dividerColor: AppColors.brand.withValues(alpha: 0.1),
                      ),
                      bottomActionBarConfig:
                          BottomActionBarConfig(enabled: false),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    ),
  );
}
