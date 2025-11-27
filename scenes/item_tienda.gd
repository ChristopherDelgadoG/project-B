extends Node2D

@export var icon : TextureRect
@export var desc : Label
@export var cost : Label


func configurar(icono_tex, descripcion, precio):
	icon.texture = icono_tex
	desc.text = descripcion
	cost.text = "Costo: " + str(precio)
