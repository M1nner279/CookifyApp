import 'package:cookify/config/theme/t.dart';
import 'package:cookify/feature/auth/presentation/widget/auth_button.dart';
import 'package:cookify/feature/auth/presentation/widget/auth_divider.dart';
import 'package:cookify/feature/auth/presentation/widget/auth_service_button.dart';
import 'package:cookify/feature/auth/presentation/widget/auth_tab_bar.dart';
import 'package:cookify/feature/auth/presentation/widget/auth_text_field.dart';
import 'package:cookify/feature/home/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginUnauthorizedContent extends StatefulWidget {
  const LoginUnauthorizedContent({super.key});

  @override
  State<LoginUnauthorizedContent> createState() =>
      _LoginUnauthorizedContentState();
}

class _LoginUnauthorizedContentState extends State<LoginUnauthorizedContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .symmetric(horizontal: 24.0),
      padding: const .all(32.0),
      decoration: BoxDecoration(
        color: T.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Column(
        children: [
          AuthTabBar(activeTab: AuthTab.login),

          const SizedBox(height: 40.0),

          AuthTextField(
            controller: TextEditingController(),
            label: 'ЛОГИН',
            hint: 'Ваш логин',
            isPassword: false,
          ),

          const SizedBox(height: 24.0),

          AuthTextField(
            controller: TextEditingController(),
            label: 'ПАРОЛЬ',
            hint: 'Ваш пароль',
            isPassword: true,
          ),

          const SizedBox(height: 24.0),

          AuthButton(
            onPressed: () {
              context.go(HomePage.fullRoute());
            },
            title: 'Войти',
          ),

          const SizedBox(height: 40.0),

          AuthDivider(),

          const SizedBox(height: 40.0),

          AuthServiceButton(onTap: () {}, imagePath: 'google'),
        ],
      ),
    );
  }
}
