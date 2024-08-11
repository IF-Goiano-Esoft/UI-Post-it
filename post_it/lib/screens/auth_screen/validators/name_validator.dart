String? nameValidator(String? _name) {
  if (_name == null || _name == '') {
    return 'É necessário um nome.';
  }
  if (_name.trim().length > 20) {
    return 'O nome não pode ter mais de 20 letras';
  }
  if (_name.trim().length < 5) {
    return 'O nome precisa conter pelo menos 5 letras';
  }
  return null;
}
