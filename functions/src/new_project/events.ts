import {Response} from "express"
import {db} from '../config/firebase'


type EventType = {
    id?: string;
    name: string;
    description: string;
    date: string;
};
type Request = {
    body: EventType,
    params: {eventId: string}
}

const addEvent = async (req: Request, res: Response) => {
    const { name, description, date } = req.body;

    try {
        const newEventRef = db.collection('events').doc();
        const newEvent = {
            id: newEventRef.id,
            name,
            description,
            date
        };

        await newEventRef.set(newEvent);
        res.status(200).json({
            status: 'Success',
            message: 'Event added successfully',
            data: newEvent
        });
    } catch (error) {
        res.status(500).json({
            status: 'Error',
            message: error
        });
    }
};


const getEvents = async (req: Request, res: Response) => {
    try {
        const events: EventType[] = [];
        const today = new Date().toISOString().slice(0, 10); // Current date in YYYY-MM-DD format
        const querySnapshot = await db.collection('events')
                                      .orderBy('date')
                                      .startAt(today)
                                      .get();

        querySnapshot.forEach((doc: any) => events.push(doc.data()));

        res.status(200).json({
            status: 'Success',
            data: events
        });
    } catch (error) {
        res.status(500).json({
            status: 'Error',
            message: error
        });
    }
};
const deleteEvent = async (req: Request, res: Response) => {
    const { eventId } = req.params; 
    try {
        await db.collection('events').doc(eventId).delete();
        res.status(200).json({
            status: 'Success',
            message: 'Event deleted successfully'
        });
    } catch (error) {
        res.status(500).json({
            status: 'Error',
            message: error
        });
    }
};
const updateEvent = async (req: Request, res: Response) => {
    const { eventId } = req.params; 
    const { name, description, date } = req.body; // Dados para atualização

    try {
        const eventRef = db.collection('events').doc(eventId);
        const doc = await eventRef.get();

        if (!doc.exists) {
            return res.status(404).json({ status: 'Error', message: 'Event not found' });
        }

        const currentData = doc.data() || {};

        const updatedEvent = {
            name: name || currentData.name,
            description: description || currentData.description,
            date: date || currentData.date
        };

        await eventRef.set(updatedEvent); // Atualiza o documento com novos dados ou mantém os antigos se não forem fornecidos novos.
        return res.status(200).json({
            status: 'Success',
            message: 'Event updated successfully',
            data: updatedEvent
        });
    } catch (error) {
        return res.status(500).json({
            status: 'Error',
            message: error
        });
    }
};

export{addEvent,getEvents,updateEvent,deleteEvent}
