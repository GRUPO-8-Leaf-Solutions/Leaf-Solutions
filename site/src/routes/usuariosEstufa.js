var express = require("express");
var router = express.Router();

var usuarioControllerEstufa = require("../controllers/usuarioControllerEstufa");


//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrarEnd", function (req, res) {
    usuarioControllerEstufa.cadastrarEstufa(req, res);
});

router.get("/", function (req, res) {
    usuarioControllerEstufa.testar(req, res);
    console.log(`Está funcionando`)
});

router.get("/listar", function (req, res) {
    usuarioControllerEstufa.listar(req, res);
});

router.post("/exibirEstufas", function (req, res) {
    usuarioControllerEstufa.exibirEstufas(req, res);
});

router.post("/qtdEstufas", function (req, res){
    usuarioControllerEstufa.qtdEstufas(req, res);
});

router.post("/rankMaisAlertas", function(req, res){
    usuarioControllerEstufa.rankMaisAlertas(req, res);
});


router.post("/estadosEstufa", function(req, res){
    usuarioControllerEstufa.estadosEstufa(req, res);
})

router.post("/cadastrarEstufa", function(req, res){
    usuarioControllerEstufa.cadastrarEstufa(req, res);
})

router.post("/pegarNome", function(req, res){
    usuarioControllerEstufa.pegarNome(req, res)
})

module.exports = router;