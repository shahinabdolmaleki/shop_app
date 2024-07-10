class BannerApp {
  String? collectionId;
  String? id;
  String? thumbnail;
  String? title;

//http://127.0.0.1:8090/api/files/COLLECTION_ID_OR_NAME/RECORD_ID/FILENAME
  BannerApp(
    this.collectionId,
    this.id,
    this.thumbnail,
    this.title,
  );

  factory BannerApp.fromMapJson(Map<String, dynamic> jsonObject) {
    return BannerApp(
      jsonObject['collectionId'],
      jsonObject['id'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      jsonObject['title'],
    );
  }
}
