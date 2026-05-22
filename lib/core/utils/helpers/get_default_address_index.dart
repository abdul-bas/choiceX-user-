int getDefaultAddressIndex(
    List<Map<String, dynamic>>? addresses) {
  if (addresses == null || addresses.isEmpty) {
    return -1;
  }

  final index =
      addresses.indexWhere((e) => e['IsDefault'] == true);

  return index == -1 ? 0 : index;
}
