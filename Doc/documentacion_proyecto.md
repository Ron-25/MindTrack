# MindTrack - Documentacion del Proyecto

> Documento guia para entender el producto, el estado actual del repositorio y el orden recomendado de trabajo en equipo.

## 1. Resumen ejecutivo

MindTrack es una aplicacion movil de bienestar personal orientada al registro emocional, seguimiento de habitos y analitica de bienestar. Su objetivo es ayudar al usuario a identificar patrones entre sus emociones, rutinas diarias y contexto personal, para mejorar su autoconocimiento y tomar decisiones de autocuidado mas informadas.

La propuesta combina:

- Registro de emociones con intensidad, etiquetas, notas y contexto.
- Historial emocional filtrable y consultable.
- Seguimiento de habitos con metas semanales.
- Dashboard de resumen diario/semanal.
- Analitica de patrones emocionales y correlacion con habitos.
- Configuracion de perfil, idioma, tema, privacidad y notificaciones.
- Chat con IA e insights personalizados como funcionalidad avanzada.

El producto no debe presentarse como reemplazo de terapia psicologica ni atencion profesional. Su rol es de acompanamiento, reflexion y apoyo al registro personal.

## 2. Documentos revisados

Esta guia se elaboro revisando el repositorio actual y los documentos enviados:

- `MindTrack_Semana4.pdf`: vision funcional inicial, alcance, modulos, roles y cronograma.
- `MindTrack_Arquitectura_v2.pdf`: arquitectura objetivo, ERD, capas backend, frontend, deploy y estructura de trabajo.
- `MindTrack_Documentacion_Funcional.pdf`: marco teorico, requerimientos funcionales/no funcionales y casos de uso.
- `E2_GrupoC_1IL142.pdf`: documento academico de referencia del proyecto.

## 3. Publico objetivo

Segmento principal:

- Adultos jovenes interesados en salud mental, mindfulness, productividad personal y bienestar.
- Personas que quieren entender mejor sus emociones y sostener habitos saludables.

Segmentos secundarios:

- Profesionales con estres laboral.
- Personas en proceso terapeutico que desean complementar su terapia con registros diarios.
- Coaches, psicologos o terapeutas en una posible version SaaS futura, siempre con consentimiento del usuario.

## 4. Problema que resuelve

MindTrack atiende tres problemas principales:

- Falta de autoconciencia emocional: muchas personas no registran ni analizan como cambia su estado emocional.
- Desconexion entre habitos y emociones: los habitos diarios influyen en el bienestar, pero normalmente se registran en herramientas separadas.
- Friccion de uso: muchas apps de diario o bienestar requieren demasiado tiempo, tienen interfaces complejas o no ofrecen retroalimentacion util.

La oportunidad del proyecto esta en unir registro emocional rapido, habitos y analitica en una experiencia sencilla y visual.

## 5. Modulos funcionales objetivo

### 5.1 Home / Dashboard

Pantalla principal del usuario. Debe mostrar:

- Saludo personalizado.
- Fecha actual.
- Ultima emocion registrada.
- Resumen emocional semanal.
- Progreso de habitos activos.
- CTA para registrar nueva emocion.
- CTA para marcar habito.
- Insight del dia.
- Racha de registro.
- Mini calendario semanal con color por emocion predominante.

### 5.2 Historial emocional

Modulo central del producto. Debe permitir:

- Crear registros emocionales.
- Listar registros en orden cronologico inverso.
- Ver detalle de una entrada.
- Editar y eliminar registros.
- Filtrar por fecha, emocion, intensidad y etiquetas.
- Buscar texto dentro de notas.
- Registrar contexto: lugar, actividad y personas.
- Usar catalogo basado en Plutchik: alegria, tristeza, rabia, miedo, sorpresa, disgusto, anticipacion y confianza.

### 5.3 Habitos

Modulo para conectar rutinas con bienestar emocional:

