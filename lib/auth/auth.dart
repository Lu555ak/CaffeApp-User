import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

class Auth {
  User? get currentUser => FirebaseAuth.instance.currentUser;

  Stream<User?> get userChanges => FirebaseAuth.instance.authStateChanges();

  Future<String?> signUp({required String email, required String password, required String username}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => users.add({"uid": value.user?.uid, "credits": 0}));
      await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
