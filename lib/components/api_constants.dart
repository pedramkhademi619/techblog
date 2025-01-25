class ApiConstants {
  static const baseUrl = "https://techblog.sasansafari.com/Techblog/api/";
  static const hostDlUrl = "https://techblog.sasansafari.com";
  static const getHomeItems = "${baseUrl}home/?command=index";
  static const getArticleList =
      "${baseUrl}article/get.php?command=new&user_id=1";
  static const getArticleInfo =
      "${baseUrl}article/get.php?command=info&id=1&user_id=1";
}
