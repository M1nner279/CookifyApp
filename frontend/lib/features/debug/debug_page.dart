import 'package:cookify/core/presentation/widgets/cookify_loading_content.dart';
import 'package:cookify/di/di.dart';
import 'package:cookify/features/profile/di/profile_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await Di.init('cookify.site');
      final user = await ProfileDi.getUserUseCase();
      user.fold((_) => context.go('/auth'), (_) => context.go('/'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CookifyLoadingContent(),
        backgroundColor: Color(0xFF1A0F0A),
      ),
    );
  }
}
