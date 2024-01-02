import * as functions from "firebase-functions";
import * as express from 'express';
import { addNewHome, getHome, updateHome } from "./homeController";

const app = express()

app.post('/home', addNewHome)
app.get('/home',getHome)
app.put('/home/:homeid',updateHome)

exports.app = functions.https.onRequest(app);
