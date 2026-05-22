import 'package:coice/state/bloc/product/poroduct_event/product_event.dart';

class LoadRating extends ProductBlocEvent {
 
   String productId;
   int variantIndex;
   int  limit;
   
  LoadRating({required this. productId, required this. variantIndex,required this. limit});
}
