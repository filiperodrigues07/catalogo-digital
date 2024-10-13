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