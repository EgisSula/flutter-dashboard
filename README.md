# flutter_application_1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Running the dashboard

The Flutter project is this folder (the one with `pubspec.yaml`). Either:

- double-click `run_dashboard.bat` in the folder above this one, or
- open a terminal **in this folder** and run `flutter run -d chrome`.

Log in with username **admin** and password **admin**. Every dashboard page sends
you back to the login page until you do (`lib/routing/auth_middleware.dart`).

Pages: Overview, Map, Support (Support Chats, Chat History), Drivers (Drivers,
Vehicles, Driver Rates), Clients (Clients, Client Rates) and the Ride page that
opens from **View** in the Rides table.

## Checking a change

- `flutter analyze` - static checks
- `flutter test` - opens every page in light and dark mode at phone, tablet and
  desktop sizes and fails on any layout error, logs in, and presses the dashboard's buttons
  (see `test/dashboard_test.dart`)
- `check_dashboard.bat` (in the folder above) runs both, plus a web build, and
  writes the output to `_check/`

## Fonts

Mulish and Roboto Bold are bundled in `assets/fonts/` (SIL Open Font License, see
the `*-OFL.txt` files there), so `google_fonts` does not download them at runtime.
