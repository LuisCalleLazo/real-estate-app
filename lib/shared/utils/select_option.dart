class SelectOption {
  final String label;
  final String value;

  SelectOption({required this.label, required this.value});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SelectOption && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
