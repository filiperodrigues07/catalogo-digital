const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { Pool } = require('pg');

const app = express();

app.use(cors());
app.use(bodyParser.json());

// Configuração do banco de dados
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'catalogo_digital',
  password: 'admin',
  port: 5435,
});

// Teste de conexão com o banco de dados
pool.connect((err, client, release) => {
  if (err) {
    return console.error('Erro ao conectar ao banco:', err.stack);
  }
  console.log('Conectado ao banco de dados!');
  release();
});

app.use(express.json());

// Rota para inserir Cliente
// app.post('/clientes', async (req, res) => {
//   const { nome, endereco, cpf, telefone, email } = req.body;

//   try {
//     const result = await pool.query(
//       'INSERT INTO clientes (nome, endereco, cpf, telefone, email) VALUES ($1, $2, $3, $4, $5) RETURNING *',
//       [nome, endereco, cpf, telefone, email]
//     );
//     res.status(201).json(result.rows[0]);
//   } catch (err) {
//     console.error(err);
//     res.status(500).send('Erro ao inserir cliente');
//   }
// });

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

//Enviar pedido para o BD
app.post('/enviar-pedido', async (req, res) => {
  const { nome, endereco, email, telefone, cpf, itens } = req.body;

  try {
      await pool.query('BEGIN'); // Inicia uma transação

      // Insere o cliente e recupera o `cliente_id`
      const clienteResult = await pool.query(
          `INSERT INTO clientes (nome, endereco, email, telefone, cpf) 
          VALUES ($1, $2, $3, $4, $5) RETURNING id`,
          [nome, endereco, email, telefone, cpf]
      );
      const clienteId = clienteResult.rows[0].id;

      // Insere cada item do carrinho como um registro na tabela `pedidos`
      for (const item of itens) {
          const { produto_id, quantidade } = item;
          const status = 'em andamento'; // Defina um status inicial para o pedido
          const dataPedido = new Date(); // Usa a data atual para o pedido

          await pool.query(
              `INSERT INTO pedidos (cliente_id, quantidade, status, produto_id, data) 
              VALUES ($1, $2, $3, $4, $5)`,
              [clienteId, quantidade, status, produto_id, dataPedido]
          );
      }

      await pool.query('COMMIT'); // Confirma a transação

      res.json({ message: "Pedido salvo com sucesso!" });
  } catch (error) {
      await pool.query('ROLLBACK'); // Reverte a transação em caso de erro
      console.error("Erro ao salvar o pedido:", error);
      res.status(500).json({ error: "Erro ao salvar o pedido" });
  }
});

// Iniciar o servidor
app.listen(3000, () => {
  console.log('Servidor rodando em http://localhost:3000');
});