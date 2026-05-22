Map<String, dynamic>? getDefaultAddress(
    List<Map<String, dynamic>>? addresses) {
  if (addresses == null || addresses.isEmpty) {
    return null;
  }

  final defaultIndex =
      addresses.indexWhere((e) => e['IsDefault'] == true);

  if (defaultIndex == -1) {
    return addresses.first; 
  }

  return addresses[defaultIndex];
}
