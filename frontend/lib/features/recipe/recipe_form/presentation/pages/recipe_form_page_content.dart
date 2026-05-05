import 'dart:io';

import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/core/presentation/widgets/cookify_navigation_bar.dart';
import 'package:cookify/core/presentation/widgets/cookify_text_field.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_step_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/controllers/category_controller.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/controllers/ingredient_controller.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/controllers/photo_controller.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/extensions/styled_recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/widgets/category_text_field.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/widgets/ingredient_text_field.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/saved_recipe_repository.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/user_saved_recipe_detail_repository.dart';
import 'package:cookify/features/recipe/recipe_common/domain/user_saved_recipe_id.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';
import 'package:cookify/features/recipe/recipe_form/domain/payloads/publish_recipe_payload.dart';
import 'package:cookify/features/recipe/recipe_form/domain/entities/draft_recipe_entity.dart';
import 'package:cookify/features/recipe/recipe_form/domain/repositories/draft_recipe_repository.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/bloc/recipe_form_cubit.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/bloc/recipe_form_state.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/widgets/recipe_form_photo_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class RecipeFormPageContent extends StatefulWidget {
  const RecipeFormPageContent({super.key, this.draftId});

  final String? draftId;

  @override
  State<RecipeFormPageContent> createState() => _RecipeFormPageContentState();
}

class _RecipeFormPageContentState extends State<RecipeFormPageContent> {
  final photoController = PhotoController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final proteinsController = TextEditingController(text: '0');
  final fatsController = TextEditingController(text: '0');
  final carbsController = TextEditingController(text: '0');
  final caloriesController = TextEditingController(text: '0');
  final cookingTimeController = TextEditingController(text: '45');
  final categoryControllers = <CategoryController>[];
  final ingredientDrafts = <_IngredientDraft>[];
  final stepDrafts = <_StepDraft>[];

  RecipeDifficulty difficulty = RecipeDifficulty.easy;
  String? _draftId;
  bool _isSavingDraft = false;
  bool _isSavingToSaved = false;

