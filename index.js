// Função para abrir o modal com informações detalhadas do produto
function abrirModal(nome, descricao, preco, imagem) {
    // Preenche os elementos do modal com os dados do produto
    document.getElementById('modal-title').innerText = nome;
    document.getElementById('modal-description').innerText = descricao;
    document.getElementById('modal-price').innerText = preco;
    document.getElementById('modal-image').src = imagem;
    
    // Mostra o modal
    document.getElementById('modal').style.display = 'flex';

    // Ajusta o layout para exibir os botões lado a lado
    document.querySelector('.product').style.flexDirection = 'row';
}

// Função para fechar o modal
function fecharModal() {
    document.getElementById('modal').style.display = 'none';

    // Restaura o layout para coluna quando o modal é fechado
    document.querySelector('.product').style.flexDirection = 'column';
}

// Fechar o modal ao clicar fora dele
window.onclick = function(event) {
    const modal = document.getElementById('modal');
    if (event.target == modal) {
        modal.style.display = 'none';
    }
};

let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];

function adicionarAoCarrinho(produto, preco, imagem) {
    // Verificar se o produto já existe no carrinho
    const produtoExistente = carrinho.find(item => item.nome === produto);

    if (produtoExistente) {
        produtoExistente.quantidade++;
    } else {
        carrinho.push({ nome: produto, preco: preco, imagem: imagem, quantidade: 1 });
    }

    localStorage.setItem('carrinho', JSON.stringify(carrinho));
    atualizarContadorCarrinho();
}

// Atualizar o contador de itens no carrinho
function atualizarContadorCarrinho() {
    let contador = carrinho.reduce((acc, item) => acc + item.quantidade, 0);
    document.getElementById('cart-count').textContent = contador;
}

// Carregar o contador quando a página carregar
document.addEventListener('DOMContentLoaded', atualizarContadorCarrinho);

// Abrir o Modal de Login/Cadastro
document.addEventListener('DOMContentLoaded', () => {
    const openLoginModal = document.getElementById('openLoginModal');
    const loginModal = document.getElementById('loginModal');

    if (openLoginModal) { // Verifique se o elemento existe
        openLoginModal.addEventListener('click', function(event) {
            event.preventDefault(); // Impede o comportamento padrão do link
            loginModal.style.display = 'block';
        });
    }

    // Fechar o Modal de Login/Cadastro
    const fecharLoginModal = () => {
        loginModal.style.display = 'none';
    };

    document.querySelector('.close').addEventListener('click', fecharLoginModal);

    // Mostrar/Ocultar Formulários de Login e Cadastro
    const mostrarLogin = () => {
        document.getElementById('loginForm').style.display = 'block';
        document.getElementById('registerForm').style.display = 'none';
    };

    const mostrarCadastro = () => {
        document.getElementById('loginForm').style.display = 'none';
        document.getElementById('registerForm').style.display = 'block';
    };

    // Funções de Login e Cadastro (implemente sua lógica aqui)
    const entrar = () => {
        // Obtenha os valores dos campos de email e senha
        const email = document.getElementById('email').value;
        const senha = document.getElementById('password').value;

        // Realize a validação dos dados
        // ... (código para validar email e senha) ...

        // Faça a requisição para o servidor para autenticação
        // ... (código para fazer a requisição AJAX para o servidor) ...

        // Se o login for bem-sucedido, redireciona o usuário
        // ... (código para redirecionar o usuário) ...
    };

    const cadastrar = () => {
        // Obtenha os valores dos campos de nome, email e senha
        const nome = document.getElementById('nome').value;
        const email = document.getElementById('email').value;
        const senha = document.getElementById('senha').value;

        // Realize a validação dos dados
        // ... (código para validar nome, email e senha) ...

        // Faça a requisição para o servidor para criar a conta
        // ... (código para fazer a requisição AJAX para o servidor) ...

        // Se o cadastro for bem-sucedido, redireciona o usuário
        // ... (código para redirecionar o usuário) ...
    };
});

    // Adiciona evento para pesquisar ao pressionar Enter
    document.getElementById("searchInput").addEventListener("keydown", function(event) {
        if (event.key === "Enter") { // Verifica se a tecla pressionada é "Enter"
            event.preventDefault();  // Previne o comportamento padrão (submissão do form)
            realizarPesquisa();      // Função de pesquisa
        }
    });

    function realizarPesquisa() {
        let query = document.getElementById("searchInput").value;
        if (query) {
            alert("Você pesquisou por: " + query); // Substituir isso pela ação real de pesquisa
        } else {
            alert("Por favor, insira um termo de pesquisa.");
        }
    }