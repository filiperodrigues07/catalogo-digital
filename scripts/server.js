const express = require('express');
const pg = require('pg'); // Importe o módulo pg
const app = express();

// Configurações do banco de dados
const pool = new pg.Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'catalogo_digital',
    password: 'admin',
    port: 5432,
    ssl: false
});

// Conecte-se ao banco de dados
pool.query('SELECT NOW()', (err, result) => {
    if (err) {
        console.error('Erro ao conectar ao banco de dados:', err);
        return;
    }
    console.log('Conectado ao banco de dados com sucesso!');
    console.log('Data e hora do servidor:', result.rows[0].now);
});

// Rotas do servidor (exemplos)
app.get('/produtos', (req, res) => {
    pool.query('SELECT * FROM produtos', (err, results) => {
        if (err) {
            console.error('Erro na consulta:', err);
            res.status(500).send('Erro na consulta');
            return;
        }
        res.json(results.rows); // Use `results.rows` para acessar os dados
    });
});

app.post('/adicionar-produto', (req, res) => {
    // Obtenha os dados do produto da requisição
    const nome = req.body.nome;
    const preco = req.body.preco;
    // ... outros campos

    // Inserir o produto no banco de dados
    pool.query('INSERT INTO produtos (nome, preco, ...) VALUES ($1, $2, ...)', [nome, preco, ...], (err, results) => {
        if (err) {
            console.error('Erro ao inserir o produto:', err);
            res.status(500).send('Erro ao inserir o produto');
            return;
        }
        res.send('Produto inserido com sucesso!');
    });
});

// Iniciar o servidor
app.listen(3000, () => {
    console.log('Servidor iniciado em http://localhost:3000');
});