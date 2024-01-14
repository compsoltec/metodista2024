import { Response } from "express"
import {db} from './config/firebase'

type PastoraisType = {
 titulo:string,
 foto: string,
 descricao: string,
 
}

type Request = {
    body: PastoraisType,
    params: {entryId: string}
}

const getAllPastorais = async (req: Request, res: Response) => {
    try{
        const  allPastorais : PastoraisType[] = []
        const querySnapshot = await db.collection('pastorais').get()
        querySnapshot.forEach((doc: any) => allPastorais.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: allPastorais
      })  
    } catch(error){
        return res.status(500).json(error)
    }
 }
 const addPastorais = async (req: Request, res: Response) => {
    const {titulo,foto,descricao} = req.body
    try{    
        
        const entry = db.collection('pastorais').doc()
        const entryObject = {
            id: entry.id,
            titulo: titulo,
            foto: foto,
            descricao:descricao

        }
        entry.set(entryObject)

        res.status(200).send({
            status: true,
            message: 'Pastorais adicionado com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }

 export {getAllPastorais, addPastorais}