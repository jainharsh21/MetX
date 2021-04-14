String emailValidator(String value) {
  if (value.trim().isEmpty) return '*Required';
  if (!value.contains("@vit.edu.in"))
    return '*Enter a valid email';
  else
    return null;
}

String passwordValidator(String value) {
  return value.length < 6 ? "*Value Should Be Greater Than 6" : null;
}

String requiredValidator(String value) {
  return value.isEmpty ? "*Required" : null;
}
