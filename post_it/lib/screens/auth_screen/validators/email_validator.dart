String? emailValidator(String? email) {
  if (email == null || email == '') {
    return 'É necessário email';
  }
  if (!email.contains('@')) {
    return 'O email digitado não é valido';
  }
  return null;
}
