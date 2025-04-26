// Types and imports
import { db } from "../../config/firebase";
import { Request, Response } from 'express';

type DevotionalType = {
  id?: string;
  title: string;
  author: string;
  date: string; // Date when the devotional should be featured
  description: string;
  audioUrl: string; // URL to the MP3 file (uploaded by frontend)
  imageUrl: string; // URL to the cover image (uploaded by frontend)
  duration?: number; // Duration in seconds (optional)
  createdAt?: string;
};

type DevotionalRequest = Request & {
  body: DevotionalType;
  params: { devotionalId: string };
};


// Create Devotional
const createDevotional = async (req: DevotionalRequest, res: Response) => {
  console.log('📥 Creating new devotional...');
  try {
    const { title, author, date, description, audioUrl, imageUrl, duration } = req.body;

    // Validate required fields
    if (!title || !author || !date || !description || !audioUrl || !imageUrl) {
      return res.status(400).json({
        status: 'Error',
        message: 'Title, author, date, description, audio URL, and image URL are required'
      });
    }

    // Create new devotional document in Firestore
    const newDevotionalRef = db.collection('devotionals').doc();
    const newDevotional: DevotionalType = {
      id: newDevotionalRef.id,
      title,
      author,
      date,
      description,
      audioUrl,
      imageUrl,
      duration: duration || null,
      createdAt: new Date().toISOString(),
    };

    console.log('📝 Saving devotional metadata to Firestore...');
    await newDevotionalRef.set(newDevotional);
    
    return res.status(201).json({
      status: 'Success',
      message: 'Devotional created successfully',
      data: newDevotional
    });
  } catch (error) {
    console.error('❌ Error creating devotional:', error);
    return res.status(500).json({
      status: 'Error',
      message: error?.toString() || 'Failed to create devotional'
    });
  }
};

// Get All Devotionals
const getDevotionals = async (_req: Request, res: Response) => {
  try {
    console.log('📥 Fetching all devotionals...');
    const devotionals: DevotionalType[] = [];
    const querySnapshot = await db.collection('devotionals')
      .orderBy('date', 'desc')
      .get();
    
    querySnapshot.forEach((doc) => {
      devotionals.push({
        ...doc.data() as DevotionalType,
        id: doc.id
      });
    });
    
    return res.status(200).json({
      status: 'Success',
      data: devotionals
    });
  } catch (error) {
    console.error('❌ Error fetching devotionals:', error);
    return res.status(500).json({
      status: 'Error',
      message: error?.toString() || 'Failed to fetch devotionals'
    });
  }
};

// Get Devotional by ID
const getDevotionalById = async (req: DevotionalRequest, res: Response) => {
  const { devotionalId } = req.params;
  
  try {
    console.log(`📥 Fetching devotional with ID: ${devotionalId}`);
    const devotionalDoc = await db.collection('devotionals').doc(devotionalId).get();
    
    if (!devotionalDoc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Devotional not found'
      });
    }
    
    const devotional = {
      ...devotionalDoc.data() as DevotionalType,
      id: devotionalDoc.id
    };
    
    return res.status(200).json({
      status: 'Success',
      data: devotional
    });
  } catch (error) {
    console.error('❌ Error fetching devotional:', error);
    return res.status(500).json({
      status: 'Error',
      message: error?.toString() || 'Failed to fetch devotional'
    });
  }
};

// Update Devotional
const updateDevotional = async (req: DevotionalRequest, res: Response) => {
  const { devotionalId } = req.params;
  const { title, author, date, description, audioUrl, imageUrl, duration } = req.body;
  
  try {
    console.log(`📝 Updating devotional with ID: ${devotionalId}`);
    const devotionalRef = db.collection('devotionals').doc(devotionalId);
    const doc = await devotionalRef.get();
    
    if (!doc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Devotional not found'
      });
    }
    
    const currentData = doc.data() as DevotionalType;
    const updatedData: Partial<DevotionalType> = {
      title: title || currentData.title,
      author: author || currentData.author,
      date: date || currentData.date,
      description: description || currentData.description,
      audioUrl: audioUrl || currentData.audioUrl,
      imageUrl: imageUrl || currentData.imageUrl,
      duration: duration !== undefined ? duration : currentData.duration,
    };
    
    await devotionalRef.update(updatedData);
    
    // Get the updated document
    const updatedDoc = await devotionalRef.get();
    const updatedDevotional = {
      ...updatedDoc.data() as DevotionalType,
      id: updatedDoc.id
    };
    
    return res.status(200).json({
      status: 'Success',
      message: 'Devotional updated successfully',
      data: updatedDevotional
    });
  } catch (error) {
    console.error('❌ Error updating devotional:', error);
    return res.status(500).json({
      status: 'Error',
      message: error?.toString() || 'Failed to update devotional'
    });
  }
};

// Delete Devotional
const deleteDevotional = async (req: DevotionalRequest, res: Response) => {
  const { devotionalId } = req.params;
  
  try {
    console.log(`🗑️ Deleting devotional with ID: ${devotionalId}`);
    const devotionalRef = db.collection('devotionals').doc(devotionalId);
    const doc = await devotionalRef.get();
    
    if (!doc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Devotional not found'
      });
    }
    
    // Delete document from Firestore
    await devotionalRef.delete();
    
    return res.status(200).json({
      status: 'Success',
      message: 'Devotional deleted successfully'
    });
  } catch (error) {
    console.error('❌ Error deleting devotional:', error);
    return res.status(500).json({
      status: 'Error',
      message: error?.toString() || 'Failed to delete devotional'
    });
  }
};


export {
  createDevotional,
  getDevotionals,
  getDevotionalById,
  updateDevotional,
  deleteDevotional,
};