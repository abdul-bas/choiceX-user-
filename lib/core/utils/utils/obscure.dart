import 'package:coice/state/bloc/obscure_bloc/obscure_state.dart';

class Obscure {
  TextObs currentState = TextObs();
  Future<TextObs> toggleValue1() async {
    try {
      bool obscure = !currentState.obscure;
      currentState = TextObs(obscure: obscure, obscue2: currentState.obscue2);
      return currentState;
    } catch (e) {
      rethrow;
    }
  }

  Future<TextObs> toggleValue2() async {
    try {
      bool obscure = !currentState.obscue2;
      currentState = TextObs(obscure: currentState.obscure, obscue2: obscure);
      return currentState;
    } catch (e) {
      rethrow;
    }
  }
}
