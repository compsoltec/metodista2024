import * as functions from "firebase-functions";
import * as express from 'express';
import { addNewHome, getHome, updateHome } from "./homeController";
import { addNewInscricoes, getInscricoes, updateInscricoes } from "./inscricoesController";

const app = express()

app.post('/home', addNewHome)
app.get('/home',getHome)
app.put('/home/:homeid',updateHome)



app.post('/inscricoes', addNewInscricoes)
app.get('/inscricoes',getInscricoes)
app.put('/inscricoes/:inscricoesid',updateInscricoes)
exports.app = functions.https.onRequest(app);
