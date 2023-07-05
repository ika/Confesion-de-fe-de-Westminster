// Utilities

String reduceLength(String t, int l) { // text, length
  return (t.length > l) ? '${t.substring(0, l)}...' : t;
}

int getTime() {
  return DateTime.now().microsecondsSinceEpoch;
}