  @override
  void initState() {
    super.initState();
    categoryControllers.add(CategoryController());
    ingredientDrafts.add(_IngredientDraft(controller: IngredientController()));
    stepDrafts.add(_StepDraft());
    photoController.addListener(_syncPhotos);
    proteinsController.addListener(() => _limitValue(proteinsController, 100));
    fatsController.addListener(() => _limitValue(fatsController, 100));
    carbsController.addListener(() => _limitValue(carbsController, 100));
    //caloriesController.addListener(() => _limitValue(caloriesController, 100));

    _draftId = widget.draftId;
    if (_draftId != null && _draftId!.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _loadDraft(_draftId!),
      );
    }
  }

  Future<void> _loadDraft(String id) async {
    final repo = GetIt.I<DraftRecipeRepository>();
    final draft = repo.getById(id);
    if (draft == null) return;

    setState(() {
      _draftId = draft.id;

      nameController.text = draft.name;
      descriptionController.text = draft.description;
      proteinsController.text = draft.cpfc.proteins.toString();
      fatsController.text = draft.cpfc.fats.toString();
      carbsController.text = draft.cpfc.carbohydrates.toString();
      caloriesController.text = draft.cpfc.calories.toString();
      cookingTimeController.text = draft.cookingTimeMinutes.toString();
      difficulty = draft.difficulty;

      photoController.clear();
      photoController.addAll(draft.photoPaths.map(XFile.new).toList());

      for (final c in categoryControllers) {
        c.controller.dispose();
      }
      categoryControllers
        ..clear()
        ..addAll(
          draft.categories.map((c) {
            final controller = CategoryController();
            controller.selectCategory(c);
            return controller;
          }),
        );
      if (categoryControllers.isEmpty) {
        categoryControllers.add(CategoryController());
      }

      for (final i in ingredientDrafts) {
        i.dispose();
      }
      ingredientDrafts
        ..clear()
        ..addAll(
          draft.ingredients.map((i) {
            final controller = IngredientController();
            controller.selectIngredient(i.ingredient);
            final d = _IngredientDraft(controller: controller);
            d.amountController.text = i.amount == 0 ? '' : i.amount.toString();
            d.unitController.text = i.unit;
            return d;
          }),
        );
      if (ingredientDrafts.isEmpty) {
        ingredientDrafts.add(
          _IngredientDraft(controller: IngredientController()),
        );
      }

      for (final s in stepDrafts) {
        s.dispose();
      }
      stepDrafts
        ..clear()
        ..addAll(
          draft.steps.map((s) {
            final d = _StepDraft();
            d.titleController.text = s.title;
            d.descriptionController.text = s.description;
            d.photo = s.photoPath == null ? null : XFile(s.photoPath!);
            return d;
          }),
        );
      if (stepDrafts.isEmpty) {
        stepDrafts.add(_StepDraft());
      }
    });

    if (mounted) {
      context.read<RecipeFormCubit>().onPhotosChanged(photoController.photos);
    }
  }

  void _limitValue(TextEditingController controller, int limit) {
    final text = controller.text;
    if (text.isNotEmpty) {
      final value = int.tryParse(text) ?? 0;
      if (value > limit) {
        controller.text = limit.toString();
      }
    }
  }

  @override
  void dispose() {
    photoController.removeListener(_syncPhotos);
    photoController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    proteinsController.dispose();
    fatsController.dispose();
    carbsController.dispose();
    caloriesController.dispose();
    cookingTimeController.dispose();

    for (final category in categoryControllers) {
      category.controller.dispose();
    }
    for (final ingredient in ingredientDrafts) {
      ingredient.dispose();
    }
    for (final step in stepDrafts) {
      step.dispose();
    }
    super.dispose();
  }

  void _syncPhotos() {
    context.read<RecipeFormCubit>().onPhotosChanged(photoController.photos);
  }

  int _toInt(TextEditingController controller) {
    return int.tryParse(controller.text) ?? 0;
  }

  Future<DraftRecipeEntity> _upsertCurrentDraft() async {
    final repo = GetIt.I<DraftRecipeRepository>();

    final categoriesEntities = categoryControllers
        .map((controller) => controller.category)
        .whereType<CategoryEntity>()
        .toList();

    final ingredients = ingredientDrafts
        .where((draft) => draft.controller.ingredient != null)
        .map(
          (draft) => DraftRecipeIngredientEntity(
            ingredient: draft.controller.ingredient!,
            amount: double.tryParse(draft.amountController.text) ?? 0,
            unit: draft.unitController.text.trim().isEmpty
                ? 'g'
                : draft.unitController.text.trim(),
          ),
        )
        .toList();

    final steps = stepDrafts
        .where(
          (step) =>
              step.titleController.text.trim().isNotEmpty ||
              step.descriptionController.text.trim().isNotEmpty ||
              step.photo != null,
        )
        .map(
          (step) => DraftRecipeStepEntity(
            title: step.titleController.text.trim(),
            description: step.descriptionController.text.trim(),
            photoPath: step.photo?.path,
          ),
        )
        .toList();

    final draft = DraftRecipeEntity(
      id: _draftId ?? '',
      updatedAt: DateTime.now(),
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      cpfc: CpfcEntity(
        calories: _toInt(caloriesController),
        proteins: _toInt(proteinsController),
        fats: _toInt(fatsController),
        carbohydrates: _toInt(carbsController),
      ),
      difficulty: difficulty,
      cookingTimeMinutes: _toInt(cookingTimeController),
      categories: categoriesEntities,
      ingredients: ingredients,
      steps: steps,
      photoPaths: photoController.photos.map((p) => p.path).toList(),
    );

    return repo.upsert(draft);
  }

  Future<void> _saveDraft() async {
    if (_isSavingDraft) return;
    setState(() => _isSavingDraft = true);

    try {
      final saved = await _upsertCurrentDraft();
      _draftId = saved.id;

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Черновик сохранён')));
    } finally {
      if (mounted) {
        setState(() => _isSavingDraft = false);
      }
    }
  }

  RecipeDetailEntity _buildRecipeDetailEntity(String id) {
    final categoriesEntities = categoryControllers
        .map((controller) => controller.category)
        .whereType<CategoryEntity>()
        .toList();

    final ingredients = ingredientDrafts
        .where((draft) => draft.controller.ingredient != null)
        .where((draft) => draft.amountController.text.trim().isNotEmpty)
        .where((draft) => draft.unitController.text.trim().isNotEmpty)
        .map(
          (draft) => RecipeIngredientEntity(
            name: draft.controller.ingredient!.name,
            amount: double.tryParse(draft.amountController.text) ?? 0,
            unit: draft.unitController.text.trim(),
            cpfc: draft.controller.ingredient!.cpfc,
          ),
        )
        .toList();

    final steps = stepDrafts
        .asMap()
        .entries
        .where((entry) => entry.value.titleController.text.trim().isNotEmpty)
        .where(
          (entry) => entry.value.descriptionController.text.trim().isNotEmpty,
        )
        .map(
          (entry) => RecipeStepEntity(
            id: '${entry.key + 1}',
            name: entry.value.titleController.text.trim(),
            description: entry.value.descriptionController.text.trim(),
            photoUrl: entry.value.photo?.path,
          ),
        )
        .toList();

    return RecipeDetailEntity(
      id: id,
      creator: null,
      photoUrls: photoController.photos.map((p) => p.path).toList(),
      name: nameController.text.trim(),
      difficulty: difficulty,
      categories: categoriesEntities,
      cookingTime: _toInt(cookingTimeController),
      cpfc: CpfcEntity(
        calories: _toInt(caloriesController),
        proteins: _toInt(proteinsController),
        fats: _toInt(fatsController),
        carbohydrates: _toInt(carbsController),
      ),
      description: descriptionController.text.trim(),
      servingCount: 1,
      ingredients: ingredients,
      steps: steps,
    );
  }

  Future<void> _saveToMyRecipes() async {
    if (!_validateBeforePublish()) return;
    if (_isSavingToSaved || _isSavingDraft) return;
    setState(() => _isSavingToSaved = true);
    try {
      final draft = await _upsertCurrentDraft();
      _draftId = draft.id;

      final userSavedId = UserSavedRecipeId.fromDraft(draft.id);
      final detail = _buildRecipeDetailEntity(userSavedId);

      final photoPath =
          detail.photoUrls.isNotEmpty ? detail.photoUrls.first : '';

      final preview = RecipePreviewEntity(
        id: userSavedId,
        photoUrl: photoPath,
        name: detail.name,
        cookingTime: detail.cookingTime,
        servingCount: detail.servingCount.round(),
        difficulty: detail.difficulty,
        categories: detail.categories.map((c) => c.name).toList(),
      );

      await GetIt.I<SavedRecipeRepository>().saveRecipe(preview);
      await GetIt.I<UserSavedRecipeDetailRepository>().save(userSavedId, detail);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Рецепт добавлен в сохранённые')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSavingToSaved = false);
      }
    }
  }

  bool _validateBeforePublish() {
    final validCategories = categoryControllers
        .map((controller) => controller.category)
        .whereType<CategoryEntity>()
        .toList();
    final validIngredients = ingredientDrafts
        .where((draft) => draft.controller.ingredient != null)
        .where((draft) => draft.amountController.text.trim().isNotEmpty)
        .where((draft) => draft.unitController.text.trim().isNotEmpty)
        .toList();
    final validSteps = stepDrafts
        .where((step) => step.titleController.text.trim().isNotEmpty)
        .where((step) => step.descriptionController.text.trim().isNotEmpty)
        .toList();

    final isValid =
        nameController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        photoController.photos.isNotEmpty &&
        validCategories.isNotEmpty &&
        validIngredients.isNotEmpty &&
        validSteps.isNotEmpty &&
        _toInt(cookingTimeController) > 0;

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Заполните обязательные поля: фото, название, описание, категории, ингредиенты и шаги.',
          ),
        ),
      );
    }

    return isValid;
  }

  Future<void> _publish() async {
    if (!_validateBeforePublish()) {
      return;
    }

    final cubit = context.read<RecipeFormCubit>();

    final categoriesEntities = categoryControllers
        .map((controller) => controller.category)
        .whereType<CategoryEntity>()
        .toList();

    final ingredients = ingredientDrafts
        .where((draft) => draft.controller.ingredient != null)
        .map(
          (draft) => RecipeIngredientEntity(
            name: draft.controller.ingredient!.name,
            amount: double.tryParse(draft.amountController.text) ?? 0,
            unit: draft.unitController.text.trim(),
            cpfc: draft.controller.ingredient!.cpfc,
          ),
        )
        .toList();

    final steps = stepDrafts
        .asMap()
        .entries
        .where((entry) => entry.value.titleController.text.trim().isNotEmpty)
        .where(
          (entry) => entry.value.descriptionController.text.trim().isNotEmpty,
        )
        .map(
          (entry) => RecipeStepEntity(
            id: '${entry.key + 1}',
            name: entry.value.titleController.text.trim(),
            description: entry.value.descriptionController.text.trim(),
            photoUrl: entry.value.photo?.path,
          ),
        )
        .toList();

    cubit
      ..onNameChanged(nameController.text.trim())
      ..onDescriptionChanged(descriptionController.text.trim())
      ..onCpfcChanged(
        proteins: _toInt(proteinsController),
        fats: _toInt(fatsController),
        carbs: _toInt(carbsController),
        calories: _toInt(caloriesController),
      )
      ..onDifficultyChanged(difficulty)
      ..onCookingTimeChanged(_toInt(cookingTimeController))
      ..onCategoriesChanged(categoriesEntities)
      ..onIngredientsChanged(ingredients)
      ..onStepsChanged(steps);

    final result = await cubit.publishRecipe(
      PublishRecipePayload(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        calories: _toInt(caloriesController),
        proteins: _toInt(proteinsController),
        fats: _toInt(fatsController),
        carbohydrates: _toInt(carbsController),
        difficulty: difficulty.name,
        cookingTimeMinutes: _toInt(cookingTimeController),
        categories: categoriesEntities.map((category) => category.id).toList(),
        ingredients: ingredientDrafts
            .where((draft) => draft.controller.ingredient != null)
            .map(
              (draft) => PublishRecipeIngredientPayload(
                id: draft.controller.ingredient!.id,
                amount: double.tryParse(draft.amountController.text) ?? 0,
                unit: draft.unitController.text.trim(),
              ),
            )
            .toList(),
        steps: stepDrafts
            .where((step) => step.titleController.text.trim().isNotEmpty)
            .where((step) => step.descriptionController.text.trim().isNotEmpty)
            .map(
              (step) => PublishRecipeStepPayload(
                title: step.titleController.text.trim(),
                description: step.descriptionController.text.trim(),
                photoPath: step.photo?.path,
              ),
            )
            .toList(),
        photos: photoController.photos,
      ),
    );

    if (!mounted) return;
    switch (result) {
      case Success():
        final draftId = _draftId;
        if (draftId != null && draftId.trim().isNotEmpty) {
          final savedRepo = GetIt.I<SavedRecipeRepository>();
          final userSavedId = UserSavedRecipeId.fromDraft(draftId);
          if (savedRepo.isSaved(userSavedId)) {
            await savedRepo.removeRecipe(userSavedId);
          }
          await GetIt.I<DraftRecipeRepository>().remove(draftId);
        }
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Рецепт опубликован')));
        context.go('/');
        break;
      case Failure():
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не удалось опубликовать рецепт')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back, color: Color(0xFFE5C9A8)),
          ),
          title: const Text(
            'Создание рецепта',
            style: TextStyle(
              color: Color(0xFFE5C9A8),
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF1A0F0A),
          surfaceTintColor: const Color(0xFF1A0F0A),
        ),
        backgroundColor: const Color(0xFF1A0F0A),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BlocBuilder<RecipeFormCubit, RecipeFormState>(
                  builder: (context, state) {
                    return ListView(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      children: [
                        RecipeFormPhotoField(controller: photoController),
                        const SizedBox(height: 16.0),
                        CookifyTextField(
                          controller: nameController,
                          label: 'НАЗВАНИЕ РЕЦЕПТА',
                          hint: 'Название вашего шедевра',
                          maxLength: 80,
                        ),
                        const SizedBox(height: 12.0),
                        CookifyTextField(
                          controller: descriptionController,
                          label: 'ОПИСАНИЕ',
                          hint: 'Расскажите нам почему это вкусно...',
                          maxLines: 3,
                          maxLength: 300,
                        ),
                        const SizedBox(height: 16.0),
                        const _SectionLabel('КБЖУ'),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            _MetricField(
                              label: 'БЕЛ',
                              controller: proteinsController,
                            ),
                            const SizedBox(width: 8.0),
                            _MetricField(
                              label: 'ЖИР',
                              controller: fatsController,
                            ),
                            const SizedBox(width: 8.0),
                            _MetricField(
                              label: 'УГЛ',
                              controller: carbsController,
                            ),
                            const SizedBox(width: 8.0),
                            _MetricField(
                              label: 'КАЛОРИИ',
                              controller: caloriesController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        const _SectionLabel('СЛОЖНОСТЬ'),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            _DifficultyChip(
                              label: 'ЛЕГКО',
                              isSelected: difficulty == RecipeDifficulty.easy,
                              onTap: () => setState(
                                () => difficulty = RecipeDifficulty.easy,
                              ),
                              difficulty: RecipeDifficulty.easy,
                            ),
                            const SizedBox(width: 8.0),
                            _DifficultyChip(
                              label: 'СРЕДНЕ',
                              isSelected: difficulty == RecipeDifficulty.medium,
                              onTap: () => setState(
                                () => difficulty = RecipeDifficulty.medium,
                              ),
                              difficulty: RecipeDifficulty.medium,
                            ),
                            const SizedBox(width: 8.0),
                            _DifficultyChip(
                              label: 'СЛОЖНО',
                              isSelected: difficulty == RecipeDifficulty.hard,
                              onTap: () => setState(
                                () => difficulty = RecipeDifficulty.hard,
                              ),
                              difficulty: RecipeDifficulty.hard,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        CookifyTextField(
                          controller: cookingTimeController,
                          label: 'ВРЕМЯ ПРИГОТОВЛЕНИЯ',
                          hint: '45 минут',
                          inputType: TextInputType.number,
                          inputFormatter:
                              FilteringTextInputFormatter.digitsOnly,
                          maxLength: 3,
                        ),
                        const SizedBox(height: 20.0),
                        const _SectionLabel('КАТЕГОРИИ'),
                        const SizedBox(height: 8.0),
                        ...List.generate(
                          categoryControllers.length,
                          (i) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: CategoryTextField(
                              key: ObjectKey(categoryControllers[i]),
                              controller: categoryControllers[i],
                              categories: state.searchedCategories,
                              onChanged: context
                                  .read<RecipeFormCubit>()
                                  .searchCategoryList,
                              onDelete: () {
                                setState(() {
                                  categoryControllers
                                      .removeAt(i)
                                      .controller
                                      .dispose();
                                });
                              },
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              categoryControllers.add(CategoryController());
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Color(0xFFE5C9A8),
                          ),
                          label: const Text(
                            'Добавить категорию',
                            style: TextStyle(color: Color(0xFFE5C9A8)),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const _SectionLabel('ИНГРЕДИЕНТЫ'),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  ingredientDrafts.add(
                                    _IngredientDraft(
                                      controller: IngredientController(),
                                    ),
                                  );
                                });
                              },
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: Color(0xFFE5C9A8),
                              ),
                              label: const Text(
                                'ADD',
                                style: TextStyle(color: Color(0xFFE5C9A8)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        ...ingredientDrafts.asMap().entries.map((entry) {
                          final index = entry.key;
                          final draft = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: IngredientTextField(
                                    controller: draft.controller,
                                    ingredients: state.searchedIngredients,
                                    onChanged: context
                                        .read<RecipeFormCubit>()
                                        .searchIngredientList,
                                    onDelete: () {
                                      setState(() {
                                        ingredientDrafts
                                            .removeAt(index)
                                            .dispose();
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                SizedBox(
                                  width: 84.0,
                                  child: _MiniTextField(
                                    controller: draft.amountController,
                                    hint: '100',
                                    inputType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d{0,2}$'),
                                      ),
                                      LengthLimitingTextInputFormatter(6),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                SizedBox(
                                  width: 74.0,
                                  child: _MiniTextField(
                                    controller: draft.unitController,
                                    hint: 'g',
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Zа-яА-Я]'),
                                      ),
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 20.0),
                        const _SectionLabel('ШАГИ ПРИГОТОВЛЕНИЯ'),
                        const SizedBox(height: 8.0),
                        ...stepDrafts.asMap().entries.map((entry) {
                          final index = entry.key;
                          final step = entry.value;
                          return _StepCard(
                            index: index + 1,
                            draft: step,
                            canDelete: stepDrafts.length > 1,
                            onPhotoTap: () async {
                              await step.pickPhoto();
                              if (context.mounted) {
                                setState(() {});
                              }
                            },
                            onDelete: () {
                              setState(() {
                                stepDrafts.removeAt(index).dispose();
                              });
                            },
                          );
                        }),
                        const SizedBox(height: 8.0),
                        OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              stepDrafts.add(_StepDraft());
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFE5C9A8),
                            side: const BorderSide(color: Color(0x1AE5C9A8)),
                            minimumSize: const Size.fromHeight(52.0),
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text('ДОБАВИТЬ ШАГ'),
                        ),
                        const SizedBox(height: 18.0),
                        SizedBox(
                          height: 52.0,
                          child: OutlinedButton(
                            onPressed:
                                _isSavingDraft ||
                                    _isSavingToSaved ||
                                    state.isPublishing
                                ? null
                                : _saveDraft,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFE5C9A8),
                              side: const BorderSide(color: Color(0x1AE5C9A8)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            child: Text(
                              _isSavingDraft
                                  ? 'Сохранение...'
                                  : 'Сохранить черновик',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 52.0,
                          child: OutlinedButton(
                            onPressed:
                                _isSavingDraft ||
                                    _isSavingToSaved ||
                                    state.isPublishing
                                ? null
                                : _saveToMyRecipes,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFE5C9A8),
                              side: const BorderSide(color: Color(0x1AE5C9A8)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            child: Text(
                              _isSavingToSaved
                                  ? 'Сохранение...'
                                  : 'В сохранённые',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 56.0,
                          child: ElevatedButton(
                            onPressed: state.isPublishing ||
                                    _isSavingDraft ||
                                    _isSavingToSaved
                                ? null
                                : _publish,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE5C9A8),
                              foregroundColor: const Color(0xFF1A0F0A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            child: Text(
                              state.isPublishing
                                  ? 'Публикация...'
                                  : 'Опубликовать рецепт',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CookifyNavigationBar(index: 2),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        color: Color(0x80FFE6C9),
        fontSize: 10.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _MetricField extends StatelessWidget {
  const _MetricField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: const Color(0x1AE5C9A8),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: const Color(0x1AE5C9A8)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(color: Color(0x66E5C9A8), fontSize: 10.0),
            ),
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              style: const TextStyle(color: Color(0xFFFFE6C9)),
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.difficulty,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final RecipeDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? difficulty.color() : const Color(0x1AE5C9A8),
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0x99E5C9A8),

              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniTextField extends StatelessWidget {
  const _MiniTextField({
    required this.controller,
    required this.hint,
    this.inputType,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      inputFormatters: inputFormatters,
      style: const TextStyle(color: Color(0xFFFFE6C9), fontSize: 13.0),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0x4DE5C9A8), fontSize: 13.0),
        filled: true,
        fillColor: const Color(0x1AE5C9A8),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 10.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0x1AE5C9A8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0x1AE5C9A8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0x33E5C9A8)),
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.index,
    required this.draft,
    required this.canDelete,
    required this.onPhotoTap,
    required this.onDelete,
  });

  final int index;
  final _StepDraft draft;
  final bool canDelete;
  final Future<void> Function() onPhotoTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0x12000000),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0x1AE5C9A8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5C9A8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Color(0xFF1A0F0A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              if (canDelete)
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0x99E5C9A8),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          _MiniTextField(
            controller: draft.titleController,
            hint: 'Заголовок шага',
            inputFormatters: [LengthLimitingTextInputFormatter(80)],
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: draft.descriptionController,
            maxLines: 3,
            maxLength: 260,
            style: const TextStyle(color: Color(0xFFFFE6C9), fontSize: 13.0),
            decoration: InputDecoration(
              hintText: 'Описание шага',
              hintStyle: const TextStyle(
                color: Color(0x4DE5C9A8),
                fontSize: 13.0,
              ),
              filled: true,
              fillColor: const Color(0x1AE5C9A8),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0x1AE5C9A8)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0x1AE5C9A8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0x33E5C9A8)),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: onPhotoTap,
            child: Container(
              height: 120.0,
              decoration: BoxDecoration(
                color: const Color(0x1AE5C9A8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: draft.photo == null
                  ? const Center(
                      child: Text(
                        'Добавить фото',
                        style: TextStyle(color: Color(0x99E5C9A8)),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.file(
                        File(draft.photo!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientDraft {
  _IngredientDraft({required this.controller})
    : amountController = TextEditingController(),
      unitController = TextEditingController(text: 'g');

  final IngredientController controller;
  final TextEditingController amountController;
  final TextEditingController unitController;

  void dispose() {
    controller.controller.dispose();
    amountController.dispose();
    unitController.dispose();
  }
}

class _StepDraft {
  _StepDraft()
    : titleController = TextEditingController(),
      descriptionController = TextEditingController();

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final ImagePicker picker = ImagePicker();
  XFile? photo;

  Future<void> pickPhoto() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      photo = picked;
    }
  }

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }
}
