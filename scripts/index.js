        let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];
        
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

            exibirCarrinho();
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
        
        function aumentarQuantidade(parentNode) {
            const quantidadeSpan = parentNode.querySelector("#quantidade");
            // Use o seletor correto
            const totalSpan = parentNode.querySelector("#total-produto-NovexCondicionadorMeusCachos300ml"); 
            const preco = parseFloat(parentNode.parentNode.dataset.preco);
            const quantidadeAtual = parseInt(quantidadeSpan.textContent);
            quantidadeSpan.textContent = quantidadeAtual + 1;
            // Calcula o total e atualiza o span
            const total = preco * quantidadeAtual;
            totalSpan.innerText = `R$ ${total.toFixed(2)}`; 
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