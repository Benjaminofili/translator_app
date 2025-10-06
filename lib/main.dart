import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/providers/theme-provider.dart';
import 'core/services/hive_service.dart'; // ✅ import HiveService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Hive before running the app
  await HiveService.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeModeAsync = ref.watch(appThemeModeProvider);

    return themeModeAsync.when(
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (err, stack) => MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Error loading theme: $err')),
        ),
      ),
      data: (isDarkMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'AI Voice Translator',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          routerConfig: router,
        );
      },
    );
  }
}
