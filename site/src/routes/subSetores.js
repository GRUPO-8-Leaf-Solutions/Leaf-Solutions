var express = require("express");
var router = express.Router();

var subSetoresController = require("../controllers/subSetoresController");


router.post("/buscarSubSetor", function (req, res) {
    subSetoresController.buscarSubSetor(req, res);
});

router.post("/buscarSensor", function (req, res) {
    subSetoresController.buscarSensor(req, res);
});

// router.get("/obterSetoresInner/:idEstufa", function (req, res) {
//     subSetoresController.obterSetoresInner(req, res);
// });

router.post("/obterMenorIndice", function (req, res) {
    subSetoresController.obterMenorIndice(req, res);
});

router.post("/obterMaiorIndice", function (req, res) {
    subSetoresController.obterMaiorIndice(req, res);
});

router.post("/obterIndiceAtual", function (req, res) {
    subSetoresController.obterIndiceAtual(req, res);
});

router.post("/exibitQtdSubSetores", function (req, res) {
    subSetoresController.exibitQtdSubSetores(req, res);
});

router.post("/estadosSubSetores", function(req, res){
    subSetoresController.estadosSubSetores(req, res);
})

router.post("/estadosSensor", function(req, res){
    subSetoresController.estadosSensor(req, res);
})


module.exports = router;