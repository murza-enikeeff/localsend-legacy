# LocalSend Legacy (Custom Intel macOS Build)

This project is an unofficial, community-maintained branch of the amazing [LocalSend](https://github.com/localsend/localsend) application, originally based on version 1.10.0.

All credit for creating the original application goes to its authors. The original codebase (v1.10.0) is licensed under the **MIT License**. All subsequent modifications and backported features are distributed under the **Apache License 2.0**, fully preserving the creators' copyrights.

### Why does this fork exist?
In newer versions, the Flutter engine completely transitioned to rendering via the Metal graphics API, dropping support for OpenGL. As a result, on older Intel Macs (especially those running modern macOS via OpenCore Legacy Patcher — OCLP), the UI of modern LocalSend releases fails to render, displaying a blank screen.

Prior to this build, users of older Macs had to stay on LocalSend 1.7.0 (the last version with a working interface). However, version 1.7.0 relies on the deprecated `v1` data transfer protocol, which is incompatible with modern clients (versions 1.9.0 and above use the secure `v2` protocol). This made it impossible to share files with up-to-date devices running iOS, Android, or Windows.

**LocalSend Legacy solves this problem:**
This build is intentionally locked to **Flutter 3.3.10** (which still fully supports OpenGL), bringing the interface back to life on older Macs. Under the hood, it runs version 1.10.0 with the up-to-date `v2` protocol. Now you can seamlessly exchange files with any modern device.

### Development Vector (Backporting)
This project is not intended to be a one-off build, but rather a parallel branch. Improvements, bug fixes, and new features from fresh releases of the original LocalSend will be **backported** here to `localsend-legacy`, while strictly keeping the core on Flutter 3.3.10 (Dart 2.18).

### Technical Build Details
To successfully compile the code on an older engine, the following patches were applied:
* **Dependency Freezing:** In `pubspec.yaml`, library versions are strictly locked via `dependency_overrides` (e.g., `collection: 1.17.2`) to ensure compatibility with Dart 2.18.
* **Dart Syntax Patch:** The `context.mounted` getter (introduced in Flutter 3.7) has been safely patched throughout the project.
* **Conflict Resolution:** Resolved an import conflict for the `MenuItem` class between the Flutter UI and `tray_manager` library.
* **Build Environment:** Strictly compiled using **Xcode 14.0.1**.

### How to build
If you want to compile the project yourself, ensure you have **Flutter 3.3.10** and **Xcode 14.0.1** installed. Then, run the following commands in your terminal:

```bash
cd localsend-legacy
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter build macos
