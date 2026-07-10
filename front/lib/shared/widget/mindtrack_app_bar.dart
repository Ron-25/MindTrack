import 'package:flutter/material.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/core/services/token_storage_service.dart';
import 'package:mind_track/features/login/presentation/blocs/login_bloc.dart';
import 'package:mind_track/features/login/presentation/blocs/login_event.dart';

class MindTrackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MindTrackAppBar({
    required this.title,
    this.showActions = true,
    super.key,
  });

  final String title;
  final bool showActions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 12,
      title: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0x335FA9D3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.psychology_alt_rounded,
              color: AppColors.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
                color: colors.onSurface,
              ),
            ),
          ),
        ],
      ),
      actions: showActions
          ? <Widget>[
              _AppBarActionButton(
                icon: Icons.notifications_none_rounded,
                onTap: currentRoute == RouteNames.notifications
                    ? null
                    : () => Navigator.of(
                        context,
                      ).pushNamed(RouteNames.notifications),
              ),
              const SizedBox(width: 8),
              _AppBarActionButton(
                icon: Icons.logout_rounded,
                tooltip: S.of(context).home_logout_tooltip,
                onTap: () => _handleLogout(context),
              ),
              const SizedBox(width: 12),
            ]
          : null,
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    await Injector.get<TokenStorageService>().clearTokens();
    Injector.get<LoginBloc>().add(const LoginStatusReset());
    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.signIn,
      (Route<dynamic> route) => false,
    );
  }
}

class _AppBarActionButton extends StatelessWidget {
  const _AppBarActionButton({
    required this.icon,
    required this.onTap,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Widget button = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: onTap == null
              ? colors.surfaceContainerHighest
              : colors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Icon(
          icon,
          color: onTap == null ? colors.onSurfaceVariant : colors.onSurface,
          size: 20,
        ),
      ),
    );

    if (tooltip == null || tooltip!.trim().isEmpty) {
      return button;
    }

    return Tooltip(message: tooltip!, child: button);
  }
}
