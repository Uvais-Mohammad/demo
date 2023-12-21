import 'package:sf_chat_im/main.dart' as runner;
import 'package:sf_chat_im/shared/utilities/flavors.dart';

Future<void> main() async {
  F.appFlavor = Flavor.dev;
  await runner.main();
}
