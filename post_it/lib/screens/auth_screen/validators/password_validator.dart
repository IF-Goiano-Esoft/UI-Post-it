String? passwordValidator(String? password) {
  if (password == null || password == '') {
    return 'É necessário uma senha.';
  }
  if (password.length < 6) {
    return 'A senha precisa ter pelo menos 6 caracteres';
  }
  return null;
}
