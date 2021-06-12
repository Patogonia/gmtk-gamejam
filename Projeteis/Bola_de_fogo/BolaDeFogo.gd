extends "res://Projeteis/Projetil.gd"

const EXPLOSAO = preload("res://Explosao/Explosao.tscn")


func _ready():
	velocidade = 70
	dano = 1


func trata_colisao(colisor):
	var explosao = EXPLOSAO.instance()
	explosao.position = self.position
	get_node("..").add_child(explosao)
