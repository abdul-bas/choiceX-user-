String groupedTxn(String id) {
  String clean = id.replaceAll('-', '').toUpperCase();
  return "TXN-${clean.substring(0,4)}-${clean.substring(4,8)}-${clean.substring(8,12)}-${clean.substring(12,16)}";
}


