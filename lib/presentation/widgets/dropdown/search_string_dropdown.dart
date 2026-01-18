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

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: _filteredOptions.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'No se encontraron resultados',
                        style: Theme.of(context).textTheme.bodyMedium,
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
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              border: index < _filteredOptions.length - 1
                                  ? Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).dividerColor,
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
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                  ),
                                ),
                                if (isSelected) Icon(Icons.check, size: 20),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: isSmallScreen ? 6 : 8, left: 4),
              child: Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            CompositedTransformTarget(
              link: _layerLink,
              child: TextFormField(
                controller: _searchController,
                focusNode: _focusNode,
                enabled: widget.enabled,
                validator: widget.validator,
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
                  prefixIcon: widget.icon != null
                      ? Icon(widget.icon, size: isSmallScreen ? 20 : 24)
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: isSmallScreen ? 24 : 28,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 12 : 16,
                    vertical: isSmallScreen ? 12 : 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
