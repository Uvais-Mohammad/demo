enum MessagePrivacyScope {
  public,
  private,
  partiallyVisible,
  notVisible;

  static MessagePrivacyScope fromInt(int value) {
    switch (value) {
      case 1:
        return MessagePrivacyScope.public;
      case 2:
        return MessagePrivacyScope.private;
      case 3:
        return MessagePrivacyScope.partiallyVisible;
      case 4:
        return MessagePrivacyScope.notVisible;
      default:
        return MessagePrivacyScope.public;
    }
  }

  int toInt() {
    switch (this) {
      case MessagePrivacyScope.public:
        return 1;
      case MessagePrivacyScope.private:
        return 2;
      case MessagePrivacyScope.partiallyVisible:
        return 3;
      case MessagePrivacyScope.notVisible:
        return 4;
      default:
        return 1;
    }
  }
}
