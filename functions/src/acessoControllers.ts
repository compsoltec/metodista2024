
import {Response} from "express"
import {db} from './config/firebase'


type acessoTypes = {
    tipodeacesso: string;
    token: [];
    tokenSolicitacao: string;
    nome: string;
    descricao: string;

   

}

type Request = {
    body: acessoTypes,
    params: {acessoid: string,  token: string}
}

const addNewAcesso = async (req: Request, res: Response) => {
    const {tipodeacesso} = req.body
    try{
        const entry = db.collection('acesso').doc()
        const entryObject = {
            tipodeacesso,
            
        }
        entry.set(entryObject)

        res.status(200).send({
            status: 'Sucesso',
            message: 'Acesso criada com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }

 const solicitarAcesso = async (req: Request, res: Response) => {
  const {tokenSolicitacao, nome, descricao} = req.body
  try{
      const entry = db.collection('solicitarAcesso').doc()
      const entryObject = {
        tokenSolicitacao,
        nome,
        descricao
          
      }
      entry.set(entryObject)

      res.status(200).send({
          status: 'Sucesso',
          message: 'Acesso criada com sucesso',
          data: entryObject
      })  
  } catch(error){
      res.status(500).json(error)
  }
}
 const addNewAcessoUser = async (req: Request, res: Response) => {
  const { body: {token }, params: { acessoid } } = req

  try{
      const entry = db.collection('acesso').doc(acessoid).collection('token').doc()
      const entryObject = {
          token
          
      }
      entry.set(entryObject)

      res.status(200).send({
          status: 'Sucesso',
          message: 'Acesso criada com sucesso',
          data: entryObject
      })  
  } catch(error){
      res.status(500).json(error)
  }
}
 const getAcesso = async (req: Request, res: Response) => {
    try{
        const  acesso : acessoTypes[] = []
        const querySnapshot = await db.collection('acesso').get()
        querySnapshot.forEach((doc: any) => acesso.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: acesso
      })  
        
    } catch(error){
        return res.status(500).json(error)
    }
 
 }

 const getAcessoUser = async (req: Request, res: Response) => {
  const {params: {acessoid}} = req

  try {
    // Obtenha o CPF dos parâmetros da solicitação
    const token: string = req.params.token;

    // Consulta ao Firestore para obter usuários com o CPF especificado
    const querySnapshot = await db.collection('acesso').doc(acessoid).collection('token').where('token', '==', token).get();

    // Array para armazenar os usuários encontrados
    const users: acessoTypes[] = [];

    // Iterar sobre os documentos retornados pela consulta
    querySnapshot.forEach((doc) => {
      // Adicionar os dados do usuário ao array
      users.push(doc.data() as acessoTypes);
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
 const updateAcesso = async (req: Request, res: Response) => {
    const { body: {tipodeacesso,token }, params: { acessoid } } = req
  
    try {
      const acesso = db.collection('acesso').doc(acessoid)
      const currentData = (await acesso.get()).data() || {}
  
      const acessoObject = {
       tipodeacesso: tipodeacesso || currentData.tipodeacesso,
       token: token || currentData.token,
       
      }
  
      await acesso.set(acessoObject).catch(error => {
        return res.status(400).json({
          status: 'error',
          message: error.message
        })
      })
  
      return res.status(200).json({
        status: 'Sucesso',
        message: 'Acesso Atualizada com Sucesso',
        data: acessoObject
      })
    }
    catch(error) { return res.status(500).json(error) }
  }
export{addNewAcesso,getAcesso,updateAcesso,addNewAcessoUser,getAcessoUser, solicitarAcesso}
