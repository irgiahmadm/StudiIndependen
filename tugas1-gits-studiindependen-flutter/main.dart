import 'dart:io';

void main() {
  var mainClass = new Main();
  mainClass.run();
}

class Main {
  var listAccount = new List.empty();

  void run() {
    var account1 = {
      'accountNumber': '1234',
      'pin': '109809',
      'accountName': 'irgi',
      'balance': 1000000
    };

    var account2 = {
      'accountNumber': '5678',
      'pin': '098712',
      'accountName': 'ahmad',
      'balance': 500000
    };

    listAccount = [account1, account2];
    stdout.write("Input pin number:");
    var pin = stdin.readLineSync();
    if (isAccountExist(pin, 'pin')) {
      menu(pin);
    } else {
      stdout.writeln("No such account.");
    }
  }

  void menu(var pin) {
    stdout.writeln("Choose menu");
    stdout.writeln("===========");
    stdout.writeln("1.Transfer");
    stdout.writeln("2.Tarik Tunai");
    stdout.writeln("3.Setor Tunai");
    stdout.writeln("4.Check balance");
    stdout.writeln("5.Exit");
    stdout.write("Choice: ");
    var input = stdin.readLineSync();
    action(pin, input);
  }

  void action(var pin, var input) {
    switch (input) {
      case '1':
        //Transfer
        {
          stdout.write("Input account number: ");
          var accountNumber = stdin.readLineSync();
          if (isAccountExist(accountNumber, 'accountNumber')) {
            stdout.write("Nominal: ");
            var inputNominal = stdin.readLineSync();
            if (isBalanceValid(inputNominal, pin)) {
              balanceAction(
                  int.parse(inputNominal!),
                  accountNumber,
                  //add balance to targeted account number
                  'accountNumber',
                  'add',
                  pin);
              //min balance to user that transfer they balance
              stdout.writeln(pin);
              balanceAction(
                  int.parse(inputNominal),
                  pin,
                  //add balance to targeted account number
                  'pin',
                  'min',
                  pin);
              continueTransition(pin);
            } else {
              stdout.writeln('Balance is not enough.');
              continueTransition(pin);
            }
          } else {
            stdout.writeln("No such account.");
          }
        }
        break;
      case '2':
        //Tarik tunai
        {
          stdout.write("Nominal: ");
          var inputNominal = stdin.readLineSync();
          if (isBalanceValid(inputNominal, pin)) {
            balanceAction(int.parse(inputNominal!), pin, 'pin', 'min', pin);
            continueTransition(pin);
          } else {
            stdout.writeln('Balance is not enough.');
            continueTransition(pin);
          }
        }
        break;
      case '3':
        //Setor tunai
        {
          stdout.write("Nominal: ");
          var inputNominal = stdin.readLineSync();
          if (isBalanceValid(inputNominal, pin)) {
            balanceAction(int.parse(inputNominal!), pin, 'pin', 'add', pin);
            continueTransition(pin);
          } else {
            stdout.writeln('Balance is not enough.');
            continueTransition(pin);
          }
        }
        break;
      case '4':
        //check balance
        {
          balanceAction(0, pin, 'pin', 'check', pin);
          continueTransition(pin);
        }
        break;
      case '5':
        {
          exit(0);
        }
    }
  }

  bool isAccountExist(var pinOrNumber, String property) {
    var isExist = false;
    listAccount.forEach((element) {
      if (pinOrNumber == element[property]) {
        isExist = true;
      }
    });
    return isExist;
  }

  bool isBalanceValid(var inputedNominal, var pin) {
    var isValid = false;
    listAccount.forEach((element) {
      if (pin == element['pin']) {
        if (int.parse(inputedNominal) < element['balance']) {
          isValid = true;
        }
      }
    });
    return isValid;
  }

  continueTransition(var pin) {
    if (isContinued()) {
      menu(pin);
    }
  }

  balanceAction(
      var newBalance, var pinOrNumber, var property, var operation, var pin) {
    listAccount.forEach((element) {
      if (pinOrNumber == element[property]) {
        stdout.writeln('found!');
        if (operation == 'add') {
          element['balance'] += newBalance;
          stdout.writeln('Balance is added.');
        }
        if (operation == 'min') {
          element['balance'] -= newBalance;
          stdout.writeln('your balance is reduced');
        }
        if (operation == 'check') {
          stdout.writeln('      Your Balance      ');
          stdout.writeln('=========================');
          stdout.writeln(element['balance']);
        }
      }
    });
  }

  bool isContinued() {
    stdout.write('Continue transaction(y/n)?');
    var answer = stdin.readLineSync();
    if (answer?.toLowerCase() == 'y') {
      return true;
    } else {
      exit(0);
    }
  }
}
