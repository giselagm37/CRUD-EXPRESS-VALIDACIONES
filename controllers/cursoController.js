const {json}=require('express');
const bd=require('../database/conexion');
const Joi = require('joi');

class CursoController{
    async consultarTodos(req, res){
        try{
            const [rows]= await bd.query(`SELECT * FROM cursos`);
            res.status(200).json(rows);
        }
        catch(err){
            res.status(500).send(err.message);
        }
    }

    async consultarUno(req, res){
        const {id}=req.params;
        try{
            const [rows]= await bd.query(`SELECT * FROM cursos WHERE id=?`,[id]);
            if(rows.length>0){
                res.status(200).json(rows[0]);
            }
            else{
                res.status(400).json({mens:'curso no encontrado'});
            }         
        }
        catch(err){
            res.status(500).send(err.message);
        }
    }
    /*SIN JOI  
    async insertar(req, res){
        const {nombre,descripcion,profesor_id}=req.body;
        const conn=await bd.getConnection();
        try{
            await conn.beginTransaction();
            const [cursRes]=await conn.query( `SELECT COUNT(*) AS cant FROM profesores WHERE id=?;`,[profesor_id]);
            if(cursRes[0].cant==0){
                await conn.rollback();
                return res.status(400).json({mens:'El profesor no existe'});
            }
            const [insertEst]=await conn.query(`INSERT INTO cursos (id,nombre,descripcion,profesor_id) VALUES (NULL,?,?,?);`,
                [nombre,descripcion,profesor_id]);
            if(insertEst.affectedRows===1){
                await conn.commit();
                res.status(200).json({id:insertEst.insertId});

            }
           
        }
        catch(err){
            res.status(500).send(err.message);
            try{
                await conn.rollback();
            }
            catch(errRoll){
                res.status(500).send(errRoll.message);
            }

        }
        finally{
              conn.release();
        }
    }*/

    //CON JOI
    
    async insertar(req, res) {
        // Definición del esquema de validación con Joi
        const schema = Joi.object({
            nombre: Joi.string().min(2).max(100).required(),
            descripcion: Joi.string().min(5).max(255).required(),
            profesor_id: Joi.number().integer().positive().required() // Se espera un ID positivo
        });
    
        // Validación de los datos de entrada
        const { error, value } = schema.validate(req.body);
    
        if (error) {
            return res.status(400).json({ message: error.details[0].message });
        }
    
        const { nombre, descripcion, profesor_id } = value;
        const conn = await bd.getConnection();
    
        try {
            await conn.beginTransaction();
    
            // Verificar si el profesor existe
            const [cursRes] = await conn.query(`SELECT COUNT(*) AS cant FROM profesores WHERE id=?;`, [profesor_id]);
            if (cursRes[0].cant == 0) {
                await conn.rollback();
                return res.status(400).json({ message: 'El profesor no existe' });
            }
    
            // Insertar el curso
            const [insertEst] = await conn.query(
                `INSERT INTO cursos (id, nombre, descripcion, profesor_id) VALUES (NULL, ?, ?, ?);`,
                [nombre, descripcion, profesor_id]
            );
    
            if (insertEst.affectedRows === 1) {
                await conn.commit();
                res.status(200).json({ id: insertEst.insertId });
            }
        } catch (err) {
            res.status(500).send(err.message);
            try {
                await conn.rollback();
            } catch (errRoll) {
                res.status(500).send(errRoll.message);
            }
        } finally {
            conn.release();
        }
    }

async modificar(req, res) {
    // Definición del esquema de validación con Joi
    const schema = Joi.object({
        nombre: Joi.string().min(2).max(100).required(),
        descripcion: Joi.string().min(5).max(255).required(),
        profesor_id: Joi.number().integer().positive().required() // Se espera un ID positivo
    });

    // Validación de los datos de entrada
    const { error, value } = schema.validate(req.body);

    if (error) {
        return res.status(400).json({ message: error.details[0].message });
    }

    const { nombre, descripcion, profesor_id } = value;
    const { id } = req.params;
    const conn = await bd.getConnection();

    try {
        await conn.beginTransaction();

        // Verificar si el profesor existe
        const [cursRes] = await conn.query(`SELECT COUNT(*) AS cant FROM profesores WHERE id=?;`, [profesor_id]);
        if (cursRes[0].cant == 0) {
            await conn.rollback();
            return res.status(400).json({ message: 'El profesor no existe' });
        }

        // Actualizar el curso
        const [insertEst] = await conn.query(
            `UPDATE cursos SET nombre=?, descripcion=?, profesor_id=? WHERE id=?;`,
            [nombre, descripcion, profesor_id, id]
        );

        if (insertEst.affectedRows === 1) {
            await conn.commit();
            res.status(200).json({ message: 'Curso actualizado' });
        } else {
            await conn.rollback();
            res.status(400).json({ message: 'Curso no encontrado o no se pudo actualizar' });
        }
    } catch (err) {
        res.status(500).send(err.message);
        try {
            await conn.rollback();
        } catch (errRoll) {
            res.status(500).send(errRoll.message);
        }
    } finally {
        conn.release();
    }
}

   /* SIN JOI
    async modificar(req, res){
        const {id}=req.params;
        const {nombre,descripcion,profesor_id}=req.body;
        const conn=await bd.getConnection();
        try{
            await conn.beginTransaction();
            const [cursRes]=await conn.query( `SELECT COUNT(*) AS cant FROM profesores WHERE id=?;`,[profesor_id]);
            if(cursRes[0].cant==0){
                await conn.rollback();
                return res.status(400).json({mens:'El profesor no existe'});
            }
            const [insertEst]=await conn.query(`UPDATE cursos SET nombre=?,descripcion=?,profesor_id=? WHERE id=?;`,
                [nombre,descripcion,profesor_id,id]);
            if(insertEst.affectedRows===1){
                await conn.commit();
                res.status(200).json({id:insertEst.insertId});

            }
           
        }
        catch(err){
            res.status(500).send(err.message);
            try{
                await conn.rollback();
            }
            catch(errRoll){
                res.status(500).send(errRoll.message);
            }

        }
        finally{
              conn.release();
        }
    }*/

        //CON JOI

    async eliminar(req, res){
        const {id}=req.params;
        try{
            const [rows]= await bd.query(`DELETE FROM cursos WHERE id=?`,[id]);
            if(rows===1){
               
                res.status(200).json({mens:'Curso borrado'});

            }
            else{
                res.status(404).json({mens:'Curso no encontrado'});
            }
            
        }
        catch(err){
            res.status(500).send(err.message);
        }
    }

}
module.exports=new CursoController();