import 'package:cookify/di/di.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_bottom.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_top.dart';
import 'package:cookify/features/profile/di/profile_di.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  final ipController = TextEditingController();

  @override
  void dispose() {
    ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 48.0,
                      children: [
                        const AuthTop(),

                        Container(
                          padding: const EdgeInsets.all(32.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C1C16),
                            border: Border.all(color: const Color(0x1AE5C9A8)),
                            borderRadius: BorderRadius.circular(48.0),
                          ),
                          child: Column(
                            spacing: 24.0,
                            children: [
                              Text(
                                'Подключение к серверу',
                                style: const TextStyle(
                                  color: Color(0x80FFE6C9),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  height: 30.0 / 20.0,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              AuthTextField(
                                controller: ipController,
                                onChanged: (value) {},
                                inputType: TextInputType.visiblePassword,
                                label: 'IP адрес',
                                hint: 'Введите IP адрес сервера',
                                isPassword: false,
                              ),

                              AuthButton(
                                onPressed: () async {
                                  await Di.init('${ipController.text}:5022');
                                  final user = await ProfileDi.getUserUseCase();
                                  user.fold(
                                    (_) => context.go('/auth'),
                                    (_) => context.go('/'),
                                  );
                                },
                                title: 'Подключиться',
                                isLoading: false,
                              ),
                            ],
                          ),
                        ),

                        const AuthBottom(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        backgroundColor: Color(0xFF1A0F0A),
      ),
    );
  }
}
