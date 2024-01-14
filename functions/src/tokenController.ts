import { Response } from "express"
import {db} from './config/firebase'

type TokenType = {
 token:string
 
}

type Request = {
    body: TokenType,
    params: {entryId: string}
}

const getAllTokens = async (req: Request, res: Response) => {
    try{
        const  allToken : TokenType[] = []
        const querySnapshot = await db.collection('token').get()
        querySnapshot.forEach((doc: any) => allToken.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: allToken
      })  
    } catch(error){
        return res.status(500).json(error)
    }
 }
 const addToken = async (req: Request, res: Response) => {
    const {token} = req.body
    try{    
        
        const entry = db.collection('token').doc(token)
        const entryObject = {
            id: entry.id,

        }
        entry.set(entryObject)

        res.status(200).send({
            status: true,
            message: 'Token adicionado com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }

 export {getAllTokens, addToken}