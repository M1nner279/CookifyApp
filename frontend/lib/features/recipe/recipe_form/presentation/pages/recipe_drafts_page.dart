import 'package:cookify/core/presentation/widgets/cookify_navigation_bar.dart';
import 'package:cookify/features/recipe/recipe_form/domain/entities/draft_recipe_entity.dart';
import 'package:cookify/features/recipe/recipe_form/domain/repositories/draft_recipe_repository.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/pages/recipe_form_page_args.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class RecipeDraftsPage extends StatelessWidget {
  const RecipeDraftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = GetIt.I<DraftRecipeRepository>();

    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text(
                'Черновики',
                style: TextStyle(
                  color: Color(0xFFE5C9A8),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.push('/create');
                  },
                  icon: const Icon(Icons.add, color: Color(0xFFE5C9A8)),
                ),
              ],
              centerTitle: true,
              backgroundColor: const Color(0xFF1A0F0A),
              surfaceTintColor: const Color(0xFF1A0F0A),
            ),
            backgroundColor: const Color(0xFF1A0F0A),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 80.0,
                top: 12.0,
              ),
              child: ValueListenableBuilder<List<DraftRecipeEntity>>(
                valueListenable: repo.draftsListenable,
                builder: (context, drafts, _) {
                  if (drafts.isEmpty) {
                    return const Center(
                      child: Text(
                        'Пока нет черновиков',
                        style: TextStyle(color: Color(0xFFE5C9A8)),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: drafts.length,
                    separatorBuilder: (_, index) =>
                        const SizedBox(height: 10.0),
                    itemBuilder: (context, index) {
                      final draft = drafts[index];
                      return _DraftTile(
                        draft: draft,
                        onTap: () {
                          context.push(
                            '/create',
                            extra: RecipeFormPageArgs(draftId: draft.id),
                          );
                        },
                        onDelete: () async {
                          await repo.remove(draft.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CookifyNavigationBar(index: 2),
          ),
        ],
      ),
    );
  }
}

class _DraftTile extends StatelessWidget {
  const _DraftTile({
    required this.draft,
    required this.onTap,
    required this.onDelete,
  });

  final DraftRecipeEntity draft;
  final VoidCallback onTap;
  final Future<void> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    final title = draft.name.trim().isEmpty
        ? 'Без названия'
        : draft.name.trim();

    return Material(
      color: const Color(0xFF2C1C16),
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0x1AE5C9A8)),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFFE5C9A8),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Обновлено: ${_formatDateTime(draft.updatedAt)}',
                      style: const TextStyle(
                        color: Color(0x99E5C9A8),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: const Color(0xFF2C1C16),
                        title: const Text(
                          'Удалить черновик?',
                          style: TextStyle(color: Color(0xFFE5C9A8)),
                        ),
                        content: Text(
                          title,
                          style: const TextStyle(color: Color(0xFFE5C9A8)),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text(
                              'Отмена',
                              style: TextStyle(color: Color(0xFFE5C9A8)),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text(
                              'Удалить',
                              style: TextStyle(color: Color(0xFFE5C9A8)),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  if (confirmed == true) {
                    await onDelete();
                  }
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFE5C9A8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDateTime(DateTime dt) {
  final d = dt.toLocal();
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(d.day)}.${two(d.month)}.${d.year} ${two(d.hour)}:${two(d.minute)}';
}
