import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Guarda la foto de perfil como archivo local en el dispositivo (no se
/// sube al backend). Sobrescribe siempre el mismo archivo por usuario.
class LocalAvatarService {
  const LocalAvatarService();

  Future<File> _avatarFile() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/profile_avatar.jpg');
  }

  /// Devuelve el archivo de avatar guardado, o null si no existe.
  Future<File?> getAvatar() async {
    final File file = await _avatarFile();
    return file.existsSync() ? file : null;
  }

  /// Copia la imagen elegida al almacenamiento local de la app.
  Future<File> saveAvatar(File source) async {
    final File destination = await _avatarFile();
    return source.copy(destination.path);
  }

  Future<void> deleteAvatar() async {
    final File file = await _avatarFile();
    if (file.existsSync()) {
      await file.delete();
    }
  }
}
