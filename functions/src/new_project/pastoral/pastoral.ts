
import { Request, Response } from 'express';
import { db } from "../../config/firebase";


type PastoralType = {
  id?: string;
  title: string;
  text: string;
  author: string;
  date: string;
  imageUrls?: string[];  // Novo campo
  createdAt?: string;
};
  
  type PastoralRequest = Request & {
    body: PastoralType;
    params: { pastoralId: string };
  };
  
  // Criar Pastoral
  const createPastoral = async (req: PastoralRequest, res: Response) => {
    console.log('📥 Criando nova pastoral...');
    try {
      const { title, text, author, date , imageUrls } = req.body;
  
      // Validar campos obrigatórios
      if (!title || !text || !author || !date) {
        return res.status(400).json({
          status: 'Error',
          message: 'Título, texto, autor e data são obrigatórios'
        });
      }
  
      // Criar novo documento de pastoral no Firestore
      const newPastoralRef = db.collection('pastorals').doc();
      const newPastoral: PastoralType = {
        id: newPastoralRef.id,
        title,
        text,
        author,
        date,
        imageUrls: Array.isArray(imageUrls) ? imageUrls : [],
        createdAt: new Date().toISOString(),
      };
  
      console.log('📝 Salvando dados da pastoral no Firestore...');
      await newPastoralRef.set(newPastoral);
      
      return res.status(201).json({
        status: 'Success',
        message: 'Pastoral criada com sucesso',
        data: newPastoral
      });
    } catch (error) {
      console.error('❌ Erro ao criar pastoral:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao criar pastoral'
      });
    }
  };
  
  // Obter Todas as Pastorais
  const getPastorals = async (_req: Request, res: Response) => {
    try {
      console.log('📥 Buscando todas as pastorais...');
      const pastorals: PastoralType[] = [];
      const querySnapshot = await db.collection('pastorals')
        .orderBy('date', 'desc')
        .get();
      
      querySnapshot.forEach((doc) => {
        pastorals.push({
          ...doc.data() as PastoralType,
          id: doc.id
        });
      });
      
      return res.status(200).json({
        status: 'Success',
        data: pastorals
      });
    } catch (error) {
      console.error('❌ Erro ao buscar pastorais:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar pastorais'
      });
    }
  };
  
  // Obter Pastoral por ID
  const getPastoralById = async (req: PastoralRequest, res: Response) => {
    const { pastoralId } = req.params;
    
    try {
      console.log(`📥 Buscando pastoral com ID: ${pastoralId}`);
      const pastoralDoc = await db.collection('pastorals').doc(pastoralId).get();
      
      if (!pastoralDoc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'Pastoral não encontrada'
        });
      }
      
      const pastoral = {
        ...pastoralDoc.data() as PastoralType,
        id: pastoralDoc.id
      };
      
      return res.status(200).json({
        status: 'Success',
        data: pastoral
      });
    } catch (error) {
      console.error('❌ Erro ao buscar pastoral:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar pastoral'
      });
    }
  };
  
  // Atualizar Pastoral
  const updatePastoral = async (req: PastoralRequest, res: Response) => {
    const { pastoralId } = req.params;
    const { title, text, author, date } = req.body;
    
    try {
      console.log(`📝 Atualizando pastoral com ID: ${pastoralId}`);
      const pastoralRef = db.collection('pastorals').doc(pastoralId);
      const doc = await pastoralRef.get();
      
      if (!doc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'Pastoral não encontrada'
        });
      }
      
      const currentData = doc.data() as PastoralType;
      const updatedData: Partial<PastoralType> = {
        title: title || currentData.title,
        text: text || currentData.text,
        author: author || currentData.author,
        date: date || currentData.date,
      };
      
      await pastoralRef.update(updatedData);
      
      // Obter o documento atualizado
      const updatedDoc = await pastoralRef.get();
      const updatedPastoral = {
        ...updatedDoc.data() as PastoralType,
        id: updatedDoc.id
      };
      
      return res.status(200).json({
        status: 'Success',
        message: 'Pastoral atualizada com sucesso',
        data: updatedPastoral
      });
    } catch (error) {
      console.error('❌ Erro ao atualizar pastoral:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao atualizar pastoral'
      });
    }
  };
  
  // Deletar Pastoral
  const deletePastoral = async (req: PastoralRequest, res: Response) => {
    const { pastoralId } = req.params;
    
    try {
      console.log(`🗑️ Deletando pastoral com ID: ${pastoralId}`);
      const pastoralRef = db.collection('pastorals').doc(pastoralId);
      const doc = await pastoralRef.get();
      
      if (!doc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'Pastoral não encontrada'
        });
      }
      
      // Deletar documento do Firestore
      await pastoralRef.delete();
      
      return res.status(200).json({
        status: 'Success',
        message: 'Pastoral removida com sucesso'
      });
    } catch (error) {
      console.error('❌ Erro ao deletar pastoral:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao deletar pastoral'
      });
    }
  };
  
  export {
    createPastoral,
    getPastorals,
    getPastoralById,
    updatePastoral,
    deletePastoral,
  };