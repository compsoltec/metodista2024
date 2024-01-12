
import {Response} from "express"
import {db} from './config/firebase'


type homeTypes = {
    fotosCultos: [];
    avisos: [];
    aniversariantes: [];
    campanhas: [];
    pastoral: string;
    programacao:[{}];

}

type Request = {
    body: homeTypes,
    params: {homeid: string}
}

const addNewHome = async (req: Request, res: Response) => {
    const {fotosCultos,avisos,aniversariantes,campanhas, pastoral,programacao} = req.body
    try{
        const entry = db.collection('home').doc()
        const entryObject = {
            id: entry.id,
            fotosCultos,
            avisos,
            aniversariantes,
            campanhas,
            pastoral,
            programacao
        }
        entry.set(entryObject)

        res.status(200).send({
            status: 'Sucesso',
            message: 'Home criada com sucesso',
            data: entryObject
        })  
    } catch(error){
        res.status(500).json(error)
    }
 }
 const getHome = async (req: Request, res: Response) => {
    try{
        const  home : homeTypes[] = []
        const querySnapshot = await db.collection('home').get()
        querySnapshot.forEach((doc: any) => home.push(doc.data()))
        return res.status(200).send({
          status: true,
          data: home
      })  
        
    } catch(error){
        return res.status(500).json(error)
    }
 
 }
 const updateHome = async (req: Request, res: Response) => {
    const { body: {fotosCultos,avisos,aniversariantes,campanhas, pastoral }, params: { homeid } } = req
  
    try {
      const home = db.collection('home').doc(homeid)
      const currentData = (await home.get()).data() || {}
  
      const homeObject = {
       fotosCultos: fotosCultos || currentData.fotosCultos,
       avisos: avisos || currentData.avisos,
       aniversariantes: aniversariantes || currentData.aniversariantes,
       campanhas: campanhas || currentData.campanhas,
       pastoral: pastoral || currentData.pastoral
      }
  
      await home.set(homeObject).catch(error => {
        return res.status(400).json({
          status: 'error',
          message: error.message
        })
      })
  
      return res.status(200).json({
        status: 'Sucesso',
        message: 'Home Atualizada com Sucesso',
        data: homeObject
      })
    }
    catch(error) { return res.status(500).json(error) }
  }
export{addNewHome,getHome,updateHome}
