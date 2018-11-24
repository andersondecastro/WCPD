pragma solidity ^0.4.20;


contract UberAnarquista {

    uint registroGerado;
    uint numeroDaCorrida;
    
    struct Motorista {
        uint registro;
        bool disponivel;
    }
    
    enum statusCorrida {
        AGUARDANDO,
        CORRIDA_ACEITA,
        INICIADO
    }
    
    struct Corrida {
        uint motorista;
        uint valor;
        statusCorrida status;
    }
    
    mapping (uint => Motorista) motoristas;
    mapping (uint => Corrida) corridas;

    // constructor
    function UberAnarquista() {
        registroGerado = 0;
        numeroDaCorrida = 0;
    }
    
    function inscreverMotorista() {
        Motorista condutor = motoristas[++registroGerado];
        
        condutor.disponivel = true;
        condutor.registro = registroGerado;
    }
    
    function inscreverCorrida(uint registroDoMotorista, uint valorDaCorrida) {
        Corrida corrida = corridas[++numeroDaCorrida];
        
        corrida.valor = valorDaCorrida;
        corrida.motorista = registroDoMotorista;
        corrida.status = statusCorrida.AGUARDANDO;
    }
    
    function chamarMotorista(uint registroDoMotorista) {
        Motorista condutor = motoristas[registroDoMotorista];
        
        require( condutor.disponivel );
        
        condutor.disponivel = false;
    }
    
    function aceitarCorrida(uint numeroDaCorrida) {
        Corrida corrida = corridas[numeroDaCorrida];
        corrida.status = statusCorrida.CORRIDA_ACEITA;
    }
    
    function iniciarCorrida(uint numeroDaCorrida) {
        Corrida corrida = corridas[numeroDaCorrida];
        corrida.status = statusCorrida.INICIADO;
    }
    
    function encerrarCorrida(uint numeroDaCorrida) {
        Corrida corrida = corridas[numeroDaCorrida];
        corrida.status = statusCorrida.AGUARDANDO;
        
        // mudar status do motorista pra disponivel
        
        // transferir o valor para a carteira do motorista
    }
    
}