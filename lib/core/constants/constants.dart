// in future manage it with multipe app flavors (DEV, STAGE, PROD) etc
class Constants {
  static const String BASE_URL = "https://www.rijksmuseum.nl";
  static const String API_EN_COLLECTION = "/api/en/collection";
  static const String API_NL_COLLECTION = "/api/nl/collection";
  static const String API_KEY = "0fiuZFh4";

  static const String iosAppSecret = "3b21de47-966e-4ce9-959d-81bc4ecf6f38";
  static const String androidAppSecret = "adfb6486-a1e2-4a21-b0b8-8af131e5afed";

  static const String artifacts = "Artifacts";

  static const String errorStateText = "Ops Something went wrong 💔";
  static const String initialStateText = "Going to getting data";
  static const String loadingStateText = "Searching awesome art for you ❤";

  static const int artifactsPerPage = 10;
}
