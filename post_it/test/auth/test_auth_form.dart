import 'package:flutter_test/flutter_test.dart';

// Importa as funções que você deseja testar
import '/Users/pedronaves/Desktop/UI-Post-it/post_it/lib/screens/auth_screen/validators/email_validator.dart';
import '/Users/pedronaves/Desktop/UI-Post-it/post_it/lib/screens/auth_screen/validators/name_validator.dart';
import '/Users/pedronaves/Desktop/UI-Post-it/post_it/lib/screens/auth_screen/validators/password_validator.dart';

void main() {
  group('Email Validator', () {
    test('Retorna erro se o email é nulo ou vazio', () {
      expect(emailValidator(null), 'É necessário email');
      expect(emailValidator(''), 'É necessário email');
    });

    test('Retorna erro se o email não contém "@"', () {
      expect(emailValidator('testeemail.com'), 'O email digitado não é valido');
    });

    test('Retorna nulo se o email é válido', () {
      expect(emailValidator('teste@email.com'), null);
    });
  });

  group('Name Validator', () {
    test('Retorna erro se o nome é nulo ou vazio', () {
      expect(nameValidator(null), 'É necessário um nome.');
      expect(nameValidator(''), 'É necessário um nome.');
    });

    test('Retorna erro se o nome tem menos de 5 letras', () {
      expect(nameValidator('Ana'), 'O nome precisa conter pelo menos 5 letras');
    });

    test('Retorna erro se o nome tem mais de 20 letras', () {
      expect(nameValidator('NomeMuitoGrandeDeMaisQue20Caracteres'), 'O nome não pode ter mais de 20 letras');
    });

    test('Retorna nulo se o nome é válido', () {
      expect(nameValidator('Pedro Naves'), null);
    });
  });

  group('Password Validator', () {
    test('Retorna erro se a senha é nula ou vazia', () {
      expect(passwordValidator(null), 'É necessário uma senha.');
      expect(passwordValidator(''), 'É necessário uma senha.');
    });

    test('Retorna erro se a senha tem menos de 6 caracteres', () {
      expect(passwordValidator('12345'), 'A senha precisa ter pelo menos 6 caracteres');
    });

    test('Retorna nulo se a senha é válida', () {
      expect(passwordValidator('123456'), null);
    });
  });
}
