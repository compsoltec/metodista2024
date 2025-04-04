import { Response } from "express"
import {db} from './config/firebase'

type EscalasType = {
 ministerio:string,
 data: string,
 integrantes: [],
 
}

type Request = {
    body: EscalasType,
    params: {entryId: string}
}

const getAllEscalas = async (req: Request, res: Response) => {
    try{
        const  allEscalas : EscalasType[] = []
        const querySnapshot = await db.collection('escalas').get()
        querySnapshot.forEach((doc: any) => allEscalas.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: allEscalas
      })  
    } catch(error){
        return res.status(500).json(error)
    }
 }
 const addEscalas = async (req: Request, res: Response) => {
    const {ministerio,data,integrantes} = req.body
    try{    
        
        const entry = db.collection('escalas').doc()
        const entryObject = {
            id: entry.id,
            ministerio: ministerio,
            data: data,
            integrantes:integrantes,

        }
        entry.set(entryObject)

        res.status(200).send({
            status: true,
            message: 'Escala criada com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }

 export {getAllEscalas, addEscalas}