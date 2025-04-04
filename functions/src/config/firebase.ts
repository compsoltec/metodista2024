import * as admin from 'firebase-admin'

admin.initializeApp();

const db = admin.firestore()
const dbAuth = admin.auth()

export {admin, db,dbAuth}