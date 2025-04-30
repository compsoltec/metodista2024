import * as functions from "firebase-functions";
import * as express from "express";

// Controllers Importados
import { addNewHome, getHome, updateHome } from "./homeController";
import { addNewAgendaTemplo, getAgendaTemplo, updateAgendaTemplo } from "./agendaTemploController";
import { addToken, getAllTokens } from "./tokenController";
import { addVideo, getAllVideo } from "./videoControllers";
import { addPastorais, getAllPastorais } from "./pastoraisControllers";
import { 
  addAtividades, addInscritosHomolog, updateAtividades, 
  deleteAtividades, deleteInscritoHomolog, getAllAtividades, 
  getAllInscritosHomolog, getUInscritosBytoken,
} from "./inscricoesController";
import { addusers, getAllusers, updateUsers, deleteusers, getUsersByUuid } from "./usersController";
import { addLogin, getAllLogin } from "./loginControllers";
import { addEscalas, getAllEscalas } from "./escalasControllers";
import { addNewAcesso, addNewAcessoUser, getAcesso, getAcessoUser, solicitarAcesso } from "./acessoControllers";
import { addNewCadastro, getCadastro, } from "./cadastroControllers";

// Novos Controllers de Eventos
import { 
  createEvent, 
  deleteEvent, 
  getEvents, 
  updateEvent, 
  getEventById,
  registerForEvent, 
  getEventRegistrations, 
  deleteRegistration,
  getRegistrationsByFcmToken
} from "./new_project/events/events";
import { createDevotional , getDevotionals, getDevotionalById,updateDevotional,deleteDevotional} from "./new_project/devocional/devocional";
import { createPreaching, deletePreaching, getPreachingById, getPreachings, updatePreaching } from "./new_project/preaching/preaching";
import { createBirthday, getBirthdays, getBirthdaysToday,getBirthdayById,updateBirthday,deleteBirthday } from "./new_project/birthdays/birthdays";
import { createPastoral,getPastorals, getPastoralById,updatePastoral,deletePastoral } from "./new_project/pastoral/pastoral";
import { createCources,getCources,getCourcesById,updateCources ,deleteCources} from "./new_project/cources/courses";
import { createCells,getCells,getCellsById,updateCells,deleteCells } from "./new_project/cells/cells";
import { createNotices, deleteNotices, getNotices, getNoticesById, updateNotices } from "./new_project/notices/notices";


// Inicialização do Express
const app = express();

// Middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// --------------------- ROTAS ---------------------

// 📌 Home
app.post('/home', addNewHome);
app.get('/home', getHome);
app.put('/home/:homeid', updateHome);

// 📌 Atividades e Inscrições
app.post('/atividades', addAtividades);
app.post('/atividades/:atividadesId/inscricao', addInscritosHomolog);
app.delete('/atividades/:atividadesId/inscricao/:inscritoId', deleteInscritoHomolog);
app.get('/atividades', getAllAtividades);
app.get('/atividades/:atividadesId/inscricao', getAllInscritosHomolog);
app.put('/atividades/:atividadesId', updateAtividades);
app.delete('/atividades/:atividadesId', deleteAtividades);
app.get('/atividades/:atividadesId/inscricao/:token', getUInscritosBytoken);

// 📌 Agenda Templo
app.post('/templo', addNewAgendaTemplo);
app.get('/templo', getAgendaTemplo);
app.put('/templo/:temploid', updateAgendaTemplo);

// 📌 Tokens
app.post('/token', addToken);
app.get('/token', getAllTokens);

// 📌 Vídeos
app.post('/videos', addVideo);
app.get('/videos', getAllVideo);

// 📌 Pastorais
app.post('/pastorais', addPastorais);
app.get('/pastorais', getAllPastorais);

// 📌 Usuários
app.post('/users', addusers);
app.get('/users', getAllusers);
app.get('/users/:token', getUsersByUuid);
app.put('/users/:usersId', updateUsers);
app.delete('/users/:usersId', deleteusers);

// 📌 Login
app.post('/login', addLogin);
app.get('/login', getAllLogin);

// 📌 Escalas
app.post('/escalas', addEscalas);
app.get('/escalas', getAllEscalas);

// 📌 Acessos
app.post('/acesso', addNewAcesso);
app.post('/solicitarAcesso', solicitarAcesso);
app.get('/acesso', getAcesso);
app.post('/acesso/:acessoid', addNewAcessoUser);
app.get('/acesso/:acessoid/token/:token', getAcessoUser);

// 📌 Cadastro
app.get('/cadastro', getCadastro);
app.post('/cadastro', addNewCadastro);


// 📅 Eventos
app.post('/events', createEvent);
app.get('/events', getEvents);
app.get('/events/:eventId', getEventById);
app.put('/events/:eventId', updateEvent);
app.delete('/events/:eventId', deleteEvent);

// 🎟️ Inscrições em Eventos
app.post('/events/:eventId/register', registerForEvent);
app.get('/events/:eventId/registrations', getEventRegistrations);
app.delete('/events/:eventId/registrations/:registrationId', deleteRegistration);
app.get('/registrations', getRegistrationsByFcmToken);


app.post('/devotionals', createDevotional);
app.get('/devotionals', getDevotionals);
app.get('/devotionals/:devotionalId', getDevotionalById);
app.put('/devotionals/:devotionalId', updateDevotional);
app.delete('/devotionals/:devotionalId', deleteDevotional);

app.post('/preaching', createPreaching);
app.get('/preaching', getPreachings);
app.get('/preaching/:preachingId', getPreachingById);
app.put('/preaching/:preachingId', updatePreaching);
app.delete('/preaching/:preachingId', deletePreaching);

app.post('/birthdays', createBirthday);
app.get('/birthdays', getBirthdays);
app.get('/birthdays/today', getBirthdaysToday);
app.get('/birthdays/:birthdayId', getBirthdayById);
app.put('/birthdays/:birthdayId', updateBirthday);
app.delete('/birthdays/:birthdayId', deleteBirthday);

app.post('/pastorals', createPastoral);
app.get('/pastorals', getPastorals);
app.get('/pastorals/:pastoralId', getPastoralById);
app.put('/pastorals/:pastoralId', updatePastoral);
app.delete('/pastorals/:pastoralId', deletePastoral);

app.post('/cources', createCources);
app.get('/cources', getCources);
app.get('/cources/:courcesId', getCourcesById);
app.put('/cources/:courcesId', updateCources);
app.delete('/cources/:courcesId', deleteCources);

app.post('/cells', createCells);
app.get('/cells', getCells);
app.get('/cells/:cellsId', getCellsById);
app.put('/cells/:cellsId', updateCells);
app.delete('/cells/:cellsId', deleteCells);

app.post('/notices', createNotices);
app.get('/notices', getNotices);
app.get('/notices/:noticesId', getNoticesById);
app.put('/notices/:noticesId', updateNotices);
app.delete('/notices/:noticesId', deleteNotices);

exports.app = functions.https.onRequest(app);
