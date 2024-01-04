
import {Response} from "express"
import {db} from './config/firebase'


type inscricoesTypes = {
    foto: string,
    data: string;
    vagas: number;
    descricao:string;
    titulo: string;
    id: string;
    inscritos: [{
      nome:string, 
      telefone:string,
      id:string}];

}

type Request = {
    body: inscricoesTypes,
    params: {inscricoesid: string}
}

const addNewInscricoes = async (req: Request, res: Response) => {
    const {foto,data,vagas,descricao,inscritos, titulo} = req.body
    try{
        const entry = db.collection('inscricoes').doc()
        const entryObject = {
            id: entry.id,
            foto,
            vagas,
            descricao,
            data,
            inscritos,
            titulo
            
        }
        entry.set(entryObject)

        res.status(200).send({
            status: 'Sucesso',
            message: 'Inscricoes criada com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }
 const getInscricoes = async (req: Request, res: Response) => {
    try{
        const  inscricoes : inscricoesTypes[] = []
        const querySnapshot = await db.collection('inscricoes').get()
        querySnapshot.forEach((doc: any) => inscricoes.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: inscricoes
      })  
        
    } catch(error){
        return res.status(500).json(error)
    }
 
 }
 const updateInscricoes = async (req: Request, res: Response) => {
    const { body: {foto,data,vagas,descricao,inscritos, titulo, id}, params: { inscricoesid } } = req
  
    try {
      const inscricoes = db.collection('inscricoes').doc(inscricoesid)
      const currentData = (await inscricoes.get()).data() || {}
  
      const inscricoesObject = {
        foto: foto || currentData.foto,
        data: data || currentData.data,
        vagas: vagas || currentData.vagas,
        descricao: descricao || currentData.descricao,
        inscritos: inscritos || currentData.inscritos,
        titulo: titulo || currentData.titulo,
        id: id || currentData.id
      }
  
      await inscricoes.set(inscricoesObject).catch(error => {
        return res.status(400).json({
          status: 'error',
          message: error.message
        })
      })
  
      return res.status(200).json({
        status: 'Sucesso',
        message: 'Inscricoes Atualizada com Sucesso',
        data: inscricoesObject
      })
    }
    catch(error) { return res.status(500).json(error) }
  }
export{addNewInscricoes,getInscricoes,updateInscricoes}
