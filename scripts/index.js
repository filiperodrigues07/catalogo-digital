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

//nova função para adicionar os produtos no carrinho
function adicionarAoCarrinho(produto, preco, imagem, delta = 1) {
    // Recupera o carrinho do localStorage ou inicializa um array vazio
    let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];

    // Verificar se o produto já existe no carrinho
    const produtoExistente = carrinho.find(item => item.nome === produto);

    if (produtoExistente) {
        // Ajustar a quantidade com base no delta
        produtoExistente.quantidade += delta;

        // Se a quantidade for menor ou igual a 0, remover o produto do carrinho
        if (produtoExistente.quantidade <= 0) {
            carrinho = carrinho.filter(item => item.nome !== produto);
        }
    } else {
        // Se delta for positivo e o produto não existir, adicionar ao carrinho
        if (delta > 0) {
            carrinho.push({ nome: produto, preco: preco, imagem: imagem, quantidade: delta });
        }
    }

    // Atualiza o localStorage com o carrinho atualizado
    localStorage.setItem('carrinho', JSON.stringify(carrinho));

    // Atualiza o contador do carrinho e a quantidade exibida na página
    atualizarContadorCarrinho();

    atualizarQuantidadeNaPagina(produto);  // Função para atualizar a quantidade visível
    
    exibirCarrinho();
}

// Função para atualizar a quantidade visível na página
function atualizarQuantidadeNaPagina(produto) {
    // Recupera o carrinho do localStorage
    let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];

    // Encontra o item no carrinho
    const produtoExistente = carrinho.find(item => item.nome === produto);

    // Encontra o elemento HTML que exibe a quantidade para esse produto
    const quantidadeElemento = document.querySelector(`[data-produto="${produto}"] .quantidade`);

    // Atualiza a quantidade visível na interface
    if (produtoExistente) {
        quantidadeElemento.textContent = produtoExistente.quantidade;
    } else {
        quantidadeElemento.textContent = 0;  // Se o produto foi removido, exibe 0
    }
}

// Função para atualizar o contador total do carrinho
function atualizarContadorCarrinho() {
    // Recupera o carrinho do localStorage
    let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];

    // Soma o total de itens no carrinho
    let totalItens = carrinho.reduce((acc, item) => acc + item.quantidade, 0);

    // Atualiza o elemento do contador na interface (caso tenha um contador geral do carrinho)
    document.getElementById('cart-count').textContent = totalItens;
}

// Função para carregar os valores iniciais quando a página carrega
function carregarCarrinhoNaPagina() {
    // Recupera o carrinho do localStorage
    let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];

    // Atualiza a quantidade de cada produto na página
    carrinho.forEach(item => {
        atualizarQuantidadeNaPagina(item.nome);
    });

    // Atualiza o contador geral do carrinho
    atualizarContadorCarrinho();
}

window.onload = carregarCarrinhoNaPagina;

// Carregar o contador quando a página carregar
document.addEventListener('DOMContentLoaded', atualizarContadorCarrinho);

        // Função para filtrar produtos pelo nome
        function filtrarProdutos() {
            const input = document.getElementById("searchInput").value.toLowerCase();
            const produtos = document.getElementsByClassName("product");

            // Loop pelos produtos e exibe/oculta com base na busca
            for (let i = 0; i < produtos.length; i++) {
                const nomeProduto = produtos[i].getElementsByTagName("h2")[0].innerText.toLowerCase();
                if (nomeProduto.includes(input)) {
                    produtos[i].style.display = "block"; // Exibe o produto
                } else {
                    produtos[i].style.display = "none"; // Oculta o produto
                }
            }
        }

        // Adiciona evento ao pressionar a tecla Enter no campo de busca
        document.getElementById("searchInput").addEventListener("keydown", function(event) {
            // Verifica se a tecla pressionada foi o Enter (código 13 ou "Enter")
            if (event.key === "Enter") {
                event.preventDefault(); // Evita o comportamento padrão de enviar formulário (se for um)
                filtrarProdutos(); // Chama a função de filtro
            }
        });

        // Função para mostrar ou ocultar categorias
        function mostrarCategoria(categoria) {
            const categorias = document.querySelectorAll('.product');
            categorias.forEach(cat => {
                if (categoria === 'Página Inicial' || cat.dataset.category === categoria) {
                    cat.style.display = 'block';
                } else {
                    cat.style.display = 'none';
                }
            });
        }

        // Adiciona evento de clique aos links da navegação
        const linksCategoria = document.querySelectorAll('.category-nav li a');
        linksCategoria.forEach(link => {
            link.addEventListener('click', function(event) {
                event.preventDefault();
                const categoria = this.dataset.category;
                mostrarCategoria(categoria);
            });
        });

        // Mostrar todos os produtos por padrão
        window.onload = () => {
            mostrarCategoria('Página Inicial'); // Mostrar todos os produtos
        };