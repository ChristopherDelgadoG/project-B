class_name enemigo
extends CharacterBody2D


@export var distancia_arma = 30  # distancia desde el centro del enemigo
@export var jugador2 =CharacterBody2D
@export var bulet: PackedScene
@export var cadencia = 1.5  # segundos
const SHOOT_1 = preload("res://scenes/shoot1.tscn")

var tiempo_disparo = 0.0
func _process(delta):
	$arma.visible = true

	# Dirección hacia el jugador
	var direccion = (jugador2.global_position - global_position).normalized()

	# Posición del arma alrededor del enemigo
	$arma.position = direccion * distancia_arma
	
	# Rotar el arma para que apunte al jugador
	$arma.rotation = direccion.angle()
	
	# Voltear el sprite horizontalmente si está a la izquierda
	if direccion.x < 0:
		$arma.flip_v = true
	else:
		$arma.flip_v = false
	# Temporizador de disparo
	if tiempo_disparo > 0:
		tiempo_disparo -= delta
	else:
		disparar(direccion)
		tiempo_disparo = cadencia
func disparar(direccion: Vector2):
	var bala = bulet.instantiate()
	bala.global_position = $arma.global_position
	bala.rotation = direccion.angle()
	bala.set("direccion", direccion)
	# Activar el CollisionShape manualmente por seguridad
	var shape = bala.get_node("CollisionShape2D")
	if shape:
		shape.disabled = false
	get_tree().current_scene.add_child(bala)
