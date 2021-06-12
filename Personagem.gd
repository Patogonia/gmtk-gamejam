extends "res://personagem/Personagem.gd"


func _unhandled_input(event: InputEvent):
	if event is InputEventAction:
		dir = Vector2(event.is_action_pressed("andar_direita") as int - event.is_action_pressed("andar_esquerda") as int, 0)
