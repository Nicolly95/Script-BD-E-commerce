-- Criação do BD para um cenário E-commerce
create database ecommerce;
use ecommerce;

-- Criando tabela cliente
create table clients(
		idClient int auto_increment primary key,
        Fname varchar(15),
        Minit char (3),
        Lname varchar(20),
        CPF  char(11) not null,
        Adress varchar(30),
        constraint unique_cpf_cliente unique (CPF)
);

alter table clients auto_increment=1;

-- Criando tabela produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(15) not null,
        classification_kids bool default false,
        category enum('Eletronico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
        avaliation float default 0,
        size varchar(10)
);        

-- Criando tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
	orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false,
    constraint fk_order_client foreign key (idOrderClient) references clients(idCLient)
);
desc orders;

-- Criando tabela pagamentos
create table payments(
	idclient int,
    idPayment int,
    typePayment enum('Boleto','Cartão','Dois Cartões'),
    limitAvaliable float,
    primary key(idCLient, id_payment)
);

-- Criando tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- Criando tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
desc supplier;

-- Criando tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9), 
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);	

-- Criando tabela produto vendido
create table prductSeller(
	idPseller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);    
desc productSeller;

-- Criando tabela produto pedido
create table prductOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem Estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

-- Criando tabela local armazenamento
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

-- Criando tabela fornecedor dos produtos
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null, 
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
	constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)       
);

show tables;



