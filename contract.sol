pragma solidity ^0.4.20;


contract CompreEVenda {
    
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
    
    function CompreEVenda() {
        quantidadeImoveis = 0;
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
        
        imovel.proprietario.transfer(imovel.preco);
        
        imovel.proprietario = msg.sender; 
        imovel.aVenda = false;
    }
    
    function consultarProprietario(uint matricula) view returns (address, bool, uint) {
        Imovel imovel = imoveis[matricula];
        
        return (imovel.proprietario, imovel.aVenda, imovel.preco);
    }
    
}
