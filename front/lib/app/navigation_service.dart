import 'package:flutter/material.dart';

// Clave global para navegar desde capas sin BuildContext (ej: interceptor HTTP).
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
