import { Response } from "express"
import {db} from './config/firebase'

type LoginType = {
 email:string,
 senha: string,
 
}

type Request = {
    body: LoginType,
    params: {entryId: string}
}

const getAllLogin = async (req: Request, res: Response) => {
    try{
        const  allLogin : LoginType[] = []
        const querySnapshot = await db.collection('login').get()
        querySnapshot.forEach((doc: any) => allLogin.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: allLogin
      })  
    } catch(error){
        return res.status(500).json(error)
    }
 }
 const addLogin = async (req: Request, res: Response) => {
    const {email,senha} = req.body
    try{    
        
        const entry = db.collection('login').doc()
        const entryObject = {
            id: entry.id,
            email: email,
            senha: senha

        }
        entry.set(entryObject)

        res.status(200).send({
            status: true,
            message: 'Login adicionado com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }

 export {getAllLogin, addLogin}