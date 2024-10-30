const express = require('express');
const { Pool } = require('pg');

// Configuração do banco de dados
const pool = new Pool({
  user: 'postgres',     // Usuário do PostgreSQL
  host: 'localhost',    // Host do PostgreSQL
  database: 'catalogo_digital', // Nome do banco de dados
  password: 'admin', // Senha do usuário
  port: 5435,           // Porta padrão do PostgreSQL
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

// Rota para inserir Cliente
app.post('/clientes', async (req, res) => {
  const { nome, endereco, cpf, telefone, email } = req.body; // Incluindo o campo email

  try {
    const result = await pool.query(
      'INSERT INTO clientes (nome, endereco, cpf, telefone, email) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [nome, endereco, cpf, telefone, email]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).send('Erro ao inserir cliente');
  }
});

// Rota para inserir Produto
app.post('/produtos', async (req, res) => {
  const { id, nome, descricao, preco, categoria } = req.body;

  try {
    const query = `
      INSERT INTO produtos (nome, descricao, preco)
      VALUES ($1, $2, $3)
      RETURNING *;
    `;
    const values = [nome, descricao, preco, categoria];

    const result = await pool.query(query, values);
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao inserir produto' });
  }
});

// Iniciar o servidor
app.listen(3000, () => {
  console.log('Servidor rodando em http://localhost:3000');
});