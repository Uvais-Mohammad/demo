// Message types: 1=text message; 2=image message; 3=voice message; 4=video message;

enum DiscoverType {
  text,
  image,
  voice,
  video,
  file,
  share;

  static DiscoverType fromInt(int value) {
    switch (value) {
      case 1:
        return DiscoverType.text;
      case 2:
        return DiscoverType.image;
      case 3:
        return DiscoverType.voice;
      case 4:
        return DiscoverType.video;
      case 5:
        return DiscoverType.file;
      case 6:
        return DiscoverType.share;
      default:
        return DiscoverType.text;
    }
  }

  int toInt() {
    switch (this) {
      case DiscoverType.text:
        return 1;
      case DiscoverType.image:
        return 2;
      case DiscoverType.voice:
        return 3;
      case DiscoverType.video:
        return 4;
      case DiscoverType.file:
        return 5;
      case DiscoverType.share:
        return 6;
      default:
        return 1;
    }
  }
}
