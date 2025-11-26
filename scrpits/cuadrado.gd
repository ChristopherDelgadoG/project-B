class_name  jugador

extends CharacterBody2D
@export var speed =150
@export var dash_speed =350
@export var dash_duration = 0.2
@export var dash_cooldown_time = 1.0

signal hit()
var sprite: Sprite2D
var dash_timer = 0.0
var dash_cooldown = 0.0
var is_dashing = false
var inmune = false
var dash_direction = Vector2.ZERO
func _ready():
	sprite = $Sprite2D # Ajusta el path si tu sprite tiene otro nombre
func _physics_process(delta):
	var direction := Vector2.ZERO

	if Input.is_action_pressed("arriba"):
		direction.y -= 1
	if Input.is_action_pressed("abajo"):
		direction.y += 1
	if Input.is_action_pressed("izquierda"):
		direction.x -= 1
	if Input.is_action_pressed("derecha"):
		direction.x += 1

	direction = direction.normalized()  # Evita que se mueva más rápido en diagonal

	# Actualizar cooldown
	if dash_cooldown > 0.0:
		dash_cooldown -= delta
	# Cambiar color según estado del dash
	if dash_cooldown <= 0.0:
		sprite.modulate = Color(0, 1, 0)  # Verde: dash disponible
	else:
			sprite.modulate = Color(1, 0, 0)  # Blanco: dash en cooldown


	if Input.is_action_just_pressed("dash") and direction != Vector2.ZERO and not is_dashing and dash_cooldown <= 0.0:
		is_dashing = true
		dash_timer = dash_duration
		dash_direction = direction
		dash_cooldown = dash_cooldown_time  # Reinicia el cooldown

	# Actualizar movimiento
	if is_dashing:
		velocity = dash_direction * dash_speed
		inmune = true
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			inmune = false
	else:
		velocity = direction * speed
	move_and_slide();
func damage():
	
	hit.emit()


func _on_area_2d_body_entered(body):
	
	damage()
