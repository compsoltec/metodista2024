
import {Response} from "express"
import {db} from './config/firebase'


type cadastroTypes = {
    nome: string;
    dataNascimento: string;
    telefone: number,
    statusProfissional: string;
    area: string;
    descricao: string;

   

}

type Request = {
    body: cadastroTypes,
    params: {cadastroid: string,  token: string}
}

const addNewCadastro = async (req: Request, res: Response) => {
    const {nome, dataNascimento, statusProfissional, area, telefone, descricao} = req.body
    try{
        const entry = db.collection('cadastro').doc()
        const entryObject = {
            nome,
            dataNascimento,
            telefone,
            statusProfissional,
            area,
            descricao
            
        }
        entry.set(entryObject)

        res.status(200).send({
            status: 'Sucesso',
            message: 'Cadastro criada com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }
 const getCadastro = async (req: Request, res: Response) => {
    try{
        const  cadastro : cadastroTypes[] = []
        const querySnapshot = await db.collection('cadastro').get()
        querySnapshot.forEach((doc: any) => cadastro.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: cadastro
      })  
        
    } catch(error){
        return res.status(500).json(error)
    }
 
 }

export{addNewCadastro,getCadastro}