- Crear habitos con nombre, descripcion, icono, color, categoria y meta semanal.
- Registrar estado diario: completado, pendiente o saltado.
- Ver progreso semanal por habito.
- Calcular rachas.
- Archivar habitos inactivos sin perder historial.
- Configurar recordatorios.

Categorias sugeridas:

- Salud
- Mente
- Social
- Productividad
- Otros

### 5.4 Analytics

Modulo diferenciador. Debe transformar datos en informacion util:

- Resumen semanal y mensual.
- Emocion dominante.
- Intensidad promedio.
- Cantidad de registros.
- Grafico de frecuencia emocional.
- Linea de tiempo de intensidad.
- Mapa de calor semanal.
- Correlacion habitos-emociones.
- Distribucion por hora del dia.
- Racha actual y maxima.
- Exportacion CSV/PDF como funcionalidad premium.
- Panel de insights inteligentes.

### 5.5 Settings

Modulo de cuenta y preferencias:

- Perfil: nombre, foto, correo y contrasena.
- Tema claro, oscuro o sistema.
- Idioma espanol/ingles.
- Notificaciones.
- Privacidad: PIN o biometria.
- Exportar datos.
- Eliminar cuenta.
- Cerrar sesion.
- Plan de suscripcion.
- Ayuda y soporte.

### 5.6 IA / Asistente conversacional

Funcionalidad avanzada del producto:

- Chat de apoyo emocional.
- Recomendaciones personalizadas.
- Sugerencias de habitos.
- Interpretacion de patrones en lenguaje natural.
- Mensajes motivacionales.
- Ayuda para completar registros.

Importante: el asistente debe incluir limites claros de seguridad, privacidad y alcance. No debe diagnosticar, reemplazar terapia ni dar instrucciones medicas.

## 6. Arquitectura objetivo

### 6.1 Backend

Stack objetivo:

- Python 3.11+
- FastAPI
- SQLAlchemy 2.x async
- PostgreSQL 15/16+
- Alembic para migraciones
- Redis para cache, rate limit, blacklist de tokens o Celery
- Celery para tareas programadas
- JWT con refresh tokens

Capas:

- `api/v1/endpoints`: routers HTTP.
- `schemas`: validacion de entrada/salida con Pydantic.
- `services`: casos de uso y reglas de negocio.
- `repositories`: acceso a datos.
- `models`: entidades ORM.
- `core`: seguridad, base de datos, excepciones y utilidades transversales.
- `workers`: tareas asincronas y programadas.

### 6.2 Frontend

Stack actual/objetivo:

- Flutter / Dart
- Arquitectura por features.
- BLoC/Cubit para estado.
- Drift/SQLite para persistencia local.
- GetIt para inyeccion de dependencias.
- Internacionalizacion espanol/ingles.
- Tema visual centralizado.

Estructura esperada:

- `app`: configuracion global, rutas, tema, l10n e injector.
- `core`: base de datos local, servicios, constantes, errores y utilidades.
- `features`: modulos por dominio.
- `shared`: widgets reutilizables.

## 7. Modelo de datos principal

Entidades centrales:

- `User`: cuenta del usuario.
- `UserPreferences`: tema, idioma, notificaciones, PIN/biometria.
- `RefreshToken`: sesiones y renovacion de autenticacion.
- `EmotionType`: catalogo de emociones del sistema o personalizadas.
- `EmotionLog`: registro emocional con intensidad, nota, contexto y fecha.
- `Tag`: etiquetas personalizadas.
- `emotion_log_tags`: relacion muchos a muchos entre registros y etiquetas.
- `Habit`: habito del usuario.
- `HabitLog`: cumplimiento diario del habito.
- `WeeklySummary`: resumen semanal calculado.
- `Notification`: reglas de notificacion.

## 8. Estado actual del repositorio

### 8.1 Estructura general

El repositorio contiene:

- `back/`: API FastAPI.
- `front/`: aplicacion Flutter.
- `Doc/`: carpeta de documentacion.
- `README.md`: actualmente minimo.

### 8.2 Backend actual

Ya existe una base importante:

