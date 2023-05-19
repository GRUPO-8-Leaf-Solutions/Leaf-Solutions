var express = require("express");
var router = express.Router();

var usuarioControllerEstufa = require("../controllers/usuarioControllerEstufa");


//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrarEnd", function (req, res) {
    usuarioControllerEstufa.cadastrarEstufa(req, res);
});

router.get("/", function (req, res) {
    usuarioControllerEstufa.testar(req, res);
});

router.get("/listar", function (req, res) {
    usuarioControllerEstufa.listar(req, res);
});


module.exports = router;