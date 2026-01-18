import 'package:flutter/material.dart';

class SearchStringDropdown extends StatefulWidget {
  final String label;
  final IconData? icon;
  final List<String> options;
  final String? selectedValue;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;
  final String? placeholder;
  final bool enabled;

  const SearchStringDropdown({
    super.key,
    required this.label,
    this.icon,
    required this.options,
    this.selectedValue,
    required this.onChanged,
    this.validator,
    this.placeholder,
    this.enabled = true,
  });

  @override
  State<SearchStringDropdown> createState() => _SearchStringDropdownState();
}

class _SearchStringDropdownState extends State<SearchStringDropdown> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<String> _filteredOptions = [];
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
    if (widget.selectedValue != null) {
      _searchController.text = widget.selectedValue!;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOpen = false;
  }

  void _createOverlay() {
    if (_overlayEntry != null) return;

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 8,
            shadowColor: isDark
                ? Colors.black.withOpacity(0.6)
                : Colors.black.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF3A3A3A)
                      : const Color(0xFFE0E0E0),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: _filteredOptions.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'No se encontraron resultados',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: isDark
                                    ? const Color(0xFF6B6B6B)
                                    : const Color(0xFF9E9E9E),
                              ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: _filteredOptions.length,
                        itemBuilder: (context, index) {
                          final option = _filteredOptions[index];
                          final isSelected = option == widget.selectedValue;

                          return InkWell(
                            onTap: () {
                              _selectOption(option);
                            },
                            borderRadius: BorderRadius.vertical(
                              top: index == 0
                                  ? const Radius.circular(12)
                                  : Radius.zero,
                              bottom: index == _filteredOptions.length - 1
                                  ? const Radius.circular(12)
                                  : Radius.zero,
                            ),
                            hoverColor: isDark
                                ? const Color(0xFFF38118).withOpacity(0.1)
                                : const Color(0xFFFFE5D4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? (isDark
                                          ? const Color(
                                              0xFFF38118,
                                            ).withOpacity(0.15)
                                          : const Color(0xFFFFE5D4))
                                    : Colors.transparent,
                                border: index < _filteredOptions.length - 1
                                    ? Border(
                                        bottom: BorderSide(
                                          color: isDark
                                              ? const Color(0xFF3A3A3A)
                                              : const Color(0xFFF0F0F0),
                                          width: 0.5,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: isSelected
                                                ? const Color(0xFFF38118)
                                                : (isDark
                                                      ? const Color(0xFFF2F2F2)
                                                      : const Color(
                                                          0xFF1E191E,
                                                        )),
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check_circle,
                                      size: 20,
                                      color: Color(0xFFF38118),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    _isOpen = true;
  }

  void _selectOption(String option) {
    _searchController.text = option;
    widget.onChanged(option);
    _removeOverlay();
    _focusNode.unfocus();
  }

  void _filterOptions(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredOptions = widget.options;
      } else {
        _filteredOptions = widget.options
            .where(
              (option) => option.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });

    if (_isOpen) {
      _removeOverlay();
      _createOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 4 : 8,
            vertical: isSmallScreen ? 4 : 6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: isSmallScreen ? 6 : 8,
                  left: 4,
                ),
                child: Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isDark
                        ? const Color(0xFFE5E5E5)
                        : const Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CompositedTransformTarget(
                link: _layerLink,
                child: TextFormField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  validator: widget.validator,
                  style: TextStyle(
                    color: isDark
                        ? const Color(0xFFF2F2F2)
                        : const Color(0xFF1E191E),
                  ),
                  onTap: () {
                    if (!_isOpen && widget.enabled) {
                      _filterOptions(_searchController.text);
                      _createOverlay();
                    }
                  },
                  onChanged: (value) {
                    _filterOptions(value);
                    if (!_isOpen) {
                      _createOverlay();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: widget.placeholder ?? 'Buscar...',
                    hintStyle: TextStyle(
                      color: isDark
                          ? const Color(0xFF6B6B6B)
                          : const Color(0xFFAAAAAA),
                    ),
                    prefixIcon: widget.icon != null
                        ? Icon(
                            widget.icon,
                            size: isSmallScreen ? 20 : 24,
                            color: isDark
                                ? const Color(0xFFF38118)
                                : const Color(0xFFD66F0D),
                          )
                        : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        size: isSmallScreen ? 24 : 28,
                        color: isDark
                            ? const Color(0xFFF38118)
                            : const Color(0xFFD66F0D),
                      ),
                      onPressed: widget.enabled
                          ? () {
                              if (_isOpen) {
                                _removeOverlay();
                                _focusNode.unfocus();
                              } else {
                                _focusNode.requestFocus();
                                _filterOptions(_searchController.text);
                                _createOverlay();
                              }
                            }
                          : null,
                    ),
                    filled: true,
                    fillColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        isSmallScreen ? 8 : 12,
                      ),
                      borderSide: BorderSide(
                        color: isDark
                            ? const Color(0xFF3A3A3A)
                            : const Color(0xFFE0E0E0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        isSmallScreen ? 8 : 12,
                      ),
                      borderSide: BorderSide(
                        color: isDark
                            ? const Color(0xFF3A3A3A)
                            : const Color(0xFFE0E0E0),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        isSmallScreen ? 8 : 12,
                      ),
                      borderSide: const BorderSide(
                        color: Color(0xFFF38118),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        isSmallScreen ? 8 : 12,
                      ),
                      borderSide: const BorderSide(
                        color: Color(0xFFEF4444),
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        isSmallScreen ? 8 : 12,
                      ),
                      borderSide: const BorderSide(
                        color: Color(0xFFEF4444),
                        width: 2,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        isSmallScreen ? 8 : 12,
                      ),
                      borderSide: BorderSide(
                        color: isDark
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFFF0F0F0),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 14 : 18,
                      vertical: isSmallScreen ? 14 : 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
