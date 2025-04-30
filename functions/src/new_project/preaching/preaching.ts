// Types and imports
import { db } from "../../config/firebase";
import { Request, Response } from 'express';

type PreachingType = {
  id?: string;
  title: string;
  author: string;
  date: string; // Date when the preaching should be featured
  description: string;
  audioUrl: string; // URL to the MP3 file (uploaded by frontend)
  imageUrl: string; // URL to the cover image (uploaded by frontend)
  duration?: number; // Duration in seconds (optional)
  createdAt?: string;
};

type PreachingRequest = Request & {
  body: PreachingType;
  params: { devotionalId: string };
};


// Create Preaching
const createPreaching = async (req: PreachingRequest, res: Response) => {
  console.log('📥 Creating new preaching...');
  try {
    const { title, author, date, description, audioUrl, imageUrl, duration } = req.body;

    // Validate required fields
    if (!title || !author || !date || !description || !audioUrl || !imageUrl) {
      return res.status(400).json({
        status: 'Error',
        message: 'Title, author, date, description, audio URL, and image URL are required'
      });
    }

    // Create new preaching document in Firestore
    const newPreachingRef = db.collection('preaching').doc();
    const newPreaching: PreachingType = {
      id: newPreachingRef.id,
      title,
      author,
      date,
      description,
      audioUrl,
      imageUrl,
      duration: duration || null,
      createdAt: new Date().toISOString(),
    };

    console.log('📝 Saving preaching metadata to Firestore...');
    await newPreachingRef.set(newPreaching);
    
    return res.status(201).json({
      status: 'Success',
      message: 'Preaching created successfully',
      data: newPreaching
    });
  } catch (error) {
    console.error('❌ Error creating preaching:', error);
    return res.status(500).json({
      status: 'Error',
      message: error?.toString() || 'Failed to create preaching'
    });
  }
};

// Get All Preachings
const getPreachings = async (_req: Request, res: Response) => {
  try {
    console.log('📥 Fetching all preaching...');
    const preaching: PreachingType[] = [];
    const querySnapshot = await db.collection('preaching')
      .orderBy('date', 'desc')
      .get();
    
    querySnapshot.forEach((doc) => {
      preaching.push({
        ...doc.data() as PreachingType,
        id: doc.id
      });
    });
    
    return res.status(200).json({
      status: 'Success',
      data: preaching
    });
  } catch (error) {
    console.error('❌ Error fetching preaching:', error);
    return res.status(500).json({
      status: 'Error',
      message: error?.toString() || 'Failed to fetch preaching'
    });
  }
};

// Get Preaching by ID
const getPreachingById = async (req: PreachingRequest, res: Response) => {
  const { devotionalId } = req.params;
  
  try {
    console.log(`📥 Fetching preaching with ID: ${devotionalId}`);
    const devotionalDoc = await db.collection('preaching').doc(devotionalId).get();
    
    if (!devotionalDoc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Preaching not found'
      });
    }
    
    const preaching = {
      ...devotionalDoc.data() as PreachingType,
      id: devotionalDoc.id
    };
    
    return res.status(200).json({
      status: 'Success',
      data: preaching
    });
  } catch (error) {
    console.error('❌ Error fetching preaching:', error);
    return res.status(500).json({
      status: 'Error',
      message: error?.toString() || 'Failed to fetch preaching'
    });
  }
};

// Update Preaching
const updatePreaching = async (req: PreachingRequest, res: Response) => {
  const { devotionalId } = req.params;
  const { title, author, date, description, audioUrl, imageUrl, duration } = req.body;
  
  try {
    console.log(`📝 Updating preaching with ID: ${devotionalId}`);
    const devotionalRef = db.collection('preaching').doc(devotionalId);
    const doc = await devotionalRef.get();
    
    if (!doc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Preaching not found'
      });
    }
    
    const currentData = doc.data() as PreachingType;
    const updatedData: Partial<PreachingType> = {
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
    const updatedPreaching = {
      ...updatedDoc.data() as PreachingType,
      id: updatedDoc.id
    };
    
    return res.status(200).json({
      status: 'Success',
      message: 'Preaching updated successfully',
      data: updatedPreaching
    });
  } catch (error) {
    console.error('❌ Error updating preaching:', error);
    return res.status(500).json({
      status: 'Error',
      message: error?.toString() || 'Failed to update preaching'
    });
  }
};

// Delete Preaching
const deletePreaching = async (req: PreachingRequest, res: Response) => {
  const { devotionalId } = req.params;
  
  try {
    console.log(`🗑️ Deleting preaching with ID: ${devotionalId}`);
    const devotionalRef = db.collection('preaching').doc(devotionalId);
    const doc = await devotionalRef.get();
    
    if (!doc.exists) {
      return res.status(404).json({
        status: 'Error',
        message: 'Preaching not found'
      });
    }
    
    // Delete document from Firestore
    await devotionalRef.delete();
    
    return res.status(200).json({
      status: 'Success',
      message: 'Preaching deleted successfully'
    });
  } catch (error) {
    console.error('❌ Error deleting preaching:', error);
    return res.status(500).json({
      status: 'Error',
      message: error?.toString() || 'Failed to delete preaching'
    });
  }
};


export {
  createPreaching,
  getPreachings,
  getPreachingById,
  updatePreaching,
  deletePreaching,
};