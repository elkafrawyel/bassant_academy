class Environment {
  static const AppMode appMode = AppMode.testing;

  static url() {
    switch (appMode) {
      case AppMode.testing:
      case AppMode.staging:
        return 'http://mohammedzakii-001-site3.htempurl.com/api/';
      case AppMode.live:
        return 'http://mohammedzakii-001-site3.htempurl.com/api/';
    }
  }
}

enum AppMode {
  testing,
  staging,
  live,
}
