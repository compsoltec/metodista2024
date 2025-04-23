import * as functions from "firebase-functions";
import * as express from "express";
import { addNewHome, getHome, updateHome } from "./homeController";
import { addNewAgendaTemplo, getAgendaTemplo, updateAgendaTemplo } from "./agendaTemploController";
import { addToken, getAllTokens } from "./tokenController";
import { addVideo, getAllVideo } from "./videoControllers";
import { addPastorais, getAllPastorais } from "./pastoraisControllers";
import { addAtividades, addInscritosHomolog, updateAtividades, deleteAtividades, deleteInscritoHomolog, getAllAtividades, getAllInscritosHomolog, getUInscritosBytoken } from "./inscricoesController";
import { addusers, getAllusers, updateUsers, deleteusers, getUsersByUuid } from "./usersController";
import { addLogin, getAllLogin } from "./loginControllers";
import { addEscalas, getAllEscalas } from "./escalasControllers";
import { addNewAcesso, addNewAcessoUser, getAcesso, getAcessoUser, solicitarAcesso } from "./acessoControllers";
import { addNewCadastro, getCadastro } from "./cadastroControllers";
import { 
  createEvent, 
  deleteEvent, 
  getEvents, 
  updateEvent, 
  getEventById 
} from "./new_project/events/events";
import { 
  registerForEvent, 
  getEventRegistrations, 
  deleteRegistration 
} from "./new_project/events/events";

// Express app setup
const app = express();

// Middleware para parsing de JSON
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Rotas de Home
app.post('/home', addNewHome);
app.get('/home', getHome);
app.put('/home/:homeid', updateHome);

// Rotas de Atividades
app.post('/atividades', addAtividades);
app.post('/atividades/:atividadesId/inscricao', addInscritosHomolog);
app.delete('/atividades/:atividadesId/inscricao/:inscritoId', deleteInscritoHomolog);
app.get('/atividades', getAllAtividades);
app.get('/atividades/:atividadesId/inscricao', getAllInscritosHomolog);
app.put('/atividades/:atividadesId', updateAtividades);
app.delete('/atividades/:atividadesId', deleteAtividades);
app.get('/atividades/:atividadesId/inscricao/:token', getUInscritosBytoken);

// Rotas de Agenda Templo
app.post('/templo', addNewAgendaTemplo);
app.get('/templo', getAgendaTemplo);
app.put('/templo/:temploid', updateAgendaTemplo);

// Rotas de Token
app.post('/token', addToken);
app.get('/token', getAllTokens);

// Rotas de Vídeos
app.post('/videos', addVideo);
app.get('/videos', getAllVideo);

// Rotas de Pastorais
app.post('/pastorais', addPastorais);
app.get('/pastorais', getAllPastorais);

// Rotas de Usuários
app.post('/users', addusers);
app.get('/users', getAllusers);
app.get('/users/:token', getUsersByUuid);
app.put('/users/:usersId', updateUsers);
app.delete('/users/:usersId', deleteusers);

// Rotas de Login
app.post('/login', addLogin);
app.get('/login', getAllLogin);

// Rotas de Escalas
app.post('/escalas', addEscalas);
app.get('/escalas', getAllEscalas);

// Rotas de Acesso
app.post('/acesso', addNewAcesso);
app.post('/solicitarAcesso', solicitarAcesso);
app.get('/acesso', getAcesso);
app.post('/acesso/:acessoid', addNewAcessoUser);
app.get('/acesso/:acessoid/token/:token', getAcessoUser);

// Rotas de Cadastro
app.get('/cadastro', getCadastro);
app.post('/cadastro', addNewCadastro);

// Rotas de Evento (nova implementação)
app.post('/events', createEvent);
app.get('/events', getEvents);
app.get('/events/:eventId', getEventById);
app.put('/events/:eventId', updateEvent);
app.delete('/events/:eventId', deleteEvent);

// Rotas para Inscrições de Eventos (nova implementação)
app.post('/events/:eventId/register', registerForEvent);
app.get('/events/:eventId/registrations', getEventRegistrations);
app.delete('/events/:eventId/registrations/:registrationId', deleteRegistration);

// Exporta a função para a Firebase Cloud Functions
exports.app = functions.https.onRequest(app);