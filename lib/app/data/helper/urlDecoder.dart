class UrlDecoder{
  static Future<String> decode(String url) async{
    // Decode URL untuk mendapatkan path file
    final Uri uri = Uri.parse(url);
    String path = uri.pathSegments[1]; // Mendapatkan path terenkripsi
    path = Uri.decodeComponent(path); // Decode ke path asli

    return path;
  }
}