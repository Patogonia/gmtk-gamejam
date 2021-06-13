class_name Jogador
extends Personagem

onready var delay_atirar: Timer = $DelayAtirar
onready var camera: Camera2D = $Camera2D
onready var delay_pular: Timer = $DelayPular
export var principal := false
export var e_vida_extra := false


var distancia_teleporte := 32.0
var delay_pular_por_ordem := 0.1


func _ready():
	if principal:
		GerenciadorAliados.aliado_sendo_controlado = self
		$Camera2D.current = true

	GerenciadorAliados.grupo_aliados.append(self)


func _process(_delta: float) -> void:
	if esta_sendo_controlado():
		processar_input_movimentacao()
		processar_input_atirar()
		return

	processar_movimento_bot()


func processar_input_movimentacao() -> void:
	dir = Vector2(Input.is_action_pressed("andar_direita") as int - Input.is_action_pressed("andar_esquerda") as int, Input.is_action_pressed("pular"))


func processar_input_atirar() -> void:
	if Input.is_action_pressed("atirar") and delay_atirar.is_stopped() and esta_sendo_controlado():
		atirar(get_local_mouse_position().normalized(), true)
		delay_atirar.start()


func processar_movimento_bot() -> void:
	var jogador = GerenciadorAliados.aliado_sendo_controlado
	if position.distance_to(jogador.position) > GerenciadorAliados.pegar_distancia_parar(self) + distancia_teleporte:
		return # teleportar

	var dir_horizontal: Vector2 = ((jogador.position - position) * Vector2.RIGHT).normalized()
	dir *= Vector2.UP

	if position.distance_to(jogador.position) > GerenciadorAliados.pegar_distancia_parar(self):
		dir += dir_horizontal

	if delay_pular.is_stopped() and jogador.dir.y > 0:
		delay_pular.start(delay_pular_por_ordem * pegar_ordem())
	elif jogador.dir.y < 1:
		dir.y = 0


func esta_sendo_controlado() -> bool:
	return GerenciadorAliados.aliado_sendo_controlado == self


func morrer():
	if principal:
		if GerenciadorAliados.grupo_aliados.size() == 1:
			return # morrer

		for aliado in GerenciadorAliados.grupo_aliados:
			if aliado != self:
				return # matar o aliado

	if !e_vida_extra:
		var vida_extra = GerenciadorAliados.pegar_vida_extra()
		if vida_extra:
			vida_extra.morrer()
			return

	if esta_sendo_controlado():
		GerenciadorAliados.mudar_de_aliado()
	GerenciadorAliados.grupo_aliados.erase(self)
	queue_free()


func pegar_ordem() -> int:
	return GerenciadorAliados.pegar_ordem(self)


func _on_DelayPular_timeout():
	dir.y = 1
