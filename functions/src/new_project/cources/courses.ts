// Types and imports
import { db } from "../../config/firebase";
import { Request, Response } from 'express';

type CourcesType = {
    id?: string;
    name: string;
    phone: string; 
    course?: string; // Indica se é cursos do dia atual
    image?: string;
    inscricoes?:boolean,
    capacity?: number
  };

  type CourcesRequest = Request & {
    body: CourcesType;
    params: { courcesId: string };
  };
  
  // Criar cursos
  const createCources = async (req: CourcesRequest, res: Response) => {
    console.log('📥 Criando novo cursos...');
    try {
      const { name, phone,course, image ,inscricoes,capacity} = req.body;
      
  
      // Criar novo documento de cursos no Firestore
      const newCourcesRef = db.collection('cources').doc();
      const newCources: CourcesType = {
        id: newCourcesRef.id,
        name,
        phone,
        course,
        image,
        inscricoes: inscricoes ?? false, 
        capacity: capacity ?? 0, 

      };


      console.log('📝 Salvando dados do cursos no Firestore...');
      await newCourcesRef.set(newCources);
      
      return res.status(201).json({
        status: 'Success',
        message: 'cursos adicionado com sucesso',
        data: newCources
      });
    } catch (error) {
      console.error('❌ Erro ao criar cursos:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao adicionar cursos'
      });
    }
  };
  
  // Obter Todos os Cursos (ordenados por proximidade da data)


  const getCources = async (_req: Request, res: Response) => {
    try {
      console.log('📥 Buscando todos os cursos...');
      const cources: CourcesType[] = [];
      const querySnapshot = await db.collection('cources').get();
      
      // Coleta todos os cursos
      querySnapshot.forEach((doc) => {
        cources.push({
          ...doc.data() as CourcesType,
          id: doc.id
        });
      });
    
      return res.status(200).json({
        status: 'Success',
        data: cources
      });
    } catch (error) {
      console.error('❌ Erro ao buscar cursos:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar cursos'
      });
    }
  };
  
  
  // Obter cursos por ID
  const getCourcesById = async (req: CourcesRequest, res: Response) => {
    const { courcesId } = req.params;
    
    try {
      console.log(`📥 Buscando cursos com ID: ${courcesId}`);
      const courcesDoc = await db.collection('cources').doc(courcesId).get();
      
      if (!courcesDoc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'cursos não encontrado'
        });
      }
      
      const courcesData = courcesDoc.data() as CourcesType;
         
      
      const cources = {
        ...courcesData,
        id: courcesDoc.id
      };
      
      return res.status(200).json({
        status: 'Success',
        data: cources
      });
    } catch (error) {
      console.error('❌ Erro ao buscar cursos:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar cursos'
      });
    }
  };
  
  // Atualizar cursos
  const updateCources = async (req: CourcesRequest, res: Response) => {
    const { courcesId } = req.params;
    const { name,
      phone,
      course,
      image,
      inscricoes,} = req.body;
    
    try {
      console.log(`📝 Atualizando cursos com ID: ${courcesId}`);
      const courcesRef = db.collection('cources').doc(courcesId);
      const doc = await courcesRef.get();
      
      if (!doc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'cursos não encontrado'
        });
      }
      
      const currentData = doc.data() as CourcesType;
      const updatedData: Partial<CourcesType> = {
        name: name || currentData.name,
        phone: phone || currentData.phone,
        course: course || currentData.course,
        image: image || currentData.image,
        inscricoes: inscricoes || currentData.inscricoes
      };
      
      await courcesRef.update(updatedData);
      
      // Obter o documento atualizado
      const updatedDoc = await courcesRef.get();
      const updatedCources = {
        ...updatedDoc.data() as CourcesType,
        id: updatedDoc.id
      };
      
      return res.status(200).json({
        status: 'Success',
        message: 'cursos atualizado com sucesso',
        data: updatedCources
      });
    } catch (error) {
      console.error('❌ Erro ao atualizar cursos:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao atualizar cursos'
      });
    }
  };
  
  // Deletar cursos
  const deleteCources = async (req: CourcesRequest, res: Response) => {
    const { courcesId } = req.params;
    
    try {
      console.log(`🗑️ Deletando cursos com ID: ${courcesId}`);
      const courcesRef = db.collection('cources').doc(courcesId);
      const doc = await courcesRef.get();
      
      if (!doc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'cursos não encontrado'
        });
      }
      
      // Deletar documento do Firestore
      await courcesRef.delete();
      
      return res.status(200).json({
        status: 'Success',
        message: 'cursos removido com sucesso'
      });
    } catch (error) {
      console.error('❌ Erro ao deletar cursos:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao deletar cursos'
      });
    }
  };
  
  export {
    createCources,
    getCources,
    getCourcesById,
    updateCources,
    deleteCources,
  };