class Endpoint {
  static const String baseUrlApi =
      // "http://192.168.4.184:8000/api/users/";
      "http://192.168.43.21:8000/api/users/";

  static const String register = "${baseUrlApi}registrasi";
  static const String login = "${baseUrlApi}login";
  static const String logout = "${baseUrlApi}logout";
  static const String buku = "${baseUrlApi}buku";
  static const String bukuNew = "${baseUrlApi}buku/new";
  static const String detailBuku = "${baseUrlApi}buku/detail";
  static const String bukuPopular = "${baseUrlApi}popular/buku";
  static const String koleksiBuku = "${baseUrlApi}koleksi";
  static const String deleteKoleksi = "${baseUrlApi}";
  static const String historyPeminjaman = "${baseUrlApi}pinjam";
}