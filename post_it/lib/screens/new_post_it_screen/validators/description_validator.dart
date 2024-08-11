String? descriptionValidator(String? description) {
  if (description == null || description == '')
    return 'E necessário uma descrição';
  if (description.length < 4)
    return 'A descrição necessita pelo menos 5 letras';
  if (description.length > 50) {
    return 'A descrição não pode ter mais que 50 letras';
  }
  return null;
}
