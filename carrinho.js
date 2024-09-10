function exibirCarrinho() {
    const carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];
    const cartItemsContainer = document.getElementById('cart-items');
    const cartTotalElement = document.getElementById('cart-total');
    let total = 0;

    // Limpar itens do carrinho antes de adicionar novamente
    cartItemsContainer.innerHTML = '';

    if (carrinho.length === 0) {
        cartItemsContainer.innerHTML = '<p>O carrinho está vazio.</p>'; // Exibe a mensagem "O carrinho está vazio"
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
    let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];
    carrinho[index].quantidade += delta;

    if (carrinho[index].quantidade <= 0) {
        carrinho.splice(index, 1); // Remove o item se a quantidade for 0
    }

    localStorage.setItem('carrinho', JSON.stringify(carrinho));
    exibirCarrinho();
}

// Função para remover um item do carrinho
function removerItem(index) {
    let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];
    carrinho.splice(index, 1); // Remove o item
    localStorage.setItem('carrinho', JSON.stringify(carrinho));
    exibirCarrinho();
}
// Certifique-se de que exibirCarrinho() é chamado quando o documento estiver pronto
document.addEventListener('DOMContentLoaded', exibirCarrinho);
