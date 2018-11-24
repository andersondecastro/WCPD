pragma solidity ^0.4.20;


contract DiaZero {
    
    address desenvolvedor;
    address comprador;
    address vendedor;
    struct Imovel {
        address proprietario;
        uint matricula;
        uint preco;
        bool aVenda;
    }
    uint quantidadeImoveis;
    mapping (uint => Imovel) imoveis;
    
    // construtor 
    function DiaZero() {
        quantidadeImoveis = 0;
        desenvolvedor = msg.sender;
    }
    
    function publicarImovel(uint _preco) {
        Imovel imovel = imoveis[++quantidadeImoveis];
        imovel.proprietario = msg.sender;
        imovel.matricula = quantidadeImoveis;
        imovel.aVenda = true;
        imovel.preco = _preco;
    }
    
    function comprarImovel(uint matricula) payable {
        Imovel imovel = imoveis[matricula];
        require( imovel.aVenda );
        require( imovel.preco <= msg.value );
        require( imovel.proprietario != msg.sender );
       
        
        var valorDesenvolvedor = imovel.preco / 10;
        var valorVendedor = imovel.preco - valorDesenvolvedor;
        
        imovel.proprietario.transfer(valorVendedor);
        desenvolvedor.send(valorDesenvolvedor);
        
        
        if(imovel.preco < msg.value) {
            var trocoDevolver = msg.value - imovel.preco;
            msg.sender.transfer(trocoDevolver);
        }
        
        imovel.proprietario = msg.sender; 
        imovel.aVenda = false;
    }
    
    function consultarProprietario(uint matricula) view returns (address, bool, uint) {
        Imovel imovel = imoveis[matricula];
        
        return (imovel.proprietario, imovel.aVenda, imovel.preco);
    }
    
    function saldoDesenvolvedor() view returns (address, uint) {
        return (desenvolvedor, desenvolvedor.balance);
    }

    
}
