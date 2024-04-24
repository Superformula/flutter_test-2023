// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'YELP_KEY', obfuscate: true)
    static String YELP_KEY = _Env.YELP_KEY;
}