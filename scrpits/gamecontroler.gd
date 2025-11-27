extends Node2D

@export var vidas := 3


var barra_instanciada
var corazones = []
var monedas = 0
var tiempo_acumulado = 0.0
var is_inGame = true  
@onready var lMonedas =get_node("../TileMapLayer/bvida/Label2/coins/dinero")


func _process(delta):
	if is_inGame:
		tiempo_acumulado += delta
		if tiempo_acumulado >= 1.0:
			monedas += 1
			tiempo_acumulado = 0.0
			lMonedas.text = ": " + str(monedas)

func _ready():
	corazones = [
		get_node("../TileMapLayer/bvida/Label/caja/vida1"),
		get_node("../TileMapLayer/bvida/Label/caja/vida2"),
		get_node("../TileMapLayer/bvida/Label/caja/vida3")
	]

	actualizar_barra_vida()

func _on_jugador_hit():
	vidas -= 1
	actualizar_barra_vida()

	if vidas <= 0:
		loss()

func actualizar_barra_vida():
	
	for i in range(corazones.size()):
		corazones[i].modulate = Color(1, 0, 0) if i < vidas else Color(1, 1, 1)

func loss():
	print("nice try")
	
func win():
	print("good")
