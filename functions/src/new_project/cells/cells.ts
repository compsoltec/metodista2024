// Types and imports
import { db } from "../../config/firebase";
import { Request, Response } from 'express';

type CellsType = {
    id?: string;
    name: string;
    phone: string; 
    course?: string; // Indica se é celulas do dia atual
    image?: string;
    inscricoes?:boolean,
    capacity?: number
  };

  type CellsRequest = Request & {
    body: CellsType;
    params: { courcesId: string };
  };
  
  // Criar celulas
  const createCells = async (req: CellsRequest, res: Response) => {
    console.log('📥 Criando novo celulas...');
    try {
      const { name, phone,course, image ,inscricoes,capacity} = req.body;
      
  
      // Criar novo documento de celulas no Firestore
      const newCellsRef = db.collection('cells').doc();
      const newCells: CellsType = {
        id: newCellsRef.id,
        name,
        phone,
        course,
        image,
        inscricoes: inscricoes ?? false, 
        capacity: capacity ?? 0, 

      };


      console.log('📝 Salvando dados do celulas no Firestore...');
      await newCellsRef.set(newCells);
      
      return res.status(201).json({
        status: 'Success',
        message: 'celulas adicionado com sucesso',
        data: newCells
      });
    } catch (error) {
      console.error('❌ Erro ao criar celulas:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao adicionar celulas'
      });
    }
  };
  
  // Obter Todos os celulas (ordenados por proximidade da data)


  const getCells = async (_req: Request, res: Response) => {
    try {
      console.log('📥 Buscando todos os celulas...');
      const cells: CellsType[] = [];
      const querySnapshot = await db.collection('cells').get();
      
      // Coleta todos os celulas
      querySnapshot.forEach((doc) => {
        cells.push({
          ...doc.data() as CellsType,
          id: doc.id
        });
      });
    
      return res.status(200).json({
        status: 'Success',
        data: cells
      });
    } catch (error) {
      console.error('❌ Erro ao buscar celulas:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar celulas'
      });
    }
  };
  
  
  // Obter celulas por ID
  const getCellsById = async (req: CellsRequest, res: Response) => {
    const { courcesId } = req.params;
    
    try {
      console.log(`📥 Buscando celulas com ID: ${courcesId}`);
      const courcesDoc = await db.collection('cells').doc(courcesId).get();
      
      if (!courcesDoc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'celulas não encontrado'
        });
      }
      
      const courcesData = courcesDoc.data() as CellsType;
         
      
      const cells = {
        ...courcesData,
        id: courcesDoc.id
      };
      
      return res.status(200).json({
        status: 'Success',
        data: cells
      });
    } catch (error) {
      console.error('❌ Erro ao buscar celulas:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar celulas'
      });
    }
  };
  
  // Atualizar celulas
  const updateCells = async (req: CellsRequest, res: Response) => {
    const { courcesId } = req.params;
    const { name,
      phone,
      course,
      image,
      inscricoes,} = req.body;
    
    try {
      console.log(`📝 Atualizando celulas com ID: ${courcesId}`);
      const courcesRef = db.collection('cells').doc(courcesId);
      const doc = await courcesRef.get();
      
      if (!doc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'celulas não encontrado'
        });
      }
      
      const currentData = doc.data() as CellsType;
      const updatedData: Partial<CellsType> = {
        name: name || currentData.name,
        phone: phone || currentData.phone,
        course: course || currentData.course,
        image: image || currentData.image,
        inscricoes: inscricoes || currentData.inscricoes
      };
      
      await courcesRef.update(updatedData);
      
      // Obter o documento atualizado
      const updatedDoc = await courcesRef.get();
      const updatedCells = {
        ...updatedDoc.data() as CellsType,
        id: updatedDoc.id
      };
      
      return res.status(200).json({
        status: 'Success',
        message: 'celulas atualizado com sucesso',
        data: updatedCells
      });
    } catch (error) {
      console.error('❌ Erro ao atualizar celulas:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao atualizar celulas'
      });
    }
  };
  
  // Deletar celulas
  const deleteCells = async (req: CellsRequest, res: Response) => {
    const { courcesId } = req.params;
    
    try {
      console.log(`🗑️ Deletando celulas com ID: ${courcesId}`);
      const courcesRef = db.collection('cells').doc(courcesId);
      const doc = await courcesRef.get();
      
      if (!doc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'celulas não encontrado'
        });
      }
      
      // Deletar documento do Firestore
      await courcesRef.delete();
      
      return res.status(200).json({
        status: 'Success',
        message: 'celulas removido com sucesso'
      });
    } catch (error) {
      console.error('❌ Erro ao deletar celulas:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao deletar celulas'
      });
    }
  };
  
  export {
    createCells,
    getCells,
    getCellsById,
    updateCells,
    deleteCells,
  };