extends "res://personagem/Personagem.gd"

var esta_sendo_controlado := true

func _process(delta: float) -> void:
	if esta_sendo_controlado:
		dir = Vector2(Input.is_action_pressed("andar_direita") as int - Input.is_action_pressed("andar_esquerda") as int, Input.is_action_pressed("pular"))
	else: # Esse jogador nao esta sendo controlado, seguir o que esta sendo
		pass
