import {Response} from "express"
import {db} from '../../config/firebase'


type Subscription = {
    id?: string;
    eventId: string;
    name: string;
    age: number;
    phone: string;
    token: string;
    createdAt: string;
  };
  
  type SubscriptionRequest = {
    body: {
      eventId: string;
      name: string;
      age: number;
      phone: string;
      token: string;
    };
    params: {
      subscriptionId?: string;
      eventId?: string;
    };
    query: {
      eventId?: string;
      token?: string;
    };
  };
  
  const subscribeToEvent = async (req: SubscriptionRequest, res: Response): Promise<void> => {
    const { eventId, name, age, phone, token } = req.body;
    
    if (!eventId || !name || !age || !phone || !token) {
       res.status(400).json({
        status: 'Error',
        message: 'Todos os campos são obrigatórios'
      });
      return;
    }
    
  
    try {
      // Verificar se o evento existe
      const eventDoc = await db.collection('events').doc(eventId).get();
      
      if (!eventDoc.exists) {
         res.status(404).json({
          status: 'Error',
          message: 'Evento não encontrado'
        });
        return;
      }
  
      const existingSubscriptions = await db.collection('subscriptions')
        .where('eventId', '==', eventId)
        .where('phone', '==', phone)
        .get();
  
      if (!existingSubscriptions.empty) {
         res.status(400).json({
          status: 'Error',
          message: 'Você já está inscrito neste evento'
        });
        return;
      }
  
      // Criar nova inscrição
      const newSubscriptionRef = db.collection('subscriptions').doc();
      const newSubscription: Subscription = {
        id: newSubscriptionRef.id,
        eventId,
        name,
        age,
        phone,
        token,
        createdAt: new Date().toISOString()
      };
  
      await newSubscriptionRef.set(newSubscription);
  
      res.status(200).json({
        status: 'Success',
        message: 'Inscrição realizada com sucesso',
        data: {
          subscriptionId: newSubscription.id,
          eventId: newSubscription.eventId
        }
      });
    } catch (error) {
      console.error('Erro ao inscrever no evento:', error);
      res.status(500).json({
        status: 'Error',
        message: 'Erro ao processar a inscrição'
      });
    }
  };
  const getSubscriptionByEventAndToken = async (req: SubscriptionRequest, res: Response): Promise<void> => {
    const { eventId, token } = req.query;
  
    if (!eventId || !token) {
      res.status(400).json({
        status: 'Error',
        message: 'EventId e token são obrigatórios',
      });
      return;
    }
  
    try {
      const querySnapshot = await db
        .collection('subscriptions')
        .where('eventId', '==', eventId)
        .where('token', '==', token)
        .limit(1)
        .get();
  
      if (querySnapshot.empty) {
        res.status(404).json({
          status: 'Error',
          message: 'Inscrição não encontrada para este evento e token',
        });
        return;
      }
  
      const doc = querySnapshot.docs[0];
      const data = doc.data() as Subscription;
  
      res.status(200).json({
        status: 'Success',
        data,
      });
    } catch (error) {
      console.error('Erro ao buscar inscrição por evento e token:', error);
      res.status(500).json({
        status: 'Error',
        message: 'Erro interno ao buscar inscrição',
      });
    }
  };
  
  // Complemento: Endpoint para obter detalhes de uma inscrição específica
  const getSubscriptionById = async (req: SubscriptionRequest, res: Response): Promise<void> =>{
    const { subscriptionId } = req.params;
  
    if (!subscriptionId) {
       res.status(400).json({
        status: 'Error',
        message: 'ID da inscrição é obrigatório'
      });
      return;
    }
  
    try {
        const subscriptionDoc = await db.collection('subscriptions').doc(subscriptionId).get();
    
        if (!subscriptionDoc.exists) {
           res.status(404).json({
            status: 'Error',
            message: 'Inscrição não encontrada'
          });
          return;
        }
    
        const subscriptionData = subscriptionDoc.data() as any; // Fazendo cast explícito
        
        // Verificando se os campos existem antes de usá-los
        const subscription = {
          id: subscriptionData?.id || '',
          eventId: subscriptionData?.eventId || '',
          name: subscriptionData?.name || '',
          age: subscriptionData?.age || 0,
          phone: subscriptionData?.phone || '',
          createdAt: subscriptionData?.createdAt || new Date().toISOString()
        };
    
        res.status(200).json({
          status: 'Success',
          data: subscription
        });
    } catch (error) {
      console.error('Erro ao buscar detalhes da inscrição:', error);
      res.status(500).json({
        status: 'Error',
        message: 'Erro ao buscar detalhes da inscrição'
      });
    }
  };
  
  // Endpoint para cancelar inscrição em um evento
  const cancelSubscription = async (req: SubscriptionRequest, res: Response) : Promise<void> => {
    const { subscriptionId } = req.params;
    const { token } = req.body;
  
    if (!subscriptionId || !token) {
       res.status(400).json({
        status: 'Error',
        message: 'ID da inscrição e token são obrigatórios'
      });
      return;
    }
  
    try {
      // Buscar a inscrição
      const subscriptionRef = db.collection('subscriptions').doc(subscriptionId);
      const subscriptionDoc = await subscriptionRef.get();
  
      if (!subscriptionDoc.exists) {
         res.status(404).json({
          status: 'Error',
          message: 'Inscrição não encontrada'
        });
        return;
      }
  
      const subscriptionData = subscriptionDoc.data() as Subscription;
  
      // Verificar se o token fornecido corresponde ao token registrado
      if (subscriptionData.token !== token) {
         res.status(403).json({
          status: 'Error',
          message: 'Token inválido. Você não tem permissão para cancelar esta inscrição'
        });
        return;
      }
  
      // Cancelar a inscrição (excluir o documento)
      await subscriptionRef.delete();
  
      res.status(200).json({
        status: 'Success',
        message: 'Inscrição cancelada com sucesso'
      });
    } catch (error) {
      console.error('Erro ao cancelar inscrição:', error);
      res.status(500).json({
        status: 'Error',
        message: 'Erro ao processar o cancelamento da inscrição'
      });
    }
  };
  
  export{subscribeToEvent, getSubscriptionByEventAndToken, getSubscriptionById ,cancelSubscription}