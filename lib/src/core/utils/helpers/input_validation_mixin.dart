mixin InputValidationMixin {
  bool isPhoneValid(String? value) =>
      (((value?.length ?? 0) > 9) && num.tryParse(value ?? '') != null);

  bool isNameValid(String? value,{int length=3}) => ((value ?? '').length >= length);

  bool isPasswordValid(String? value) => ((value ?? '').length >= 8);
}
