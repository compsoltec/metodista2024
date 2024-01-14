import * as functions from "firebase-functions";
import * as express from 'express';
import { addNewHome, getHome, updateHome } from "./homeController";
import { addNewInscricoes, getInscricoes, updateInscricoes } from "./inscricoesController";
import { addNewAgendaTemplo, getAgendaTemplo, updateAgendaTemplo } from "./agendaTemploController";
import { addToken, getAllTokens } from "./tokenController";
import { addVideo, getAllVideo } from "./videoControllers";
import { addPastorais, getAllPastorais } from "./pastoraisControllers";
import { addLogin, getAllLogin } from "./loginControllers";

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

app.post('/token', addToken)
app.get('/token',getAllTokens)

app.post('/videos', addVideo)
app.get('/videos',getAllVideo)

app.post('/pastorais', addPastorais)
app.get('/pastorais',getAllPastorais)


app.post('/login', addLogin)
app.get('/login',getAllLogin)
exports.app = functions.https.onRequest(app);
