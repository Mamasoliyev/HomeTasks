import 'package:ai_book_summary_app/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthDataSource {
  Future<UserModel> register(String email, String password);
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth;
  FirebaseAuthDataSourceImpl({required this.firebaseAuth});

  @override
  Future<UserModel> register(String email, String password) async {
    final UserCredential cred = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    return UserModel.fromFromFirebaseUser(cred.user);
  }
}
