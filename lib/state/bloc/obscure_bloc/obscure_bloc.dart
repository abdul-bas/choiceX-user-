import 'package:coice/core/utils/utils/obscure.dart';
import 'package:coice/state/bloc/obscure_bloc/obscure_event.dart';
import 'package:coice/state/bloc/obscure_bloc/obscure_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObscureBloc extends Bloc<ObscureEvent, ObscureTextState> {
 final Obscure _obscure = Obscure();
  ObscureBloc() : super(TextObs(obscure: true,obscue2: true)) {
    on<Value1Change>((event, emit)async {
      final resulte = await _obscure.toggleValue1();
      emit(resulte);
    });
    on<Value2Change
    >((event, emit)async {
      final resulte = await _obscure.toggleValue2();
      emit(resulte);
    });
    
  }
}