
import {Response} from "express"
import {db} from './config/firebase'


type temploTypes = {
    data: string;
    horario: [];
    dataTime: string;
   

}

type Request = {
    body: temploTypes,
    params: {temploid: string}
}

const addNewAgendaTemplo = async (req: Request, res: Response) => {
    const {data,horario, dataTime} = req.body
    try{
        const entry = db.collection('templo').doc()
        const entryObject = {
            data,
            horario,
            dataTime
            
        }
        entry.set(entryObject)

        res.status(200).send({
            status: 'Sucesso',
            message: 'AgendaTemplo criada com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }
 const getAgendaTemplo = async (req: Request, res: Response) => {
    try{
        const  templo : temploTypes[] = []
        const querySnapshot = await db.collection('templo').orderBy('dataTime').get()
        querySnapshot.forEach((doc: any) => templo.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: templo
      })  
        
    } catch(error){
        return res.status(500).json(error)
    }
 
 }
 const updateAgendaTemplo = async (req: Request, res: Response) => {
    const { body: {data,horario }, params: { temploid } } = req
  
    try {
      const templo = db.collection('templo').doc(temploid)
      const currentData = (await templo.get()).data() || {}
  
      const temploObject = {
       data: data || currentData.data,
       horario: horario || currentData.horario,
       
      }
  
      await templo.set(temploObject).catch(error => {
        return res.status(400).json({
          status: 'error',
          message: error.message
        })
      })
  
      return res.status(200).json({
        status: 'Sucesso',
        message: 'AgendaTemplo Atualizada com Sucesso',
        data: temploObject
      })
    }
    catch(error) { return res.status(500).json(error) }
  }
export{addNewAgendaTemplo,getAgendaTemplo,updateAgendaTemplo}
