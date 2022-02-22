import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  BuildContext? context;

  AuthRepository(this.context);

  Stream<User?> authStateListner() {
    return auth.authStateChanges();
  }

  User? currentUser() {
    return auth.currentUser;
  }

  bool isSignIn() {
    return currentUser() != null;
  }

  Future<AuthError?> signUp(String email, String password, String nom,
      String prenom, String phone) async {
    try {
      if (nom.isEmpty) return AuthError("nom-vide");
      if (prenom.isEmpty) return AuthError("prenom-vide");
      if (phone.isEmpty) return AuthError("phone-vide");
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        firestore.collection("users/${value.user!.uid}").add(
            {"nom": nom, "prenom": prenom, "phone": phone, "role": "client"});
        return value;
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return AuthError(e.code);
    } catch (e) {
      return AuthError("unkonwn");
    }
  }

  Future<AuthError?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return AuthError(e.code);
    }
  }
}

class AuthError {
  late String message;
  late String code;
  AuthError(String error) {
    switch (error) {
      case 'weak-password':
        this.code = "password";
        this.message = "Le mot de passe est trop faible";
        break;
      case 'email-already-in-use':
        this.code = "email";
        this.message = "L'e-mail a déjà été utilisé";
        break;
      case "invalid-email":
        this.code = "email";
        this.message = "l'e-mail est incorrect";
        break;
      case "user-disabled":
        this.code = "email";
        this.message =
            "Nous sommes désolés de vous informer que ce compte a été suspendu";
        break;
      case "user-not-found":
        this.code = "email";
        this.message = "Il n'y a pas de compte pour cet email";
        break;
      case "nom-vide":
        this.code = "nom";
        this.message = "Entrez votre nom";
        break;
      case "prenom-vide":
        this.code = "prenom";
        this.message = "Entrez votre prenom";
        break;
      case "phone-vide":
        this.code = "phone";
        this.message = "Entrez votre numéro de téléphone";
        break;
      case "wrong-password":
        this.code = "password";
        this.message = "mauvais mot de passe";
        break;

      default:
        this.code = "unkown";
        this.message = "";
        break;
    }
  }
}
