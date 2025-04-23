


import { Response } from "express";
import { db } from "../../config/firebase";

// Type definitions
// Types
type EventType = {
  id?: string;
  title: string;
  description: string;
  imageUrl: string;
  capacity: number; // Number of available slots
  eventDate: string; // Date of the event
  createdAt?: string;
  location: string;
};

type RegistrationType = {
  id?: string;
  eventId: string;
  name: string;
  age: number;
  phone: string;
  church?: string; // Optional church field
  createdAt?: string;
};

type EventRequest = {
  body: EventType;
  params: { eventId: string };
};

type RegistrationRequest = {
  body: RegistrationType;
  params: { eventId: string; registrationId: string };
};

// Create Event Endpoint
const createEvent = async (req: EventRequest, res: Response) => {
  const { title, description, imageUrl, capacity, eventDate, location } = req.body;
  
  try {
    // Validate required fields
    if (!title || !description || !imageUrl || capacity === undefined || !eventDate) {
      return res.status(400).json({
        status: 'Error',
        message: 'Title, description, image, capacity, and event date are required'
      });
    }

    // Validate capacity is a positive number
    if (typeof capacity !== 'number' || capacity <= 0) {
      return res.status(400).json({
        status: 'Error',
        message: 'Capacity must be a positive number'
      });
    }

    // Validate event date is in the future
    const eventDateObj = new Date(eventDate);
    const now = new Date();
    if (eventDateObj < now) {
      return res.status(400).json({
        status: 'Error',
        message: 'Event date must be in the future'
      });
    }

    const newEventRef = db.collection('events').doc();
    const newEvent: EventType = {
      id: newEventRef.id,
      title,
      description,
      imageUrl,
      capacity,
      eventDate,
      location,
      createdAt: new Date().toISOString()
    };

    await newEventRef.set(newEvent);
    
    return res.status(201).json({
      status: 'Success',
      message: 'Event created successfully',
      data: newEvent
    });
  } catch (error) {
    return res.status(500).json({
      status: 'Error',
      message: error || 'Failed to create event'
    });
  }
};

// Get Events with Available Spots Count
const getEvents = async (_req: any, res: Response) => {
  try {
    const events: Array<EventType & { availableSpots: number }> = [];
    const querySnapshot = await db.collection('events')
      .orderBy('eventDate', 'asc') // First show upcoming events
      .get();
    
    // Get all events
    const eventDocs: EventType[] = [];
    querySnapshot.forEach((doc: any) => {
      eventDocs.push({
        ...doc.data(),
        id: doc.id
      });
    });
    
    // Get registration counts for each event
    for (const event of eventDocs) {
      if (!event.id) continue;
      
      const registrationsSnapshot = await db.collection('registrations')
        .where('eventId', '==', event.id)
        .get();
      
      const registrationCount = registrationsSnapshot.size;
      const availableSpots = event.capacity - registrationCount;
      
      events.push({
        ...event,
        availableSpots
      });
    }
    
    res.status(200).json({
      status: 'Success',
      data: events
    });
  } catch (error) {
    res.status(500).json({
      status: 'Error',
      message: error || 'Failed to fetch events'
    });
  }
};

// Get Event by ID with registration count
const getEventById = async (req: EventRequest, res: Response) => {
  const { eventId } = req.params;
  
  try {
    const eventDoc = await db.collection('events').doc(eventId).get();
    
    if (!eventDoc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Event not found'
      });
    }
    
    const event = eventDoc.data() as EventType;
    
    // Get registration count for this event
    const registrationsSnapshot = await db.collection('registrations')
      .where('eventId', '==', eventId)
      .get();
    
    const registrationCount = registrationsSnapshot.size;
    const availableSpots = event.capacity - registrationCount;
    
    return res.status(200).json({
      status: 'Success',
      data: {
        ...event,
        availableSpots,
        totalRegistrations: registrationCount
      }
    });
  } catch (error) {
    return res.status(500).json({
      status: 'Error',
      message: error || 'Failed to fetch event'
    });
  }
};

// Update Event
const updateEvent = async (req: EventRequest, res: Response) => {
  const { eventId } = req.params;
  const { title, description, imageUrl, capacity, eventDate, location } = req.body;
  
  try {
    const eventRef = db.collection('events').doc(eventId);
    const doc = await eventRef.get();
    
    if (!doc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Event not found'
      });
    }
    
    // If updating capacity, check if new capacity is valid
    if (capacity !== undefined) {
      if (typeof capacity !== 'number' || capacity <= 0) {
        return res.status(400).json({
          status: 'Error',
          message: 'Capacity must be a positive number'
        });
      }
      
      // Check if new capacity is less than current registrations
      const registrationsSnapshot = await db.collection('registrations')
        .where('eventId', '==', eventId)
        .get();
      
      const registrationCount = registrationsSnapshot.size;
      
      if (capacity < registrationCount) {
        return res.status(400).json({
          status: 'Error',
          message: `Cannot reduce capacity below current registration count (${registrationCount})`
        });
      }
    }
    
    // If updating event date, validate it's in the future
    if (eventDate) {
      const eventDateObj = new Date(eventDate);
      const now = new Date();
      if (eventDateObj < now) {
        return res.status(400).json({
          status: 'Error',
          message: 'Event date must be in the future'
        });
      }
    }
    
    const currentData = doc.data() as EventType;
    const updatedEvent = {
      ...currentData,
      title: title || currentData.title,
      description: description || currentData.description,
      imageUrl: imageUrl || currentData.imageUrl,
      capacity: capacity !== undefined ? capacity : currentData.capacity,
      eventDate: eventDate || currentData.eventDate,
      location: location || currentData.location,
    };
    
    await eventRef.update(updatedEvent);
    
    return res.status(200).json({
      status: 'Success',
      message: 'Event updated successfully',
      data: updatedEvent
    });
  } catch (error) {
    return res.status(500).json({
      status: 'Error',
      message: error || 'Failed to update event'
    });
  }
};

