// Declare 'carrinho' uma vez no início do arquivo
let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];

// Função para aumentar a quantidade
function aumentarQuantidade(parentNode) {
    const quantidadeSpan = parentNode.querySelector("#quantidade");
    const totalSpan = parentNode.querySelector(`#total-produto-${parentNode.parentNode.dataset.nome}`);
    const preco = parseFloat(parentNode.parentNode.dataset.preco);

    // Obter o valor numérico do span de quantidade
    let quantidadeAtual = parseInt(quantidadeSpan.textContent);
    quantidadeAtual++; // Aumentar a quantidade

    quantidadeSpan.textContent = quantidadeAtual; // Atualizar o span

    // Calcula o total e atualiza o span
    const total = preco * quantidadeAtual;
    totalSpan.innerText = `R$ ${total.toFixed(2)}`; // Usar innerText para formatar o preço
}

// Função para diminuir a quantidade
function diminuirQuantidade(parentNode) {
    const quantidadeSpan = parentNode.querySelector("#quantidade");
    const totalSpan = parentNode.querySelector(`#total-produto-${parentNode.parentNode.dataset.nome}`);
    const preco = parseFloat(parentNode.parentNode.dataset.preco);

    // Obter o valor numérico do span de quantidade
    let quantidadeAtual = parseInt(quantidadeSpan.textContent);
    if (quantidadeAtual > 1) {
        quantidadeAtual--; // Diminuir a quantidade
    }

    quantidadeSpan.textContent = quantidadeAtual; // Atualizar o span

    // Calcula o total e atualiza o span
    const total = preco * quantidadeAtual;
    totalSpan.innerText = `R$ ${total.toFixed(2)}`; // Usar innerText para formatar o preço
}

// Função para adicionar um item ao carrinho
function adicionarAoCarrinho(produtoElement) {
    // Obter informações do produto
    const nomeProduto = produtoElement.dataset.nome;
    const precoProduto = parseFloat(produtoElement.dataset.preco); // Já converte para número
    const imagemProduto = produtoElement.dataset.imagem;
    const quantidade = parseInt(produtoElement.querySelector("#quantidade").textContent);

    if (!produtoElement.dataset.preco || !produtoElement.dataset.nome || !produtoElement.dataset.imagem) {
        console.error('Produto com dados incompletos:', produtoElement);
        return;
    }

    // Adicionar ao carrinho
    const itemExistente = carrinho.find(item => item.nome === nomeProduto);

    if (itemExistente) {
        itemExistente.quantidade += quantidade; // Se o item já existe, atualiza a quantidade
    } else {
        carrinho.push({
            nome: nomeProduto,
            preco: precoProduto, // Não precisa converter novamente
            imagem: imagemProduto,
            quantidade: quantidade
        }); // Se o item não existe, adiciona ao carrinho
    }

    localStorage.setItem("carrinho", JSON.stringify(carrinho)); // Salva o carrinho no localStorage

    // Redirecionar para o carrinho
    window.location.href = "carrinho.html"; // Redireciona para a página do carrinho
}

// Atualizar o contador de itens no carrinho
function atualizarContadorCarrinho() {
    let contador = carrinho.reduce((acc, item) => acc + item.quantidade, 0);
    document.getElementById('cart-count').textContent = contador;
}

// Carregar o contador quando a página carregar
document.addEventListener('DOMContentLoaded', atualizarContadorCarrinho);

// Função para exibir o carrinho (única declaração)
function exibirCarrinho() {
    const cartItemsContainer = document.getElementById('cart-items');
    const cartTotalElement = document.getElementById('cart-total');
    let total = 0;

    // Limpar itens do carrinho antes de adicionar novamente
    cartItemsContainer.innerHTML = '';

    if (carrinho.length === 0) {
        cartItemsContainer.innerHTML = '<p>O carrinho está vazio.</p>'; // Exibe a mensagem "O carrinho está vazio"
        cartTotalElement.textContent = "R$ 0,00"; // Zera o valor total
    } else {
        carrinho.forEach((item, index) => {
            // Verifica se 'item.preco' está definido antes de usá-lo
            if (item.preco) {
                const itemTotal = item.preco * item.quantidade;
                total += itemTotal;

                const cartItemHTML = `
                    <div class="cart-item">
                        <img src="${item.imagem}" alt="${item.nome}">
                        <div class="item-details">
                            <h3>${item.nome}</h3>
                            <p>Preço: R$${item.preco.toFixed(2)}</p>
                            <p>Quantidade: <button onclick="alterarQuantidade(${index}, -1)">-</button> ${item.quantidade} <button onclick="alterarQuantidade(${index}, 1)">+</button></p>
                            <p>Total: R$${itemTotal.toFixed(2)}</p>
                            <button class="remove-item" onclick="removerItem(${index})">Remover</button>
                        </div>
                    </div>
                `;
                cartItemsContainer.innerHTML += cartItemHTML;
            } else {
                console.error("Erro: A propriedade 'preco' não está definida para o item:", item);
            }
        });

        cartTotalElement.textContent = `R$ ${total.toFixed(2)}`;
    }
}

// Função para alterar a quantidade de um item
function alterarQuantidade(index, delta) {
    carrinho[index].quantidade += delta;

    if (carrinho[index].quantidade <= 0) {
        carrinho.splice(index, 1); // Remove o item se a quantidade for 0
    }

    localStorage.setItem('carrinho', JSON.stringify(carrinho));
    exibirCarrinho();
}

// Função para remover um item do carrinho
function removerItem(index) {
    carrinho.splice(index, 1); // Remove o item
    localStorage.setItem('carrinho', JSON.stringify(carrinho));
    exibirCarrinho(); // Chame exibirCarrinho() para atualizar o valor total e a lista
}

// Chama exibirCarrinho() somente uma vez quando o DOM estiver pronto
document.addEventListener('DOMContentLoaded', exibirCarrinho);

// Ajuste a altura do footer para não cobrir o conteúdo
window.addEventListener('resize', () => {
    const footer = document.querySelector('footer');
    const main = document.querySelector('main');
    const contentHeight = main.offsetHeight; // Obtém a altura do conteúdo principal
    const windowHeight = window.innerHeight; // Obtém a altura da viewport
    const footerHeight = footer.offsetHeight; // Obtém a altura do footer

    if (contentHeight + footerHeight > windowHeight) {
        // Se o conteúdo + o footer forem maiores que a viewport, ajuste o padding do footer
        main.style.paddingBottom = footerHeight + 'px';
    } else {
        // Se o conteúdo + o footer forem menores que a viewport, remova o padding
        main.style.paddingBottom = '0';
    }
});

// Chame a função de ajuste ao carregar a página
window.onload = () => {
    const footer = document.querySelector('footer');
    const main = document.querySelector('main');
    const contentHeight = main.offsetHeight; // Obtém a altura do conteúdo principal
    const windowHeight = window.innerHeight; // Obtém a altura da viewport
    const footerHeight = footer.offsetHeight; // Obtém a altura do footer

    if (contentHeight + footerHeight > windowHeight) {
        main.style.paddingBottom = footerHeight + 'px';
    } else {
        main.style.paddingBottom = '0';
    }
};