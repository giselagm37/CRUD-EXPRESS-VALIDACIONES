//npm i express
//npm i cors  
//npm i --save-dev @types/express   ayuda a armar las rutas           
//npm i mysql2
//npm i nodemon
//node index.js
//npm i joi    hace validaciones
//descargar postman para desktop
//http://localhost:3000/inscripciones
//http://localhost:3000/inscripciones/xcurso/7

//http://localhost:3000/inscripciones/1/3       estudiante_id/curso_id          
const express=require('express');
const cors=require('cors');
const port =3000;
const app=express();
const estudianteRouter=require('./routes/estudianteRouter');
const profesorRouter=require('./routes/profesorRoutes');
const cursoRouter=require('./routes/cursosRouter');
const inscripcionRouter=require('./routes/inscripcionRouter');

app.use(express.json());
app.use(cors());

app.get('/',(req,res)=>{
    res.send('App universidad');
});
app.use('/estudiantes', estudianteRouter);
app.use('/profesores',profesorRouter );
app.use('/cursos',cursoRouter );
app.use('/inscripciones',inscripcionRouter);

app.listen(port, ()=>{
    console.log(`Servidor activo en puerto ${port}`);
})