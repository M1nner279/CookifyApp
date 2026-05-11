import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/core/presentation/widgets/cookify_text_field.dart';
import 'package:cookify/core/presentation/widgets/key_board_listener.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/controllers/category_controller.dart';
import 'package:flutter/material.dart' hide KeyboardListener;

class CategoryTextField extends StatefulWidget {
  const CategoryTextField({
    super.key,
    required this.controller,
    required this.categories,
    required this.onChanged,
    required this.onDelete,
  });

  final CategoryController controller;
  final List<CategoryEntity> categories;
  final void Function(String) onChanged;
  final VoidCallback onDelete;

  @override
  State<CategoryTextField> createState() => _CategoryTextFieldState();
}

class _CategoryTextFieldState extends State<CategoryTextField> {
  bool _isShowKeyboard = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  static const double _menuHeight = 80.0;

     final KeyboardListener _keyboardListener = KeyboardListener();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
        _keyboardListener.addListener(onChange: (bool isVisible) {
     setState(() {
       if (_isShowKeyboard && !isVisible) {
        _hideOverlay();
       }
       _isShowKeyboard = isVisible;
     });
   });
  }

  @override
  void didUpdateWidget(CategoryTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_overlayEntry != null && _focusNode.hasFocus) {
      // Откладываем обновление выпадающего списка до конца текущего кадра
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _updateOverlay();
        }
      });
    }
  }

  @override
  void dispose() {
        _keyboardListener.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _textController.dispose();
    _hideOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(builder: (context) => _buildOverlayContent());

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateOverlay() {
    if (_overlayEntry != null && _focusNode.hasFocus) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  Widget _buildOverlayContent() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size fieldSize = renderBox.size;

    return Positioned(
      width: fieldSize.width,
      child: CompositedTransformFollower(
        link: _layerLink,
        showWhenUnlinked: false,
        offset: Offset(0, fieldSize.height + 4),
        child: Material(
          elevation: 4,
          color: const Color(0xFF2C1C16),
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: _menuHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildCategoryList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    final filteredCategories = widget.categories;

    if (filteredCategories.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            MyLocale.of(context).searchCategoryNotFound,
            style: const TextStyle(color: Color(0xFFE5C9A8)),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: filteredCategories.length,
      separatorBuilder: (context, index) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final category = filteredCategories[index];
        return ListTile(
          title: Text(
            category.name,
            style: const TextStyle(color: Color(0xFFE5C9A8), fontSize: 14),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          dense: true,
          onTap: () {
            _textController.text = category.name;
            widget.controller.selectCategory(category);
            _focusNode.unfocus();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Row(
        children: [
          Expanded(
            child: CookifyTextField(
              controller: _textController,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              hint: MyLocale.of(context).searchCategoryHint,
            ),
          ),
          GestureDetector(
            onTap: widget.onDelete,
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xFFE5C9A8),
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
