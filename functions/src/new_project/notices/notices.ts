import { db } from "../../config/firebase";
import { Request, Response } from 'express';

type NoticesType = {
    id?: string;
    name: string;
    description?: string; // Indica se é avisos do dia atual
    image?: string;
  };

  type NoticesRequest = Request & {
    body: NoticesType;
    params: { courcesId: string };
  };
  
  // Criar avisos
  const createNotices = async (req: NoticesRequest, res: Response) => {
    console.log('📥 Criando novo avisos...');
    try {
      const { name, description,image} = req.body;
      
  
      // Criar novo documento de avisos no Firestore
      const newNoticesRef = db.collection('notices').doc();
      const newNotices: NoticesType = {
        id: newNoticesRef.id,
        name: name,
        description: description, // Indica se é avisos do dia atual
        image: image,

      };


      console.log('📝 Salvando dados do avisos no Firestore...');
      await newNoticesRef.set(newNotices);
      
      return res.status(201).json({
        status: 'Success',
        message: 'avisos adicionado com sucesso',
        data: newNotices
      });
    } catch (error) {
      console.error('❌ Erro ao criar avisos:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao adicionar avisos'
      });
    }
  };
  
  // Obter Todos os avisos (ordenados por proximidade da data)


  const getNotices = async (_req: Request, res: Response) => {
    try {
      console.log('📥 Buscando todos os avisos...');
      const notices: NoticesType[] = [];
      const querySnapshot = await db.collection('notices').get();
      
      // Coleta todos os avisos
      querySnapshot.forEach((doc) => {
        notices.push({
          ...doc.data() as NoticesType,
          id: doc.id
        });
      });
    
      return res.status(200).json({
        status: 'Success',
        data: notices
      });
    } catch (error) {
      console.error('❌ Erro ao buscar avisos:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar avisos'
      });
    }
  };
  
  
  // Obter avisos por ID
  const getNoticesById = async (req: NoticesRequest, res: Response) => {
    const { courcesId } = req.params;
    
    try {
      console.log(`📥 Buscando avisos com ID: ${courcesId}`);
      const courcesDoc = await db.collection('notices').doc(courcesId).get();
      
      if (!courcesDoc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'avisos não encontrado'
        });
      }
      
      const courcesData = courcesDoc.data() as NoticesType;
         
      
      const notices = {
        ...courcesData,
        id: courcesDoc.id
      };
      
      return res.status(200).json({
        status: 'Success',
        data: notices
      });
    } catch (error) {
      console.error('❌ Erro ao buscar avisos:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar avisos'
      });
    }
  };
  
  // Atualizar avisos
  const updateNotices = async (req: NoticesRequest, res: Response) => {
    const { courcesId } = req.params;
    const { name,
        description,
      image,
     } = req.body;
    
    try {
      console.log(`📝 Atualizando avisos com ID: ${courcesId}`);
      const courcesRef = db.collection('notices').doc(courcesId);
      const doc = await courcesRef.get();
      
      if (!doc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'avisos não encontrado'
        });
      }
      
      const currentData = doc.data() as NoticesType;
      const updatedData: Partial<NoticesType> = {
        name: name || currentData.name,
        description: description || currentData.description,
        image: image || currentData.image,
      };
    //   id: newNoticesRef.id,
    //   name: name,
    //   description: description, // Indica se é avisos do dia atual
    //   image: image,
      await courcesRef.update(updatedData);
      
      // Obter o documento atualizado
      const updatedDoc = await courcesRef.get();
      const updatedNotices = {
        ...updatedDoc.data() as NoticesType,
        id: updatedDoc.id
      };
      
      return res.status(200).json({
        status: 'Success',
        message: 'avisos atualizado com sucesso',
        data: updatedNotices
      });
    } catch (error) {
      console.error('❌ Erro ao atualizar avisos:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao atualizar avisos'
      });
    }
  };
  
  // Deletar avisos
  const deleteNotices = async (req: NoticesRequest, res: Response) => {
    const { courcesId } = req.params;
    
    try {
      console.log(`🗑️ Deletando avisos com ID: ${courcesId}`);
      const courcesRef = db.collection('notices').doc(courcesId);
      const doc = await courcesRef.get();
      
      if (!doc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'avisos não encontrado'
        });
      }
      
      // Deletar documento do Firestore
      await courcesRef.delete();
      
      return res.status(200).json({
        status: 'Success',
        message: 'avisos removido com sucesso'
      });
    } catch (error) {
      console.error('❌ Erro ao deletar avisos:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao deletar avisos'
      });
    }
  };
  
  export {
    createNotices,
    getNotices,
    getNoticesById,
    updateNotices,
    deleteNotices,
  };