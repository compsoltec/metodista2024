
import {Response} from "express"
import {db} from './config/firebase'


type AtividadesType = {
  id: string
  data: string,
  foto: string,
  descricao: string,
  vagas: number,
  nome: string,
  token: string,
  telefone: string,
  idAtividade: string
  titulo: string,
 
 }

 type Request = {
  body: AtividadesType,
  params: { atividadesId: string, token: string, inscritoId: string},
}

const addAtividades = async (req: Request, res: Response) => {

  const {foto, data, descricao,vagas, titulo} = req.body
  try{
      const entry = db.collection('atividades').doc()
      const entryObject = {
          id: entry.id,
          data,
          descricao,
          foto,
          vagas,
          titulo
        
      }
      entry.set(entryObject)

      res.status(200).send({
          status: true,
          message: 'Atividades adicionado com sucesso',
          data: entryObject
      })  
  } catch(error){
      res.status(500).json(error)
  }
}
const addInscritosHomolog = async (req: Request, res: Response) => {
  const { body: { nome, telefone, token, idAtividade }, params: { atividadesId } } = req;

  const atividadeRef = db.collection('atividades').doc(atividadesId);

  try {
    // Inicie uma transação para garantir que as operações sejam atômicas
    const result = await db.runTransaction(async (transaction) => {
      const atividadeDoc = await transaction.get(atividadeRef);
      if (!atividadeDoc.exists) {
        throw new Error("Atividade não encontrada!");
      }

      const atividadeData = atividadeDoc.data();
      if (atividadeData && atividadeData.vagas > 0) {  // Garante que atividadeData é definido
        // Reduzir o número de vagas
        transaction.update(atividadeRef, { vagas: atividadeData.vagas - 1 });

        // Adicionar o inscrito
        const entry = atividadeRef.collection('inscricao').doc();
        const entryObject = {
          id: entry.id,
          nome,
          telefone,
          token,
          idAtividade
        };
        transaction.set(entry, entryObject);

        return { success: true, entryObject };
      } else {
        return { success: false, message: 'Não há vagas disponíveis' };
      }
    });

    if (result.success) {
      res.status(200).send({
        status: true,
        message: 'Inscrição Efetuada Com Sucesso',
        data: result.entryObject
      });
    } else {
      res.status(400).send({
        status: false,
        message: result.message || 'Erro desconhecido ao processar inscrição'
      });
    }
  } catch (error) {
    console.error("Erro na inscrição: ", error);
    res.status(500).json({
      status: false,
      message: "Erro ao processar inscrição",
      error: error
    });
  }
};



const getAllInscritosHomolog = async (req: Request, res: Response) => {
const {params: {atividadesId}} = req
try{
    const  allAtividades : AtividadesType[] = []
    const querySnapshot = await db.collection('atividades').doc(atividadesId).collection('inscricao').get()
    querySnapshot.forEach((doc: any) => allAtividades.push(doc.data()))
    return res.status(200).send({
      status: true,
      data: allAtividades
  })  
} catch(error){
    return res.status(500).json(error)
}
}

const getUInscritosBytoken = async (req: Request, res: Response) => {
  const {params: {atividadesId}} = req

  try {
    // Obtenha o CPF dos parâmetros da solicitação
    const token: string = req.params.token;

    // Consulta ao Firestore para obter usuários com o CPF especificado
    const querySnapshot = await db.collection('atividades').doc(atividadesId).collection('inscricao').where('token', '==', token).get();

    // Array para armazenar os usuários encontrados
    const users: AtividadesType[] = [];

    // Iterar sobre os documentos retornados pela consulta
    querySnapshot.forEach((doc) => {
      // Adicionar os dados do usuário ao array
      users.push(doc.data() as AtividadesType);
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

const getAllAtividades = async (req: Request, res: Response) => {
  try{
      const  allAtividades : AtividadesType[] = []
      const querySnapshot = await db.collection('atividades').orderBy('titulo').get()
      querySnapshot.forEach((doc: any) => allAtividades.push(doc.data()))
      return res.status(200).send({
        status: true,
        data: allAtividades
    })  
  } catch(error){
      return res.status(500).json(error)
  }
}



const updateAtividades = async (req: Request, res: Response) => {

  const { body: { foto, data, descricao,id, vagas } } = req

  try {
    const devocional = db.collection('atividades').doc()
    const currentData = (await devocional.get()).data() || {}

    const devocionalObject = {
      foto: foto || currentData.foto,
      descricao: descricao || currentData.descricao,
      data: data || currentData.data,
      vagas: vagas || currentData.vagas,
      id: id || currentData.id
    }

    await devocional.set(devocionalObject).catch(error => {
      return res.status(400).json({
        status: 'error',
        message: error.message
      })
    })

    return res.status(200).json({
      status: 'Sucesso',
      message: 'Atividades Atualizado com Sucesso',
      data: devocionalObject
    })
  }
  catch(error) { return res.status(500).json(error) }
}


const deleteAtividades = async (req: Request, res: Response) => {
  const { } = req.params

  try {
    const atividades = db.collection('atividades').doc(req.params.atividadesId)

    await atividades.delete().catch(error => {
      return res.status(400).json({
        status: 'Error',
        message: error.message
      })
    })

    return res.status(200).json({
      status: 'Sucesso',
      message: 'Atividades Deletado com Sucesso',
    })
  }
  catch(error) { return res.status(500).json(error) }
}

const deleteInscritoHomolog = async (req: Request, res: Response) => {
  const { } = req.params

  try {
    const atividades = db.collection('atividades').doc(req.params.atividadesId).collection('inscricao').doc(req.params.inscritoId)

    await atividades.delete().catch(error => {
      return res.status(400).json({
        status: 'Error',
        message: error.message
      })
    })

    return res.status(200).json({
      status: 'Sucesso',
      message: 'Atividades Deletado com Sucesso',
    })
  }
  catch(error) { return res.status(500).json(error) }
}
export {addAtividades, getAllAtividades,getAllInscritosHomolog, 
updateAtividades,getUInscritosBytoken, deleteAtividades,addInscritosHomolog, deleteInscritoHomolog}