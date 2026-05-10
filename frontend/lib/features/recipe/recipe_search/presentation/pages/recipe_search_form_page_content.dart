import 'dart:io';

import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/core/presentation/widgets/key_board_listener.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/extensions/styled_recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_search/domain/payloads/search_recipe_list_payload.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_form_cubit.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_form_state.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_page_args.dart';
import 'package:flutter/material.dart' hide KeyboardListener;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

// --- Константы стиля ---
class AppColors {
  static const background = Color(0xFF180B06);
  static const surface = Color(0xFF2C1C16);
  static const accent = Color(0xFFE5C9A8);
  static const textPrimary = Color(0xFFFADCD2);
  static const textSecondary = Color(0xFFD1C4B9);
  static const chipBg = Color(0xFF43312A);
  static const buttonBg = Color(0xFFFFE6C9);
}

class RecipeSearchFormPageContent extends StatefulWidget {
  const RecipeSearchFormPageContent({super.key});

  @override
  State<RecipeSearchFormPageContent> createState() =>
      _RecipeSearchFormPageContentState();
}

class _RecipeSearchFormPageContentState
    extends State<RecipeSearchFormPageContent> {
bool _isShowKeyboard = false;

 final KeyboardListener _keyboardListener = KeyboardListener();

  // Links & Overlays
  final LayerLink _categoryLink = LayerLink();
  final LayerLink _ingredientLink = LayerLink();
  OverlayEntry? _activeOverlay;

  // Controllers & Nodes
  final nameController = TextEditingController();
  final _categoryFocus = FocusNode();
  final _ingredientFocus = FocusNode();

  // State
  final List<RecipeDifficulty> difficulties = RecipeDifficulty.values;
  int cookingTime = 45;
  int minCalories = 0, maxCalories = 4000;
  int minProteins = 0, maxProteins = 100;
  int minFats = 0, maxFats = 100;
  int minCarbs = 0, maxCarbs = 100;

  final List<CategoryEntity> selectedCategories = [];
  final List<IngredientEntity> selectedIngredients = [];

  @override
  void initState() {
    super.initState();
    _setupFocusListeners();
       _keyboardListener.addListener(onChange: (bool isVisible) {
     setState(() {
       
       if (_isShowKeyboard && !isVisible) {
        _closeOverlay();
       }
       _isShowKeyboard = isVisible;
     });
   });
  }

  void _setupFocusListeners() {
    _categoryFocus.addListener(() {
      if (_categoryFocus.hasFocus) {
        _showSearchOverlay(link: _categoryLink, isCategory: true);
      } else {
        _closeOverlay();
      }
    });

    _ingredientFocus.addListener(() {
      if (_ingredientFocus.hasFocus) {
        _showSearchOverlay(link: _ingredientLink, isCategory: false);
      } else {
        _closeOverlay();
      }
    });
  }

  void _closeOverlay() {
    _activeOverlay?.remove();
    _activeOverlay = null;
  }

  @override
  void dispose() {
    _keyboardListener.dispose();
    nameController.dispose();
    _categoryFocus.dispose();
    _ingredientFocus.dispose();
    _closeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: CustomScrollView(
        slivers: [
          _buildHeader(),
          const SliverToBoxAdapter(child: SizedBox(height: 17)),

          // Название
          SliverToBoxAdapter(
            child: _CustomTextField(
              controller: nameController,
              hintText: MyLocale.of(context).searchRecipeNameHint,
              prefixIcon: Icons.search,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 15)),

          // Сложность
          SliverToBoxAdapter(
            child: _DifficultySelector(
              selected: difficulties,
              onChanged: (d) => setState(
                () => difficulties.contains(d)
                    ? difficulties.remove(d)
                    : difficulties.add(d),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 28)),

          // Время
          SliverToBoxAdapter(
            child: _SliderHeader(
              title: MyLocale.of(context).searchCookingTimeTitle,
              valueText: MyLocale.of(
                context,
              ).searchCookingTimeUpTo(cookingTime),
              child: Slider(
                value: cookingTime.toDouble(),
                min: 10,
                max: 300,
                activeColor: const Color(0xFF615043),
                inactiveColor: const Color(0xFF615043),
                thumbColor: AppColors.buttonBg,
                onChanged: (v) => setState(() => cookingTime = v.toInt()),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 22)),

          // БЖУ и Калории
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MyLocale.of(context).searchNutritionGoals,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                _DoubleSlider(
                  label: MyLocale.of(context).searchCaloriesLabel,
                  unit: MyLocale.of(context).commonKcalShort,
                  min: 0,
                  max: 4000,
                  minValue: minCalories,
                  maxValue: maxCalories,
                  onValueChanged: (v1, v2) => setState(() {
                    minCalories = v1;
                    maxCalories = v2;
                  }),
                ),
                const SizedBox(height: 12),
                _DoubleSlider(
                  label: MyLocale.of(context).searchProteinsLabel,
                  unit: MyLocale.of(context).commonGramShort,
                  min: 0,
                  max: 100,
                  minValue: minProteins,
                  maxValue: maxProteins,
                  onValueChanged: (v1, v2) => setState(() {
                    minProteins = v1;
                    maxProteins = v2;
                  }),
                ),
                const SizedBox(height: 12),
                _DoubleSlider(
                  label: MyLocale.of(context).searchFatsLabel,
                  unit: MyLocale.of(context).commonGramShort,
                  min: 0,
                  max: 100,
                  minValue: minFats,
                  maxValue: maxFats,
                  onValueChanged: (v1, v2) => setState(() {
                    minFats = v1;
                    maxFats = v2;
                  }),
                ),
                const SizedBox(height: 12),
                _DoubleSlider(
                  label: MyLocale.of(context).searchCarbsLabel,
                  unit: MyLocale.of(context).commonGramShort,
                  min: 0,
                  max: 100,
                  minValue: minCarbs,
                  maxValue: maxCarbs,
                  onValueChanged: (v1, v2) => setState(() {
                    minCarbs = v1;
                    maxCarbs = v2;
                  }),
                ),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Категории
          _buildSearchSection(
            title: MyLocale.of(context).searchCategoriesTitle,
            hint: MyLocale.of(context).searchAddCategoryHint,
            link: _categoryLink,
            focusNode: _categoryFocus,
            items: selectedCategories,
            onSearch: (val) =>
                context.read<RecipeSearchFormCubit>().searchCategoryList(val),
            onRemove: (item) => setState(() => selectedCategories.remove(item)),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // Ингредиенты
          _buildSearchSection(
            title: MyLocale.of(context).searchIngredientsTitle,
            hint: MyLocale.of(context).searchAddIngredientHint,
            link: _ingredientLink,
            focusNode: _ingredientFocus,
            items: selectedIngredients,
            onSearch: (val) =>
                context.read<RecipeSearchFormCubit>().searchIngredientList(val),
            onRemove: (item) =>
                setState(() => selectedIngredients.remove(item)),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 28)),

          // Кнопка поиска
          SliverToBoxAdapter(child: _SearchButton(onPressed: _submitForm)),

          const SliverToBoxAdapter(child: SizedBox(height: 38)),
        ],
      ),
    );
  }

  // --- Вспомогательные методы построения ---

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        height: 60,
        child: Text(
          MyLocale.of(context).searchTitle,
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection({
    required String title,
    required String hint,
    required LayerLink link,
    required FocusNode focusNode,
    required List items,
    required Function(String) onSearch,
    required Function(dynamic) onRemove,
  }) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          CompositedTransformTarget(
            link: link,
            child: _CustomTextField(
              focusNode: focusNode,
              hintText: hint,
              onChanged: onSearch,
              fontSize: 14,
            ),
          ),
          if (items.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items
                  .map(
                    (e) => _SelectionChip(
                      label: e.name,
                      onRemove: () => onRemove(e),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  void _showSearchOverlay({required LayerLink link, required bool isCategory}) {
    final cubit = context.read<RecipeSearchFormCubit>();

    _activeOverlay = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 48,
        child: CompositedTransformFollower(
          link: link,
          offset: const Offset(0, 52),
          child: Material(
            // Чтобы работал GestureDetector и стили текста
            color: Colors.transparent,
            child: BlocProvider.value(
              value: cubit,
              child: BlocBuilder<RecipeSearchFormCubit, RecipeSearchFormState>(
                builder: (context, state) {
                  final list = isCategory
                      ? state.categories
                      : state.ingredients;
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                    child: list.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              MyLocale.of(context).searchNothingFound,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: list
                                .map(
                                  (item) => _buildOverlayItem(item, isCategory),
                                )
                                .toList(),
                          ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_activeOverlay!);
  }

  Widget _buildOverlayItem(dynamic item, bool isCategory) {
    final isSelected = isCategory
        ? selectedCategories.any((e) => e.id == item.id)
        : selectedIngredients.any((e) => e.id == item.id);

    return InkWell(
      onTap: () => setState(() {
        if (isCategory) {
          isSelected
              ? selectedCategories.removeWhere((e) => e.id == item.id)
              : selectedCategories.add(item);
        } else {
          isSelected
              ? selectedIngredients.removeWhere((e) => e.id == item.id)
              : selectedIngredients.add(item);
        }
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(
              item.name,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: AppColors.accent,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    context.push(
      '/search',
      extra: RecipeSearchPageArgs(
        payload: SearchRecipeListPayload(
          name: nameController.text,
          difficulties: difficulties,
          categories: selectedCategories,
          ingredients: selectedIngredients,
          maxCookingTime: cookingTime,
          minCarbohydrates: minCarbs,
          maxCarbohydrates: maxCarbs,
          minProteins: minProteins,
          maxProteins: maxProteins,
          minFats: minFats,
          maxFats: maxFats,
          minCalories: minCalories,
          maxCalories: maxCalories,
        ),
      ),
    );
  }
}

// --- Выделенные компоненты ---

class _CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final IconData? prefixIcon;
  final Function(String)? onChanged;
  final double fontSize;

  const _CustomTextField({
    this.controller,
    this.focusNode,
    required this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      cursorColor: AppColors.accent,
      style: TextStyle(color: AppColors.textSecondary, fontSize: fontSize),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textSecondary.withValues(alpha: 0.5),
          fontSize: fontSize,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.textSecondary)
            : null,
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent),
        ),
      ),
    );
  }
}

class _SelectionChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _SelectionChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.chipBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.buttonBg,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, color: AppColors.buttonBg, size: 14),
          ),
        ],
      ),
    );
  }
}

class _DifficultySelector extends StatelessWidget {
  final List<RecipeDifficulty> selected;
  final Function(RecipeDifficulty) onChanged;

  const _DifficultySelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: RecipeDifficulty.values.map((d) {
        final isSel = selected.contains(d);
        Color bgColor;
        switch (d) {
          case RecipeDifficulty.easy:
            bgColor = const Color(0xFF7FB069);
            break;
          case RecipeDifficulty.medium:
            bgColor = const Color(0xFFE8B86D);
            break;
          case RecipeDifficulty.hard:
            bgColor = const Color(0xFFE76F51);
            break;
        }
        return GestureDetector(
          onTap: () => onChanged(d),
          child: Container(
            width: 100,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSel ? bgColor : AppColors.chipBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              d.text(context),
              style: TextStyle(
                color: isSel
                    ? (d == RecipeDifficulty.hard ? Colors.white : Colors.black)
                    : AppColors.buttonBg,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SliderHeader extends StatelessWidget {
  final String title;
  final String valueText;
  final Widget child;

  const _SliderHeader({
    required this.title,
    required this.valueText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF37261F),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                valueText,
                style: const TextStyle(
                  color: AppColors.buttonBg,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        child,
      ],
    );
  }
}

class _DoubleSlider extends StatelessWidget {
  final String label, unit;
  final int min, max, minValue, maxValue;
  final Function(int, int) onValueChanged;

  const _DoubleSlider({
    required this.label,
    required this.unit,
    required this.min,
    required this.max,
    required this.minValue,
    required this.maxValue,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
            Text(
              '$minValue - $maxValue $unit',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 10,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: const SliderThemeData(
            thumbColor: AppColors.buttonBg,
            activeTrackColor: Color(0xFF615043),
            inactiveTrackColor: Color(0xFF615043),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: RangeSlider(
            values: RangeValues(minValue.toDouble(), maxValue.toDouble()),
            min: min.toDouble(),
            max: max.toDouble(),
            onChanged: (v) => onValueChanged(v.start.toInt(), v.end.toInt()),
          ),
        ),
      ],
    );
  }
}

class _SearchButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SearchButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonBg,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        MyLocale.of(context).searchButton,
        style: const TextStyle(
          color: Color(0xFF3E2D16),
          fontWeight: FontWeight.w800,
          letterSpacing: 1.6,
        ),
      ),
    );
  }
}

class ImagePickerSheet extends StatelessWidget {
  const ImagePickerSheet({super.key});

  /// Метод для вызова BottomSheet
  static Future<XFile?> show(BuildContext context) async {
    return await showModalBottomSheet<XFile?>(
      context: context,
      backgroundColor: Colors.transparent, // Для кастомного скругления
      isScrollControlled: true,
      builder: (context) => const ImagePickerSheet(),
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (context.mounted) {
        if (pickedFile != null) {
          Navigator.pop(context, pickedFile);
        } else {
          Navigator.pop(context, null);
        }
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      if (context.mounted) Navigator.pop(context, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Декоративный индикатор (Handle)
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.chipBg,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            "Выберите источник", // Можно заменить на MyLocale.of(context)...
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 24),
          
          _PickerOption(
            icon: Icons.camera_alt_rounded,
            label: "Камера",
            onTap: () => _pickImage(context, ImageSource.camera),
          ),
          
          const SizedBox(height: 12),
          
          _PickerOption(
            icon: Icons.photo_library_rounded,
            label: "Галерея",
            onTap: () => _pickImage(context, ImageSource.gallery),
          ),
          
          const SizedBox(height: 32), // Отступ снизу (safe area)
        ],
      ),
    );
  }
}

class _PickerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickerOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accent, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.chipBg,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}