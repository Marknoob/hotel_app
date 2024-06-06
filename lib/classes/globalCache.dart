import 'package:cached_network_image/cached_network_image.dart';

class ImageCacheManager {
  static final Map<String, CachedNetworkImageProvider> _cache = {};

  static CachedNetworkImageProvider getImage(String url) {
    if (!_cache.containsKey(url)) {
      _cache[url] = CachedNetworkImageProvider(url);
    }
    return _cache[url]!;
  }

  static void preloadImages(List<String> urls) {
    for (var url in urls) {
      getImage(url);
    }
  }
}
