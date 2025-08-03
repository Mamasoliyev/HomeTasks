class Contact {
  String name;
  String phoneNumber;
  String? email;

  Contact({
    required this.name,
    required this.phoneNumber,
    this.email,
  });

  void printContact() {
    print('Ism: $name');
    print('Telefon: $phoneNumber');
    if (email != null) {
      print('Email: $email');
    }
  }
}

class Phonebook {
  List<Contact> contacts = [];

  void addContact(Contact contact) {
    contacts.add(contact);
  }

  void printContacts() {
    if (contacts.isEmpty) {
      print('Kontaktlar mavjud emas.');
      return;
    }

    for (var i = 0; i < contacts.length; i++) {
      print('--- Kontakt ${i + 1} ---');
      contacts[i].printContact();
    }
  }
}

void main() {
  var contact1 = Contact(name: 'Ali', phoneNumber: '998901234567', email: 'ali@mail.com');
  var contact2 = Contact(name: 'Vali', phoneNumber: '998909876543');
  var contact3 = Contact(name: 'Sami', phoneNumber: '998931112233');
  var contact4 = Contact(name: 'Guli', phoneNumber: '998907654321', email: 'guli@mail.com');

  var phonebook = Phonebook();
  phonebook.addContact(contact1);
  phonebook.addContact(contact2);
  phonebook.addContact(contact3);
  phonebook.addContact(contact4);

  phonebook.printContacts();
}
