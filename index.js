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