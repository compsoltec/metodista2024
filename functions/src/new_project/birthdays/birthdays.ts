// Types and imports
import { db } from "../../config/firebase";
import { Request, Response } from 'express';

type BirthdayType = {
    id?: string;
    name: string;
    birthDate: string; // Data de aniversário no formato ISO
    isBirthdayToday?: boolean; // Indica se é aniversariante do dia atual
    createdAt?: string;
  };
  
  type BirthdayRequest = Request & {
    body: BirthdayType;
    params: { birthdayId: string };
  };
  
  // Função auxiliar para verificar se é aniversário hoje
  const isBirthdayToday = (birthDate: string): boolean => {
    const today = new Date();
    const bDate = new Date(birthDate);
    
    return today.getDate() === bDate.getDate() && 
           today.getMonth() === bDate.getMonth();
  };
  
  // Função auxiliar para calcular dias até o próximo aniversário
  const getDaysUntilNextBirthday = (birthDate: string): number => {
    const today = new Date();
    const bDate = new Date(birthDate);
    
    // Ajustar para o ano atual
    bDate.setFullYear(today.getFullYear());
    
    // Se o aniversário já passou este ano, ajustar para o próximo ano
    if (bDate < today) {
      bDate.setFullYear(today.getFullYear() + 1);
    }
    
    // Calcular diferença em dias
    const diffTime = Math.abs(bDate.getTime() - today.getTime());
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    
    return diffDays;
  };
  
  // Criar Aniversariante
  const createBirthday = async (req: BirthdayRequest, res: Response) => {
    console.log('📥 Criando novo aniversariante...');
    try {
      const { name, birthDate } = req.body;
  
      // Validar campos obrigatórios
      if (!name || !birthDate) {
        return res.status(400).json({
          status: 'Error',
          message: 'Nome e data de aniversário são obrigatórios'
        });
      }
  
      // Criar novo documento de aniversariante no Firestore
      const newBirthdayRef = db.collection('birthdays').doc();
      const newBirthday: BirthdayType = {
        id: newBirthdayRef.id,
        name,
        birthDate,
        isBirthdayToday: isBirthdayToday(birthDate),
        createdAt: new Date().toISOString(),
      };
  
      console.log('📝 Salvando dados do aniversariante no Firestore...');
      await newBirthdayRef.set(newBirthday);
      
      return res.status(201).json({
        status: 'Success',
        message: 'Aniversariante adicionado com sucesso',
        data: newBirthday
      });
    } catch (error) {
      console.error('❌ Erro ao criar aniversariante:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao adicionar aniversariante'
      });
    }
  };
  
  // Obter Todos os Aniversariantes (ordenados por proximidade da data)
  const getBirthdays = async (_req: Request, res: Response) => {
    try {
      console.log('📥 Buscando todos os aniversariantes...');
      const birthdays: BirthdayType[] = [];
      const querySnapshot = await db.collection('birthdays').get();
      
      // Coleta todos os aniversariantes
      querySnapshot.forEach((doc) => {
        const birthdayData = doc.data() as BirthdayType;
        
        // Atualiza o status de aniversariante do dia
        birthdayData.isBirthdayToday = isBirthdayToday(birthdayData.birthDate);
        
        birthdays.push({
          ...birthdayData,
          id: doc.id
        });
      });
      
      // Ordena por proximidade da data de aniversário
      birthdays.sort((a, b) => {
        const daysUntilA = getDaysUntilNextBirthday(a.birthDate);
        const daysUntilB = getDaysUntilNextBirthday(b.birthDate);
        return daysUntilA - daysUntilB;
      });
      
      return res.status(200).json({
        status: 'Success',
        data: birthdays
      });
    } catch (error) {
      console.error('❌ Erro ao buscar aniversariantes:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar aniversariantes'
      });
    }
  };
  
  // Obter Aniversariantes do Dia
  const getBirthdaysToday = async (_req: Request, res: Response) => {
    try {
      console.log('📥 Buscando aniversariantes do dia...');
      const birthdays: BirthdayType[] = [];
      const querySnapshot = await db.collection('birthdays').get();
      
      querySnapshot.forEach((doc) => {
        const birthdayData = doc.data() as BirthdayType;
        
        if (isBirthdayToday(birthdayData.birthDate)) {
          birthdays.push({
            ...birthdayData,
            id: doc.id,
            isBirthdayToday: true
          });
        }
      });
      
      // Ordenar por nome
      birthdays.sort((a, b) => a.name.localeCompare(b.name));
      
      return res.status(200).json({
        status: 'Success',
        data: birthdays
      });
    } catch (error) {
      console.error('❌ Erro ao buscar aniversariantes do dia:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar aniversariantes do dia'
      });
    }
  };
  
  // Obter Aniversariante por ID
  const getBirthdayById = async (req: BirthdayRequest, res: Response) => {
    const { birthdayId } = req.params;
    
    try {
      console.log(`📥 Buscando aniversariante com ID: ${birthdayId}`);
      const birthdayDoc = await db.collection('birthdays').doc(birthdayId).get();
      
      if (!birthdayDoc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'Aniversariante não encontrado'
        });
      }
      
      const birthdayData = birthdayDoc.data() as BirthdayType;
      
      // Atualiza o status de aniversariante do dia
      birthdayData.isBirthdayToday = isBirthdayToday(birthdayData.birthDate);
      
      const birthday = {
        ...birthdayData,
        id: birthdayDoc.id
      };
      
      return res.status(200).json({
        status: 'Success',
        data: birthday
      });
    } catch (error) {
      console.error('❌ Erro ao buscar aniversariante:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao buscar aniversariante'
      });
    }
  };
  
  // Atualizar Aniversariante
  const updateBirthday = async (req: BirthdayRequest, res: Response) => {
    const { birthdayId } = req.params;
    const { name, birthDate } = req.body;
    
    try {
      console.log(`📝 Atualizando aniversariante com ID: ${birthdayId}`);
      const birthdayRef = db.collection('birthdays').doc(birthdayId);
      const doc = await birthdayRef.get();
      
      if (!doc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'Aniversariante não encontrado'
        });
      }
      
      const currentData = doc.data() as BirthdayType;
      const updatedData: Partial<BirthdayType> = {
        name: name || currentData.name,
        birthDate: birthDate || currentData.birthDate,
        isBirthdayToday: birthDate ? isBirthdayToday(birthDate) : isBirthdayToday(currentData.birthDate),
      };
      
      await birthdayRef.update(updatedData);
      
      // Obter o documento atualizado
      const updatedDoc = await birthdayRef.get();
      const updatedBirthday = {
        ...updatedDoc.data() as BirthdayType,
        id: updatedDoc.id
      };
      
      return res.status(200).json({
        status: 'Success',
        message: 'Aniversariante atualizado com sucesso',
        data: updatedBirthday
      });
    } catch (error) {
      console.error('❌ Erro ao atualizar aniversariante:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao atualizar aniversariante'
      });
    }
  };
  
  // Deletar Aniversariante
  const deleteBirthday = async (req: BirthdayRequest, res: Response) => {
    const { birthdayId } = req.params;
    
    try {
      console.log(`🗑️ Deletando aniversariante com ID: ${birthdayId}`);
      const birthdayRef = db.collection('birthdays').doc(birthdayId);
      const doc = await birthdayRef.get();
      
      if (!doc.exists) {
        return res.status(404).json({
          status: 'Error',
          message: 'Aniversariante não encontrado'
        });
      }
      
      // Deletar documento do Firestore
      await birthdayRef.delete();
      
      return res.status(200).json({
        status: 'Success',
        message: 'Aniversariante removido com sucesso'
      });
    } catch (error) {
      console.error('❌ Erro ao deletar aniversariante:', error);
      return res.status(500).json({
        status: 'Error',
        message: error?.toString() || 'Falha ao deletar aniversariante'
      });
    }
  };
  
  export {
    createBirthday,
    getBirthdays,
    getBirthdaysToday,
    getBirthdayById,
    updateBirthday,
    deleteBirthday,
  };