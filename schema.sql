create database ecommerce;
use ecommerce;

create table cliente(
	idCliente int not null auto_increment primary key,
    primeiroNome varchar(15),
    sobrenome varchar(30),
    cpf char(11) not null unique,
    endereco varchar(40),
    dataNascimento date
);

create table produto(
	idProduto int not null auto_increment primary key,
    idCliente int,
    descricao varchar(15) not null,
    categoria varchar(15),
    peso float,
    avaliacao float default 0,
   constraint fk_cliente foreign key (idCliente) references cliente (idCliente)
);

create table tipoPagamento(
	idCliente int,
    idPagamento int,
    tipoPagamento enum ('Cartao', 'Dinheiro', 'Boleto'),
    constraint fk_pagamento_cliente foreign key (idCliente) references cliente (idCliente),
    primary key (idCliente, idPagamento)
);

create table pedido(
	idPedido int not null auto_increment primary key,
    idCliente int,
    idPagamento int,
    situacao enum('Cancelado', 'Confirmado', 'Em processamento') not null,
    descricao varchar(255),
    frete float default 0,
    constraint fk_pedido_cliente foreign key (idCliente) references cliente (idCliente)
);

create table estoque(
	idProdEstoque int auto_increment primary key,
    quantidade int not null,
    localizacao varchar(15)
);

create table fornecedor(
	idFornecedor int not null primary key,
	razaoSocial varchar(30) not null,
    cnpj char(15) not null unique,
    contato varchar(15) not null
);

create table vendedor(
	idVendedor int not null primary key,
	razaoSocial varchar(30) not null,
    cpf char (9) unique,
    cnpj char(15) unique,
    contato varchar(15) not null
);

create table produtoVendedor(
	idPseller int,
    idProduto int,
    quantidadeProdutos int default 1,
    primary key (idPseller, idProduto),
    constraint fk_produto_vendedor foreign key (idPseller) references vendedor (idVendedor),
    constraint fk_produto foreign key (idProduto) references produto (idProduto)
);

create table productOrder(
	idProduct int,
    idOrder int,
    poQuantidade int default 1,
    poStatus enum ('Disponível', 'Sem estoque') default 'Disponivel',
    primary key (idProduct, idOrder),
    constraint fk_product_seller foreign key (idProduct) references produto (idProduto),
    constraint fk_product_product foreign key (idOrder) references pedido (idPedido)
);

create table localEstoque(
	idLProduto int,
    idLocal int,
    localizacao varchar(255) not null,
    primary key (idLProduto, idLocal)
);