- App FastAPI en `back/app/main.py`.
- Router versionado `/api/v1`.
- CORS configurado desde settings.
- Endpoints para:
  - Auth: register, login, refresh, logout, me.
  - Emotions: listar, crear, obtener, actualizar, eliminar.
  - Emotion types: listar y crear.
  - Tags: listar, crear, actualizar, eliminar.
  - Habits: listar, crear, obtener, actualizar, archivar, eliminar.
  - Habit logs: registro por habito y progreso semanal dentro del router de habits.
  - Analytics: weekly summary, emotion frequency, habits mood.
  - Users: profile, preferences, delete account.
- Modelos SQLAlchemy para usuarios, emociones, habitos, resumenes y notificaciones.
- Servicios y repositorios separados.
- Configuracion por variables de entorno.
- Seguridad con JWT y hashing de contrasenas.
- Workers/Celery presentes en estructura.

Riesgos o pendientes detectados:

- No se observan migraciones Alembic en el repo.
- No se observa suite de tests.
- `requirements` no tiene extension `.txt`, aunque el comentario indica `requirements.txt`.
- Hay archivos `._*.py` y `__pycache__` versionados o presentes en el arbol, probablemente residuos de sistema.
- El manejo de refresh tokens parece comparar hashes generados de nuevo; con Argon2/bcrypt esto puede fallar si el hash usa salt aleatorio. Debe revisarse.
- Faltan endpoints especificos de notificaciones, exportacion y chat IA.
- Falta documentar `.env.example` y comandos de ejecucion.

### 8.3 Frontend actual

Ya existe:

- Proyecto Flutter funcional.
- Splash.
- Onboarding.
- Login y registro visual.
- Home inicial.
- Tema, colores y estilos.
- Localizacion `es`/`en`.
- Widgets compartidos.
- Drift/SQLite configurado.
- Tablas locales para emociones y habitos.
- Feature `emotion_tracker` con entidades, modelos, data source, repository, usecases, cubit y pantallas base.
- Login con `HydratedBloc`.

Riesgos o pendientes detectados:

- `front/lib/app/routes/app_router.dart` parece incompleto.
- Login simula exito con delay; aun no consume el backend.
- No hay cliente HTTP centralizado visible.
- No hay sincronizacion local-remota.
- Faltan pantallas completas de analytics, habitos, settings e IA.
- `emotion_cubit.dart` aparece vacio o incompleto.
- Falta flujo real de sesion, refresh token y logout.
- Falta validacion de accesibilidad visual y pruebas widget/unitarias.

## 9. Lo que falta para completar el MVP

Prioridad alta:

- Completar navegacion del frontend.
- Conectar login/register del frontend con el backend.
- Crear cliente HTTP y manejo de tokens.
- Definir `.env.example` para backend.
- Crear migraciones Alembic o script claro de inicializacion de BD.
- Completar CRUD emocional end-to-end desde Flutter hasta API.
- Completar CRUD de habitos end-to-end.
- Implementar dashboard con datos reales.
- Agregar tests minimos backend para auth, emotions y habits.
- Limpiar archivos basura (`__pycache__`, `._*`) y ajustar `.gitignore`.

Prioridad media:

- Filtros avanzados del historial.
- Analytics visuales en frontend.
- Notificaciones locales y/o backend.
- Settings de perfil/preferencias.
- Modo offline con cola de sincronizacion.
- Rachas.
- Seed de emociones base Plutchik.

Prioridad baja o post-MVP:

- Chat IA.
- Exportacion CSV/PDF.
- Planes premium.
- Version SaaS para terapeutas/coaches.
- Integraciones externas.
- Gamificacion avanzada.

## 10. Orden recomendado de trabajo

### Fase 1 - Estabilizar base tecnica

Objetivo: que todo el equipo pueda correr el proyecto.

Tareas:

- Crear `README.md` principal con instalacion.
- Crear `back/.env.example`.
- Renombrar o documentar `back/requirements`.
- Confirmar version de Python y Flutter.
- Limpiar archivos generados del repo.
- Configurar `.gitignore` para Python, Flutter y sistema operativo.
- Verificar que FastAPI levante y que Swagger funcione.
- Verificar que Flutter compile.

