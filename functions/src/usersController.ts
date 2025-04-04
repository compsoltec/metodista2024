import { Response } from "express"
import {db} from './config/firebase'

type usersType = {
 uuid: string,
 token: string,


}

type Request = {
    body: usersType,
    params: {usersId: string, token: string}
}

 const addusers = async (req: Request, res: Response) => {
    const {uuid, token} = req.body
    try{
        const entry = db.collection('users').doc(token)
        const entryObject = {
            uuid,
            token,

  
        }
        entry.set(entryObject)

        res.status(200).send({
            status: 'Sucesso',
            message: 'Users adicionado com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }

 const getAllusers = async (req: Request, res: Response) => {
    try{
        const  allusers : usersType[] = []
        const querySnapshot = await db.collection('users').get()
        querySnapshot.forEach((doc: any) => allusers.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: allusers
      })  
        
    } catch(error){
        return res.status(500).json(error)
    }
 }
 const getUsersByUuid = async (req: Request, res: Response) => {
  try {
    // Obtenha o CPF dos parâmetros da solicitação
    const token: string = req.params.token;

    // Consulta ao Firestore para obter usuários com o CPF especificado
    const querySnapshot = await db.collection('users').where('token', '==', token).get();

    // Array para armazenar os usuários encontrados
    const users: usersType[] = [];

    // Iterar sobre os documentos retornados pela consulta
    querySnapshot.forEach((doc) => {
      // Adicionar os dados do usuário ao array
      users.push(doc.data() as usersType);
    });

    // Retornar os usuários encontrados
    return res.status(200).json({
      status: true,
      data: users
    });
  } catch (error) {
    // Se ocorrer um erro, retornar um status 500 com o erro
    return res.status(500).json(error);
  }
};
 const updateUsers = async (req: Request, res: Response) => {
  try{
      const  allusers : usersType[] = []
      const querySnapshot = await db.collection('users').doc(req.params.usersId).collection('usuarios').get()
      querySnapshot.forEach((doc: any) => allusers.push(doc.data()))
      return res.status(200).send({
        status: true,
        data: allusers
    })  
      
  } catch(error){
      return res.status(500).json(error)
  }
}
  
  const deleteusers = async (req: Request, res: Response) => {
    const { usersId } = req.params
  
    try {
      const users = db.collection('users').doc(usersId)
  
      await users.delete().catch(error => {
        return res.status(400).json({
          status: 'Error',
          message: error.message
        })
      })
  
      return res.status(200).json({
        status: 'Sucesso',
        message: 'Users Deletado com Sucesso',
      })
    }
    catch(error) { return res.status(500).json(error) }
  }

 export {addusers, getAllusers, deleteusers, updateUsers,getUsersByUuid}