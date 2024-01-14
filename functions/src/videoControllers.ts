import { Response } from "express"
import {db} from './config/firebase'

type TokenType = {
 video:string,
 foto: string,
 titulo: string,
 
}

type Request = {
    body: TokenType,
    params: {entryId: string}
}

const getAllVideo = async (req: Request, res: Response) => {
    try{
        const  allToken : TokenType[] = []
        const querySnapshot = await db.collection('videos').get()
        querySnapshot.forEach((doc: any) => allToken.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: allToken
      })  
    } catch(error){
        return res.status(500).json(error)
    }
 }
 const addVideo = async (req: Request, res: Response) => {
    const {video,titulo, foto} = req.body
    try{    
        
        const entry = db.collection('videos').doc()
        const entryObject = {
            id: entry.id,
            video: video,
            titulo: titulo,
            foto: foto

        }
        entry.set(entryObject)

        res.status(200).send({
            status: true,
            message: 'Video adicionado com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }

 export {getAllVideo, addVideo}