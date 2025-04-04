abstract class MediaRepository {
  Future<List<String>> getMediaUrls();
  Future<void> uploadMedia(String filePath);
  Future<void> deleteMedia(String mediaId);
}
