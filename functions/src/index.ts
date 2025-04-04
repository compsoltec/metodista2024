import * as functions from "firebase-functions";
import * as express from 'express';
import { addNewHome, getHome, updateHome } from "./homeController";
import { addNewAgendaTemplo, getAgendaTemplo, updateAgendaTemplo } from "./agendaTemploController";
import { addToken, getAllTokens } from "./tokenController";
import { addVideo, getAllVideo } from "./videoControllers";
import { addPastorais, getAllPastorais } from "./pastoraisControllers";
import { addAtividades,addInscritosHomolog,updateAtividades, deleteAtividades,deleteInscritoHomolog, getAllAtividades, getAllInscritosHomolog,getUInscritosBytoken } from "./inscricoesController";
import { addusers, getAllusers, updateUsers, deleteusers, getUsersByUuid } from "./usersController";
import { addLogin ,getAllLogin} from "./loginControllers";
import { addEscalas, getAllEscalas } from "./escalasControllers";
import { addNewAcesso, addNewAcessoUser, getAcesso, getAcessoUser, solicitarAcesso } from "./acessoControllers";
import { addNewCadastro, getCadastro } from "./cadastroControllers";
import { addEvent, deleteEvent, getEvents, updateEvent } from "./new_project/events";


const app = express()

app.post('/home', addNewHome)
app.get('/home',getHome)
app.put('/home/:homeid',updateHome)

app.post('/atividades', addAtividades)
app.post('/atividades/:atividadesId/inscricao', addInscritosHomolog)
app.delete('/atividades/:atividadesId/inscricao/:inscritoId', deleteInscritoHomolog)
app.get('/atividades',getAllAtividades)
app.get('/atividades/:atividadesId/inscricao', getAllInscritosHomolog)
app.put('/atividades/:atividadesId', updateAtividades)
app.delete('/atividades/:atividadesId', deleteAtividades)
app.get('/atividades/:atividadesId/inscricao/:token',getUInscritosBytoken)

app.post('/templo', addNewAgendaTemplo)
app.get('/templo',getAgendaTemplo)
app.put('/templo/:temploid',updateAgendaTemplo)

app.post('/token', addToken)
app.get('/token',getAllTokens)

app.post('/videos', addVideo)
app.get('/videos',getAllVideo)

app.post('/pastorais', addPastorais)
app.get('/pastorais',getAllPastorais)


app.post('/users', addusers)
app.get('/users',getAllusers)
app.get('/users/:token',getUsersByUuid)
app.put('/users/:usersId', updateUsers)
app.delete('/users/:usersId', deleteusers)


app.post('/login', addLogin)
app.get('/login',getAllLogin)

app.post('/escalas', addEscalas)
app.get('/escalas',getAllEscalas)

app.post('/acesso', addNewAcesso)
app.post('/solicitarAcesso', solicitarAcesso)
app.get('/acesso', getAcesso),
app.post('/acesso/:acessoid', addNewAcessoUser),
app.get('/acesso/:acessoid/token/:token', getAcessoUser),


app.get('/cadastro', getCadastro)
app.post('/cadastro', addNewCadastro)

//event

app.post('/events',addEvent)
app.get('/events', getEvents)
app.put('/events/:eventId', updateEvent)
app.delete('/events/:eventId',deleteEvent)

exports.app = functions.https.onRequest(app);
