import 'package:process_run/process_run.dart';

String getPathVideos() {
  try {
    final result =
        runExecutableArgumentsSync('cmd', ['/c', 'echo', '%USERPROFILE%']);
    if (result.exitCode == 0) {
      return result.stdout.trim() + '\\Videos';
    } else {
      return 'Error retrieving variable: ${result.stderr}';
    }
  } catch (e) {
    return 'Exception: $e';
  }
}
