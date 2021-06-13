extends "res://Inimigos/Inimigo.gd"

const PROJETIL = preload("res://Projeteis/Bola_de_fogo/BolaDeFogo.tscn")

var canalizando: bool = false
var jogador: Node


func _ready():
	imune = true
	jogador = get_node("/root/Jogo/Jogador")


func _process(_delta) -> void:
	$AnimatedSprite.flip_h = jogador.global_position < self.global_position


func _explode():
	if (canalizando):
		$CanalizacaoTimer.stop()
		canalizando = false
		imune = false
		$AnimatedSprite.play("stunado")
		$StunTimer.start()


func _empurrao(direcao_empurrado):
	if (canalizando):
		$CanalizacaoTimer.stop()
		canalizando = false
		imune = false
		$AnimatedSprite.play("stunado")
		$StunTimer.start()


func atirar():
	var projetil = PROJETIL.instance()
	get_parent().add_child(projetil)
	projetil.iniciar(jogador.global_position, self.global_position + Vector2(0, -4), false, true)


func _on_CanalizacaoTimer_timeout():
	canalizando = false
	$AnimatedSprite.play("atirando")
	atirar()
	yield(get_tree().create_timer(0.5), "timeout")
	$AnimatedSprite.play("default")
	$AtaqueTimer.start()


func _on_AtaqueTimer_timeout():
	canalizando = true
	$AnimatedSprite.play("canalizando")
	$CanalizacaoTimer.start()


func _on_StunTimer_timeout():
	imune = true
	$AnimatedSprite.play("default")
	$AtaqueTimer.start()
