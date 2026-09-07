import 'file_downloader_stub.dart'
    if (dart.library.html) 'file_downloader_web.dart' as platform_downloader;

/// Cross-platform helper to handle downloading/viewing assets
class FileDownloader {
  static Future<void> downloadResume({
    String assetPath = 'assets/resume/KarthickResume.pdf',
    String fileName = 'Karthick_Resume.pdf',
  }) async {
    await platform_downloader.downloadFile(assetPath, fileName);
  }
}