Responsables sugeridos:

- Backend: Francisco.
- Frontend: Ronald.
- QA/UX/documentacion: Javier.

### Fase 2 - Autenticacion real

Objetivo: que un usuario pueda registrarse, iniciar sesion y mantener sesion.

Backend:

- Revisar refresh token hashing.
- Validar register/login/refresh/logout/me.
- Agregar pruebas.

Frontend:

- Crear servicio HTTP.
- Crear auth repository.
- Conectar login/register.
- Guardar tokens de forma segura.
- Redirigir segun estado de sesion.

QA:

- Casos: registro exitoso, email duplicado, login invalido, logout, token expirado.

### Fase 3 - Registro emocional end-to-end

Objetivo: que el usuario pueda registrar y consultar emociones reales.

Backend:

- Seed de emociones Plutchik.
- Validar CRUD completo de emotion logs.
- Validar tags y filtros.

Frontend:

- Completar `emotion_cubit`.
- Conectar pantallas `add_emotion_page` y `emotion_detail_page`.
- Listar historial.
- Crear detalle, editar y eliminar.
- Manejar estados loading/error/empty.

QA:

- Verificar que una emocion creada aparezca en home e historial.

### Fase 4 - Habitos end-to-end

Objetivo: crear habitos, marcarlos y ver progreso semanal.

Backend:

- Validar create/list/update/archive/log/progress.
- Agregar reglas para no duplicar logs por fecha.

Frontend:

- Crear feature de habitos si no existe.
- Pantalla de lista.
- Pantalla de creacion/edicion.
- Marcado diario.
- Progreso semanal.

QA:

- Casos de habito completado, saltado, archivado y progreso.

### Fase 5 - Home y analytics

Objetivo: que la app muestre valor rapidamente.

Backend:

- Confirmar endpoints de weekly summary, frequency y habits mood.
- Generar insight simple por reglas antes de IA.

Frontend:

- Home con ultima emocion, progreso de habitos y resumen semanal.
- Graficas basicas.
- Estados vacios utiles.

QA:

- Validar rendimiento y consistencia de datos.

### Fase 6 - Settings, notificaciones y polish

Objetivo: cerrar experiencia de usuario.

Tareas:

- Perfil y preferencias.
- Tema claro/oscuro/sistema.
- Idioma espanol/ingles.
- Notificaciones.
- Accesibilidad.
- Mensajes de error.
- Pruebas finales.

### Fase 7 - IA y funcionalidades avanzadas

Objetivo: agregar diferenciadores sin romper el MVP.

Tareas:

- Definir proveedor IA.
- Crear endpoint de chat.
- Agregar politicas de seguridad.
- Limitar contexto enviado.
- Registrar disclaimers.
- Crear insights personalizados.
- Evaluar costos.

## 11. Reglas de trabajo en equipo

### 11.1 Flujo de ramas

Usar ramas por tarea:

- `feature/auth-frontend`
- `feature/emotion-crud`
- `feature/habits-progress`
- `fix/refresh-token`
- `docs/project-guide`

Evitar trabajar todos directo en `main`.

### 11.2 Commits

Formato sugerido:

- `feat: add emotion log endpoint`
- `fix: correct refresh token validation`
- `docs: add project documentation`
- `test: add auth service tests`
- `chore: update gitignore`

### 11.3 Pull requests

Cada PR debe incluir:

- Que cambia.
- Como probarlo.
- Capturas si toca UI.
- Riesgos conocidos.
- Checklist de pruebas.

### 11.4 Definicion de terminado

Una tarea se considera terminada cuando:

- Compila sin errores.
- Tiene manejo de errores basico.
- Respeta el diseno y la arquitectura del modulo.
- Esta conectada al flujo real si aplica.
- Tiene pruebas o al menos pasos manuales claros.
- No rompe pantallas existentes.
- Esta documentada si agrega configuracion o comandos.

