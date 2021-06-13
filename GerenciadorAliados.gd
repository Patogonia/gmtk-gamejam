extends Node


var aliado_sendo_controlado
var grupo_aliados := []
var diferenca_distancia_parar := 10.0
var distancia_parar_inicial := 8.0


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mudar_aliado"):
		mudar_de_aliado()


func mudar_de_aliado() -> void:
	var pos_aliado_atual = grupo_aliados.find(aliado_sendo_controlado)
	aliado_sendo_controlado.camera.current = false
	aliado_sendo_controlado = grupo_aliados[(pos_aliado_atual + 1) % grupo_aliados.size()]
	aliado_sendo_controlado.camera.current = true


func pegar_distancia_parar(aliado) -> float:
	return distancia_parar_inicial + (pegar_ordem(aliado) - 1) * diferenca_distancia_parar


func pegar_vida_extra():
	for aliado in grupo_aliados:
		if aliado.e_vida_extra:
			return aliado

	return null


func pegar_ordem(aliado) -> int:
	var pos_aliado := grupo_aliados.find(aliado)
	var pos_aliado_controlado := grupo_aliados.find(aliado_sendo_controlado)
	var dif_pos := pos_aliado - pos_aliado_controlado

	if dif_pos > 0:
		return dif_pos

	var dif_controlado_ao_ultimo = grupo_aliados.size() - pos_aliado_controlado
	return dif_controlado_ao_ultimo + pos_aliado
