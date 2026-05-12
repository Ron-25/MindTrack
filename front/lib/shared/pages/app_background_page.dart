import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/theme/app_colors.dart';

class AppBackgroundPage extends StatelessWidget {

	const AppBackgroundPage({
		super.key,
		required this.child,
		this.useSafeArea = true,
	});
	final Widget child;
	final bool useSafeArea;

	@override
	Widget build(BuildContext context) {
		final Widget content = useSafeArea ? SafeArea(child: child) : child;
		return AnnotatedRegion<SystemUiOverlayStyle>(
			value: const SystemUiOverlayStyle(
				statusBarColor: Colors.transparent,
				statusBarIconBrightness: Brightness.dark,
				statusBarBrightness: Brightness.light,
				systemNavigationBarColor: AppColors.background,
				systemNavigationBarIconBrightness: Brightness.dark,
			),
			child: Scaffold(
				backgroundColor: AppColors.background,
        
				body: Container(
					width: double.infinity,
					height: double.infinity,
					decoration: const BoxDecoration(
						gradient: AppColors.splashGradient,
					),
					child: content,
				),
			),
		);
	}
}
