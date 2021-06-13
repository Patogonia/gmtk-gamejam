extends "res://Inimigos/Inimigo.gd"

const PROJETIL = preload("res://Projeteis/Bola_de_fogo/BolaDeFogo.tscn")

var canalizando: bool = false


func _ready():
	imune = true


func _explode(direcao_empurrado):
	if (canalizando):
		canalizando = false
		imune = false
		$AnimatedSprite.play("stunado")
		$StunTimer.start()


func _empurrao():
	if (canalizando):
		canalizando = false
		imune = false
		$AnimatedSprite.play("stunado")
		$StunTimer.start()


func atirar():
	var projetil = PROJETIL.instance()
	get_parent().add_child(projetil)
	projetil.iniciar(get_node("/root/Jogo/Jogador").global_position, self.global_position, false, true)


func _on_CanalizacaoTimer_timeout():
	canalizando = false
	$AnimatedSprite.play("atirando")
	atirar()
	yield(get_tree().create_timer(0.3), "timeout")
	$AnimatedSprite.play("default")
	$AtaqueTimer.start()


func _on_AtaqueTimer_timeout():
	canalizando = true
	$AnimatedSprite.play("canalizando")
	$CanalizacaoTimer.start()


func _on_StunTimer_timeout():
	imune = true
	$AnimatedSprite.play("dedfault")
