var database = require("../database/config")


function coletarMaiorIndice() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
        SELECT * FROM estufa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function coletarMenorIndice(idEmpresa) {
    var instrucao = `
    SELECT * FROM estufa JOIN empresa ON fkEmpresa = idEmpresa WHERE idEmrpesa = ${idEmpresa}
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function buscarUltimasMedidas(idEmpresa, limite_linhas) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        momento,
                        FORMAT(momento, 'HH:mm:ss') as momento_grafico
                    from medida
                    where fk_aquario = ${idEmpresa}
                    order by id desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        estufa.nome Estufa,
        avg(valor) 'Média da estufa'
            from empresa join estufa
            on idEmpresa = fkEmpresa
            join setor 
            on idEstufa = fkEstufa 
            join subSetor 
            on idSetor = fkSetor 
            join sensor 
            on idSubSetor = fkSubSetor
            join leituraSensor
            on idSensor = fkSensor
                where idEmpresa = ${idEmpresa}
                    order by id desc limit ${limite_linhas}`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idEmpresa) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        CONVERT(varchar, momento, 108) as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idEmpresa} 
                    order by id desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        estufa.nome Estufa,
        avg(valor) 'Média da estufa'
            from empresa join estufa
            on idEmpresa = fkEmpresa
            join setor 
            on idEstufa = fkEstufa 
            join subSetor 
            on idSetor = fkSetor 
            join sensor 
            on idSubSetor = fkSubSetor
            join leituraSensor
            on idSensor = fkSensor
                where ${idEmpresa} = 1
                    group by estufa;`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function exibirAlertas(idEmpresa) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        CONVERT(varchar, momento, 108) as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idEmpresa} 
                    order by id desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        estufa.nome Estufa,
        avg(valor) 'Média da estufa'
            from empresa join estufa
            on idEmpresa = fkEmpresa
            join setor 
            on idEstufa = fkEstufa 
            join subSetor 
            on idSetor = fkSetor 
            join sensor 
            on idSubSetor = fkSubSetor
            join leituraSensor
            on idSensor = fkSensor
                where ${idEmpresa} = 1
                    group by estufa;`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    coletarMaiorIndice,
    coletarMenorIndice,
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    exibirAlertas
};