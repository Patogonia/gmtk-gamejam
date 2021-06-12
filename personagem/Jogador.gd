extends Personagem

onready var delay_atirar: Timer = $DelayAtirar

var esta_sendo_controlado := true

func _process(_delta: float) -> void:
	if esta_sendo_controlado:
		processar_input_movimentacao()
		processar_input_atirar()
	else: # Esse jogador nao esta sendo controlado, seguir o que esta sendo
		pass


func processar_input_movimentacao() -> void:
	dir = Vector2(Input.is_action_pressed("andar_direita") as int - Input.is_action_pressed("andar_esquerda") as int, Input.is_action_pressed("pular"))


func processar_input_atirar() -> void:
	if Input.is_action_pressed("atirar") and delay_atirar.is_stopped():
		atirar(get_local_mouse_position().normalized(), true)
		delay_atirar.start()
