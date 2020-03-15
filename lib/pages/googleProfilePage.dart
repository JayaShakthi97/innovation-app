import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:innovation_flutter_app/widgets/bodyContainer.dart';

class GoogleProfilePage extends StatefulWidget {
  @override
  _GoogleProfilePageState createState() => _GoogleProfilePageState();
}

class _GoogleProfilePageState extends State<GoogleProfilePage> {
  bool loading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    await Future.delayed(Duration(seconds: 1));
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyContainer(
        child: SafeArea(
          child: Container(
            child: loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Container(),
                  ),
          ),
        ),
      ),
    );
  }
}
