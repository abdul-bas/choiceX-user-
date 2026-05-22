import 'dart:convert';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/chat/chat_message_model.dart';
import 'package:coice/data/models/chat/chat_model.dart';
import 'package:coice/data/models/user_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/data/repository/chat_repository.dart';
import 'package:coice/state/bloc/chat/chat_bloc.dart';
import 'package:coice/state/bloc/chat/chat_events.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

class ChatProvider extends ChangeNotifier {
  final AuthRepository _auth = AuthRepository();
  final AudioRecorder audioRecorder = AudioRecorder();

  int? currentIndex;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController messageCtrl = TextEditingController();
  final RecorderController recorderController =
    RecorderController();

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> messages = [];

  String search = '';
  UserModel? currentSeller;
  String? currentChatId;
  ChatModel? currentChat;

  int chatVersion = 0;

  bool isRecording = false;
  String? audioPath;
  String? fileUpload;
  bool isFileUploadVisible = false;
  bool hasMessage = false;
  bool showEmoji = false;
  bool isLoadingMore = false;
  bool hasReachedEnd = false;

  static const int _pageSize = 20;

  String get userId => _auth.getUeserId();

  ChatProvider() {
    _init();
  }

  void _init() {
    messageCtrl.addListener(_syncSendState);

    searchCtrl.addListener(() {
      final v = searchCtrl.text.trim();
      if (search != v) {
        search = v;
        notifyListeners();
      }
    });

    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      fetchMoreMessages();
    }
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void _syncSendState() {
    final next =
        messageCtrl.text.isNotEmpty || fileUpload != null || audioPath != null;

    if (hasMessage != next) {
      hasMessage = next;
      notifyListeners();
    }
  }

  void selectChat(String chatId, UserModel seller, ChatModel chat) {
    if (currentChatId == chatId) return;

    currentChatId = chatId;
    currentSeller = seller;
    currentChat = chat;

    messages.clear();
    hasReachedEnd = false;
    isLoadingMore = false;
    chatVersion++;

    notifyListeners();
  }

  void onNewSnapshot(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    messages
      ..clear()
      ..addAll(docs);

    notifyListeners();
  }

  Future<void> fetchMoreMessages() async {
    if (isLoadingMore || hasReachedEnd || currentChatId == null) return;
    if (messages.isEmpty) return;

    isLoadingMore = true;
    notifyListeners();

    try {
      final snap = await ChatRepository()
          .getMessages(
            currentChatId!,
            limit: _pageSize,
            lastDocument: messages.last,
          )
          .first;

      if (snap.docs.isEmpty) {
        hasReachedEnd = true;
      } else {
        messages.addAll(snap.docs);
      }
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  void sendMessage(BuildContext context) {
    if (currentChatId == null || currentSeller == null) return;

    final text = messageCtrl.text.trim();

    if (text.isEmpty && fileUpload == null && audioPath == null) return;

    final message = ChatMessageModel(
      messageId: const Uuid().v4(),
      chatId: currentChatId!,
      senderId: userId,
      receiverId: currentSeller!.uid!,
      text: text.isEmpty ? null : text,
      imageUrl: fileUpload,
      audioUrl: audioPath,
      createdAt: DateTime.now(),
      isRead: false
    );

    context.read<ChatBloc>().add(
          SendProductMessage(message, _auth.getUeserId(), currentSeller!.uid!),
        );

    clearMessage();
  }

  void toggleEmoji() {
    showEmoji = !showEmoji;
    notifyListeners();
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(withData: true);
    if (result == null) return;

    final file = result.files.single;

    final Uint8List bytes;
    if (file.bytes != null) {
      bytes = file.bytes!;
    } else {
      bytes = await File(file.path!).readAsBytes();
    }

    fileUpload = base64Encode(bytes);

    notifyListeners();
    _syncSendState();
  }

  void removeFile() {
    fileUpload = null;
    notifyListeners();
    _syncSendState();
  }

  Future<void> handleMicTap() async {

  if (isRecording) {

    await recorderController.stop();

    final path = await audioRecorder.stop();

    isRecording = false;

    if (path != null && path.isNotEmpty) {

      audioPath = path;

      hasMessage = true;
    }

  } else {

    if (!await audioRecorder.hasPermission()) return;

    isRecording = true;

    final path = kIsWeb
        ? 'voice_${DateTime.now().millisecondsSinceEpoch}.m4a'
        : '${(await getTemporaryDirectory()).path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await audioRecorder.start(
      const RecordConfig(),
      path: path,
    );

    await recorderController.record();
  }

  notifyListeners();
}
  void discardAudio() {
    audioPath = null;
    isRecording = false;
    hasMessage = messageCtrl.text.isNotEmpty || fileUpload != null;

    notifyListeners();
  }

  void clearMessage() {
    messageCtrl.clear();
    fileUpload = null;
    hasMessage = false;
    audioPath = null;

    notifyListeners();
  }

  void toggleFileUploadMenu() {
    isFileUploadVisible = !isFileUploadVisible;
    notifyListeners();
  }

  void clearChat() {
    currentChatId = null;
    currentSeller = null;
    currentChat = null;

    messages.clear();
    hasReachedEnd = false;
    isLoadingMore = false;

    notifyListeners();
  }

  clearPath() {
    audioPath = null;
    notifyListeners();
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    messageCtrl.dispose();
    audioRecorder.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