// Delete Event
const deleteEvent = async (req: EventRequest, res: Response) => {
  const { eventId } = req.params;
  
  try {
    const eventRef = db.collection('events').doc(eventId);
    const doc = await eventRef.get();
    
    if (!doc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Event not found'
      });
    }
    
    // Delete all registrations for this event first
    const registrationsSnapshot = await db.collection('registrations')
      .where('eventId', '==', eventId)
      .get();
    
    const batch = db.batch();
    registrationsSnapshot.forEach((doc) => {
      batch.delete(doc.ref);
    });
    
    // Delete the event
    batch.delete(eventRef);
    await batch.commit();
    
    return res.status(200).json({
      status: 'Success',
      message: 'Event and all associated registrations deleted successfully'
    });
  } catch (error) {
    return res.status(500).json({
      status: 'Error',
      message: error || 'Failed to delete event'
    });
  }
};

// Registration Management Endpoints
const registerForEvent = async (req: RegistrationRequest, res: Response) => {
  const { eventId } = req.params;
  const { name, age, phone, church } = req.body;
  
  try {
    // Validate required fields
    if (!name || !age || !phone) {
      return res.status(400).json({
        status: 'Error',
        message: 'Name, age, and phone are required'
      });
    }
    
    // Check if event exists
    const eventDoc = await db.collection('events').doc(eventId).get();
    if (!eventDoc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Event not found'
      });
    }
    
    const event = eventDoc.data() as EventType;
    
    // Check if the event date has passed
    const eventDate = new Date(event.eventDate);
    const now = new Date();
    if (eventDate < now) {
      return res.status(400).json({
        status: 'Error',
        message: 'Cannot register for past events'
      });
    }
    
    // Check if there are available spots
    const registrationsSnapshot = await db.collection('registrations')
      .where('eventId', '==', eventId)
      .get();
    
    const registrationCount = registrationsSnapshot.size;
    
    if (registrationCount >= event.capacity) {
      return res.status(409).json({
        status: 'Error',
        message: 'Event is at full capacity'
      });
    }
    
    // Check if user is already registered by phone number
    const existingRegistrations = await db.collection('registrations')
      .where('eventId', '==', eventId)
      .where('phone', '==', phone)
      .get();
      
    if (!existingRegistrations.empty) {
      return res.status(409).json({
        status: 'Error',
        message: 'You are already registered for this event'
      });
    }
    
    const newRegistrationRef = db.collection('registrations').doc();
    const newRegistration: RegistrationType = {
      id: newRegistrationRef.id,
      eventId,
      name,
      age,
      phone,
      church,
      createdAt: new Date().toISOString()
    };
    
    await newRegistrationRef.set(newRegistration);
    
    // Calculate remaining spots
    const remainingSpots = event.capacity - (registrationCount + 1);
    
    return res.status(201).json({
      status: 'Success',
      message: 'Registration successful',
      data: {
        registration: newRegistration,
        remainingSpots
      }
    });
  } catch (error) {
    return res.status(500).json({
      status: 'Error',
      message: error || 'Failed to register for event'
    });
  }
};

// Get All Registrations for an Event
const getEventRegistrations = async (req: RegistrationRequest, res: Response) => {
  const { eventId } = req.params;
  
  try {
    // Check if event exists
    const eventDoc = await db.collection('events').doc(eventId).get();
    if (!eventDoc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Event not found'
      });
    }
    
    const registrations: RegistrationType[] = [];
    const querySnapshot = await db.collection('registrations')
      .where('eventId', '==', eventId)
      .orderBy('createdAt', 'asc')
      .get();
      
    querySnapshot.forEach((doc: any) => registrations.push(doc.data()));
    
    const event = eventDoc.data() as EventType;
    const availableSpots = event.capacity - registrations.length;
    
    return res.status(200).json({
      status: 'Success',
      data: {
        registrations,
        totalRegistrations: registrations.length,
        capacity: event.capacity,
        availableSpots
      }
    });
  } catch (error) {
    return res.status(500).json({
      status: 'Error',
      message: error || 'Failed to fetch registrations'
    });
  }
};

// Delete Registration
const deleteRegistration = async (req: RegistrationRequest, res: Response) => {
  const { eventId, registrationId } = req.params;
  
  try {
    const registrationRef = db.collection('registrations').doc(registrationId);
    const doc = await registrationRef.get();
    
    if (!doc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Registration not found'
      });
    }
    
    const registration = doc.data() as RegistrationType;
    
    // Verify if registration belongs to the specified event
    if (registration.eventId !== eventId) {
      return res.status(400).json({
        status: 'Error',
        message: 'Registration does not belong to the specified event'
      });
    }
    
    await registrationRef.delete();
    
    // Get updated available spots
    const eventDoc = await db.collection('events').doc(eventId).get();
    const event = eventDoc.data() as EventType;
    
    const registrationsSnapshot = await db.collection('registrations')
      .where('eventId', '==', eventId)
      .get();
    
    const availableSpots = event.capacity - registrationsSnapshot.size;
    
    return res.status(200).json({
      status: 'Success',
      message: 'Registration canceled successfully',
      data: {
        availableSpots
      }
    });
  } catch (error) {
    return res.status(500).json({
      status: 'Error',
      message: error || 'Failed to cancel registration'
    });
  }
};

export {
  createEvent,
  getEvents,
  getEventById,
  updateEvent,
  deleteEvent,
  registerForEvent,
  getEventRegistrations,
  deleteRegistration
};