import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AutenticacaoServico{
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

    cadastraUsuario({required String username, required String email, required String senha, required String time}) async{
        UserCredential usuario = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
        
        await usuario.user!.updateDisplayName(username);
        
        await _firebaseFirestore.collection('time').doc(usuario.user!.uid).set({
            'nomeTime': time,
        });
    }

    login(email, senha) async {
        try {
            UserCredential usuario = await _firebaseAuth.signInWithEmailAndPassword(
                email: email,
                password: senha,
            );

            return usuario;
        } catch (e) {
            print('Erro durante a autenticação: $e');
            return false;
        }
    }

    recuperaUsuarioLogado() async{
      User? usuario = _firebaseAuth.currentUser;
      
      return usuario;
    }
}