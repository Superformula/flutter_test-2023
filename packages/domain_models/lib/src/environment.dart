enum Environment { dev, prod }

extension EnvironmentX on Environment {
  bool get isDev => this == Environment.dev;
  bool get isProd => this == Environment.prod;
}