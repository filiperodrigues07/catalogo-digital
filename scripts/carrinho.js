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
    exibirCarrinho(); // Chame exibirCarrinho() para atualizar o valor total
}

// Certifique-se de que exibirCarrinho() é chamado quando o documento estiver pronto
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
        // Se o conteúdo + o footer forem maiores que a viewport, ajuste o padding do footer
        main.style.paddingBottom = footerHeight + 'px';
    } else {
        // Se o conteúdo + o footer forem menores que a viewport, remova o padding
        main.style.paddingBottom = '0';
    }
};

// Função para exibir o carrinho
function exibirCarrinho() {
    const carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];
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
    exibirCarrinho(); // Chame exibirCarrinho() para atualizar o valor total e a lista
}


document.addEventListener('DOMContentLoaded', exibirCarrinho);


// Função para abrir o modal
function abrirFormulario() {
    document.getElementById("modal-form").style.display = "flex";
}

// Função para fechar o modal
function fecharFormulario() {
    document.getElementById("modal-form").style.display = "none";
}

// Função para fechar ao clicar fora do modal
function fecharAoClicarFora(event) {
    const modalContent = document.querySelector(".modal-content");
    if (!modalContent.contains(event.target)) {
        fecharFormulario();
    }
}

// Aplica máscara no campo de telefone
function mascaraTelefone(event) {
    const input = event.target;
    let telefone = input.value.replace(/\D/g, ''); // Remove caracteres não numéricos

    // Formato: (XX) XXXXX-XXXX
    if (telefone.length > 10) {
        telefone = telefone.replace(/^(\d{2})(\d{5})(\d{4}).*/, "($1) $2-$3");
    } else {
        telefone = telefone.replace(/^(\d{2})(\d{4})(\d{0,4}).*/, "($1) $2-$3");
    }

    input.value = telefone;
}

// Aplica máscara no campo de CPF ou CNPJ
function mascaraCpfCnpj(event) {
    const input = event.target;
    let value = input.value.replace(/\D/g, '');

    if (value.length <= 11) {
        // CPF: XXX.XXX.XXX-XX
        value = value.replace(/(\d{3})(\d)/, "$1.$2");
        value = value.replace(/(\d{3})(\d)/, "$1.$2");
        value = value.replace(/(\d{3})(\d{2})$/, "$1-$2");
    } else {
        // CNPJ: XX.XXX.XXX/XXXX-XX
        value = value.replace(/(\d{2})(\d)/, "$1.$2");
        value = value.replace(/(\d{3})(\d)/, "$1.$2");
        value = value.replace(/(\d{3})(\d)/, "$1/$2");
        value = value.replace(/(\d{4})(\d{2})$/, "$1-$2");
    }

    input.value = value;
}


// Função para validar e enviar o pedido
function enviarPedido() {
    const nome = document.getElementById('nome').value.trim();
    const email = document.getElementById('email').value.trim();
    const telefone = document.getElementById('telefone').value.trim();
    const cpf = document.getElementById('cpfCnpj').value.trim();

    if (!nome || !email || !telefone || !cpf) {
        alert("Por favor, preencha todos os campos.");
        return;
    }

    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailPattern.test(email)) {
        alert("Por favor, insira um email válido.");
        return;
    }

    const telefonePattern = /^\(\d{2}\)\s?\d{4,5}-\d{4}$/;
    if (!telefonePattern.test(telefone)) {
        alert("Por favor, insira um telefone válido no formato (XX) XXXXX-XXXX.");
        return;
    }

    const cpfPattern = /^\d{3}\.\d{3}\.\d{3}-\d{2}$/;
    if (!cpfPattern.test(cpf)) {
        alert("Por favor, insira um CPF válido no formato XXX.XXX.XXX-XX.");
        return;
    }

    console.log("Pedido enviado:", { nome, email, telefone, cpf });
    alert("Pedido enviado com sucesso!");
    fecharFormulario();

    const cartItems = [
        { produto_id: 1, quantidade: 2 },
        { produto_id: 2, quantidade: 1 }
        // Exemplo, você deve preencher isso com os itens reais do carrinho
    ];

    const dados = {
        nome,
        email,
        telefone,
        cpf,
        itens: cartItems // Inclui os itens do carrinho no corpo da requisição
    };

    fetch('http://localhost:3000/enviar-pedido', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(dados)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Erro na requisição: ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        console.log(data.message); // Mensagem de sucesso
    })
    .catch(error => console.error('Erro:', error));
}
