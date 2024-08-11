String? titleValidator(String? titulo) {
  if (titulo == null || titulo == '') return 'E necessário um titulo';
  if (titulo.length < 4) return 'O titulo precisa ter mais que 5 letras';
  if (titulo.length >= 16) {
    return 'O titulo não pode conter mais que 15 letras';
  }
  return null;
}
