

import 'dart:async';

import 'package:coice/data/models/chat/chat_model.dart';
import 'package:flutter/material.dart';

class ChatSearchProvider extends ChangeNotifier {
  List<ChatModel> _allChats = [];
  List<ChatModel> _filtered = [];
  bool isLoading = true;
  String query = '';

  final TextEditingController searchCtrl = TextEditingController();
  Timer? _debounce;

  List<ChatModel> get filtered => _filtered;

  void setChats(List<ChatModel> chats) {
    _allChats = chats;
    isLoading = false;
    _applyFilter();
    notifyListeners();
  }

  void onSearch(String value) {
    query = value.trim().toLowerCase();

    
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      _applyFilter();
      notifyListeners();
    });
  }

  void clearSearch() {
    searchCtrl.clear();
    query = '';
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    if (query.isEmpty) {
      _filtered = List.from(_allChats);
      return;
    }
    _filtered = _allChats
        .where((c) =>
            c.lastMessage
                .toLowerCase()
                .contains(query) ||
            c.sellerId
                .toLowerCase()
                .contains(query))
        .toList();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchCtrl.dispose();
    super.dispose();
  }
}