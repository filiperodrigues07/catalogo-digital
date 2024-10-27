const express = require('express');
const { Pool } = require('pg');

// Configuração do banco de dados
const pool = new Pool({
  user: 'postgres',     // Usuário do PostgreSQL
  host: 'localhost',    // Host do PostgreSQL
  database: 'catalogo_digital', // Nome do banco de dados
  password: 'admin', // Senha do usuário
  port: 5432,           // Porta padrão do PostgreSQL
});

// Teste de conexão com o banco de dados
pool.connect((err, client, release) => {
  if (err) {
    return console.error('Erro ao conectar ao banco:', err.stack);
  }
  console.log('Conectado ao banco de dados!');
  release();
});

const app = express();
app.use(express.json());

// Rota para inserir um novo cliente
app.post('/clientes', async (req, res) => {
    const { nome, endereco, cpf, telefone } = req.body;
  
    try {
      const result = await pool.query(
        'INSERT INTO clientes (nome, endereco, cpf, telefone) VALUES ($1, $2, $3, $4) RETURNING *',
        [nome, endereco, cpf, telefone]
      );
      res.status(201).json(result.rows[0]);
    } catch (err) {
      console.error(err);
      res.status(500).send('Erro ao inserir cliente');
    }
  });

// Iniciar o servidor
app.listen(3000, () => {
  console.log('Servidor rodando em http://localhost:3000');
});