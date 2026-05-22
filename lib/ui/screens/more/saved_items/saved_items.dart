import 'package:coice/ui/screens/favorite/favorite_screen.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:flutter/material.dart';

class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      centerTitle: true,
       leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back)),
                title: TextSlab(
                  text: 'My Favorites',
                  letterSpacing: 0.3,
                  fontSize: 20,
                ),),
                body: FavoriteScreen(),);
  }
}
