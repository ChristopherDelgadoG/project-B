extends Area2D
@export var velocidad = 400
var direccion = Vector2.ZERO

func _process(delta):
	position += direccion * velocidad * delta

func _on_body_entered(body):
	
	if body.is_in_group("wall"):
		queue_free()
	elif body.is_in_group("player"):
		if body.inmune:
			return
		else:
			if body.has_method("damage"):
				body.damage()
	queue_free()
