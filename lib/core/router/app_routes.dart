import 'package:go_router/go_router.dart';
import 'package:shalat_reminder/features/prayer_reminder/presentation/pages/home.dart';
import 'package:shalat_reminder/features/setting_notifications/presentation/pages/notification.dart';

/// Kelas ini berfungsi sebagai pusat definisi nama dan path rute.
/// Menggunakan konstanta untuk mencegah kesalahan pengetikan (typo).
class AppRoutes {
  // --- Route Names ---
  // Menggunakan nama agar lebih mudah dipanggil dengan `context.goNamed()`
  static const String home = 'home';
  static const String notificationSettings = 'notification-settings';

  // --- Route Paths ---
  static const String homePath = '/';
  // Path dengan parameter untuk ID produk
  static const String notificationSettingsPath = '/notification';
}

/// Konfigurasi utama untuk GoRouter.
/// Semua logika rute, parameter, dan halaman tujuan didefinisikan di sini.
class AppRouter {
  static final GoRouter router = GoRouter(
    // Halaman yang akan ditampilkan jika rute tidak ditemukan (404)
    // errorBuilder: (context, state) => ErrorPage(error: state.error),

    // Daftar semua rute yang tersedia di aplikasi
    routes: <GoRoute>[
      GoRoute(
        name: AppRoutes.home, // Menggunakan konstanta nama
        path: AppRoutes.homePath, // Menggunakan konstanta path
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: AppRoutes.notificationSettings, // Menggunakan konstanta nama
        path: AppRoutes.notificationSettingsPath, // Menggunakan konstanta path
        builder: (context, state) => const NotificationSettingsPage(),
      ),
    ],
  );
}
