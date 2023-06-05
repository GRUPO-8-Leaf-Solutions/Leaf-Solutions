var usuarioEstufaModel = require("../models/usuarioEstufaModel");

var sessoes = [];

function testar(req, res) {
  console.log("ENTRAMOS NA usuarioEstufaModel");
  res.json("ESTAMOS FUNCIONANDO!");
}

function cadastrarEstufa(req, res) {
  // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
  var nome = req.body.nomeServer;
  var area = req.body.areaServer;
  var fkEmpresa = req.body.fkEmpresa;
  var fkEndereco = req.body.fkEndereco

  // Faça as validações dos valores
  if (nome == undefined) {
    res.status(400).send("Seu nome da estufa está undefined!");
  } else if (area == undefined) {
    res.status(400).send("Sua área está undefined!");
  } else if (fkEmpresa == undefined) {
    res.status(400).send("Seu Empresa está undefined");
  } else {
    // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
    usuarioEstufaModel
      .cadastrarEstufa(nome, area, fkEmpresa, fkEndereco)
      .then(function (resultado) {
        res.json(resultado);
      })
      .catch(function (erro) {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o cadastro! Erro: ",
          erro.sqlMessage
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

function listar(req, res) {
  usuarioEstufaModel
    .listar()
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao realizar a consulta! Erro: ",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function rankMaisAlertas(req, res) {
  var idUsuarioServer = req.body.idUsuarioServer;
  usuarioEstufaModel
    .rankMaisAlertas(idUsuarioServer)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao realizar a consulta! Erro: ",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function exibirEstufas(req, res) {
  idUsuarioServer = req.body.idUsuarioServer;
  usuarioEstufaModel
    .exibirEstufas(idUsuarioServer)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as estufas da empresa..",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function qtdEstufas(req, res) {
  var idEmpresa = req.body.idUsuarioServer;
  console.log("controlle qtdEstufas", idEmpresa);
  usuarioEstufaModel
    .qtdEstufas(idEmpresa)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as estufas da empresa..",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function estadosEstufa(req, res) {
  var idEmpresa = req.body.idUsuarioServer;
  usuarioEstufaModel
    .estadosEstufa(idEmpresa)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as estufas da empresa..",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function pegarNome(req, res) {
  var idEmpresa = req.body.idUsuarioServer;
  console.log("controlle pegarNOme", idEmpresa);
  usuarioEstufaModel
    .pegarNome(idEmpresa)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as estufas da empresa..",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    cadastrarEstufa,
  testar,
  listar,
  exibirEstufas,
  rankMaisAlertas,
  qtdEstufas,
  estadosEstufa,
  pegarNome
};
