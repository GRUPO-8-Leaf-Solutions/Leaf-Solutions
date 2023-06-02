var express = require("express");
var router = express.Router();

var subSetoresController = require("../controllers/subSetoresController");


router.post("/buscarSubSetor", function (req, res) {
    subSetoresController.buscarSubSetor(req, res);
});

// router.post("/buscaSubSetor", function (req, res){
//     subSetoresController.buscaSubSetor(req,res)
// })

router.post("/buscarSensor", function (req, res) {
    subSetoresController.buscarSensor(req, res);
});

// router.get("/obterSetoresInner/:idEstufa", function (req, res) {
//     subSetoresController.obterSetoresInner(req, res);
// });

module.exports = router;