String? notEmptyValidator(String? value, String label) =>
    value == null || value.isEmpty ? 'Enter your $label' : null;
