import {dbAuth} from './config/firebase'
import { signInWithEmailAndPassword, getAuth } from "firebase/auth";

const auth = getAuth();


const createUser = async (req: any,res:any) => {
  const {email, password} = req.body
  try {
    const userRecord = await dbAuth.createUser({
      email,
      password,
    });

    res.status(200).json({
      status: 'success',
      message: 'Usuário criado com sucesso',
      data: userRecord,
    });
  } catch (error) {
    res.status(500).json({
      status: 'error',
      message: 'Erro ao criar usuário',
      error: error,
    });
  }

}

const loginUser = async (req: any,res:any) => {
  const {email, password} = req.body
    try {

    const userCredential = await signInWithEmailAndPassword(auth,email,password);
    const user = userCredential.user;

    res.status(200).json({
      status: 'success',
      message: 'Login bem-sucedido',
      data: user,
    });
  } catch (error) {
    res.status(500).json({
      status: 'error',
      message: 'Erro ao fazer login',
      error: error,
    });
  }
}


export {loginUser,createUser};
