
import 'package:coice/core/constants/enums/spec_kind.dart';

class SpecItem {
  final String field;
  final String value;
  final SpecKind kind;

  const SpecItem(this.field, this.value, [this.kind = SpecKind.normal]);
}