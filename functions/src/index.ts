import * as functions from "firebase-functions";
import * as express from 'express';
import { addNewHome, getHome, updateHome } from "./homeController";
import { addNewInscricoes, getInscricoes, updateInscricoes } from "./inscricoesController";
import { addNewAgendaTemplo, getAgendaTemplo, updateAgendaTemplo } from "./agendaTemploController";

const app = express()

app.post('/home', addNewHome)
app.get('/home',getHome)
app.put('/home/:homeid',updateHome)

app.post('/inscricoes', addNewInscricoes)
app.get('/inscricoes',getInscricoes)
app.put('/inscricoes/:inscricoesid',updateInscricoes)

app.post('/templo', addNewAgendaTemplo)
app.get('/templo',getAgendaTemplo)
app.put('/templo/:temploid',updateAgendaTemplo)
exports.app = functions.https.onRequest(app);
