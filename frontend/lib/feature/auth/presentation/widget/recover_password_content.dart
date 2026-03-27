import 'package:cookify/config/theme/t.dart';
import 'package:cookify/feature/auth/presentation/widget/auth_button.dart';
import 'package:cookify/feature/auth/presentation/widget/auth_tab_bar.dart';
import 'package:cookify/feature/auth/presentation/widget/auth_text_field.dart';
import 'package:cookify/feature/home/presentation/page/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RecoverPasswordContent extends StatelessWidget {
  const RecoverPasswordContent({super.key});

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
          AuthTabBar(activeTab: AuthTab.recover),

          const SizedBox(height: 40.0),

          AuthTextField(
            controller: TextEditingController(),
            label: 'EMAIL ИЛИ ЛОГИН',
            hint: 'Ваш email или логин',
            isPassword: false,
          ),

          const SizedBox(height: 24.0),

          Text(
            'Введите данные вашей учетной записи для получения инструкций по восстановлению пароля.',
            style: TextStyle(
              color: Color(0x881A0F0A),
              fontSize: 11.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0,
              height: 17.9 / 11.0,
            ),
          ),

          const SizedBox(height: 24.0),

          AuthButton(
            onPressed: () {
              context.go(HomePage.fullRoute());
            },
            title: 'Восстановить',
          ),
        ],
      ),
    );
  }
}