## 12. Requerimientos no funcionales importantes

- Rendimiento: home debe cargar en menos de 2 segundos en condiciones normales.
- Seguridad: HTTPS en produccion, contrasenas hasheadas, tokens protegidos.
- Privacidad: datos emocionales son sensibles y requieren tratamiento cuidadoso.
- Offline: registro emocional y marcado de habitos deben funcionar sin conexion en la version objetivo.
- Mantenibilidad: backend con capas claras y pruebas.
- Accesibilidad: contraste adecuado y soporte para lectores de pantalla.
- Compatibilidad: Android 9+ e iOS 14+ como meta.

## 13. Riesgos del proyecto

- Alcance muy amplio para el tiempo disponible.
- IA puede consumir demasiado tiempo si se intenta antes del MVP.
- Sin migraciones y tests, el backend puede volverse fragil.
- Sin router y auth real, el frontend puede quedar como prototipo visual.
- Offline + sincronizacion es complejo; conviene dejarlo para despues del CRUD online o implementarlo de forma incremental.
- Datos emocionales implican responsabilidad de privacidad y mensajes cuidadosos.

## 14. Recomendacion de alcance para la proxima revision

Para una revision cercana, conviene mostrar un flujo vertical completo:

1. Usuario se registra o inicia sesion.
2. Ve home.
3. Registra una emocion.
4. La emocion aparece en historial.
5. Crea un habito.
6. Marca el habito como completado.
7. Ve un resumen basico en dashboard o analytics.

Esto demuestra producto real mejor que muchas pantallas aisladas sin conexion.

## 15. Checklist operativo

Backend:

- [ ] Crear `.env.example`.
- [ ] Confirmar nombre de `requirements`.
- [ ] Crear migracion inicial.
- [ ] Crear seed de emociones.
- [ ] Revisar refresh tokens.
- [ ] Agregar tests de auth.
- [ ] Agregar tests de emotions.
- [ ] Agregar tests de habits.
- [ ] Documentar endpoints principales.

Frontend:

- [ ] Completar router.
- [ ] Crear cliente HTTP.
- [ ] Conectar auth.
- [ ] Completar cubit de emociones.
- [ ] Conectar registro emocional.
- [ ] Crear feature de habitos.
- [ ] Crear home con datos reales.
- [ ] Crear analytics basico.
- [ ] Completar settings.
- [ ] Revisar responsive/accesibilidad.

Equipo:

- [ ] Definir responsables por fase.
- [ ] Mantener tablero de tareas.
- [ ] Hacer PRs pequenos.
- [ ] Documentar decisiones tecnicas.
- [ ] Preparar demo con datos semilla.

## 16. Comandos utiles esperados

Backend:

```bash
cd back
python -m venv .venv
source .venv/bin/activate
pip install -r requirements
uvicorn app.main:app --reload
```

En Windows PowerShell:

```powershell
cd back
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements
uvicorn app.main:app --reload
```

Frontend:

```bash
cd front
flutter pub get
flutter run
```

Generacion de codigo Flutter si se modifican Drift, intl u otros generadores:

```bash
cd front
dart run build_runner build --delete-conflicting-outputs
```

## 17. Glosario rapido

- EmotionLog: entrada emocional registrada por el usuario.
- EmotionType: tipo de emocion, del sistema o personalizada.
- Tag: etiqueta para clasificar entradas.
- Habit: habito definido por el usuario.
- HabitLog: cumplimiento diario de un habito.
- WeeklySummary: resumen semanal generado por analitica.
- Insight: interpretacion o recomendacion generada desde datos.
- MVP: version minima viable para demostrar el valor principal.

## 18. Decision recomendada

El equipo deberia priorizar un MVP solido antes de IA:

1. Auth real.
2. Registro emocional real.
3. Habitos reales.
4. Home con resumen.
5. Analytics basico.
6. Settings minimo.
7. IA e insights avanzados.

Asi el proyecto mantiene foco, reduce riesgo y llega a revision con una aplicacion demostrable de punta a punta.
