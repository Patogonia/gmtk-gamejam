extends "res://Inimigos/Inimigo.gd"

const PROJETIL = preload("res://Projeteis/Projetil.tscn")

var velocidade: float = 20
var direcao = Vector2(1,0)
var atirando: bool = false


func _physics_process(delta) -> void:
	if (vivo and not atirando):
		direcao.x *= velocidade
		var velocidade = move_and_collide(direcao*delta, false) #Vector2.UP, false, 4, 0.785398, false)
		direcao.x /= direcao.x * (1 if direcao.x > 0 else -1)
		if (not $ChaoRayCast2D.is_colliding() or $DirecaoRayCast2D.is_colliding()):
			$ChaoRayCast2D.position *= -1
			$DirecaoRayCast2D.cast_to.x *= -1
			direcao.x *= -1
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h


func atirar():
	atirando = true
	$AnimatedSprite.play("ataque")
	var projetil = PROJETIL.instance()
	get_parent().add_child(projetil)
	projetil.iniciar(get_node("/root/Jogo/Jogador").global_position, self.global_position, false, true)
	yield(get_tree().create_timer(0.2), "timeout")
	$AnimatedSprite.play("default")
	atirando = false


func _on_AtaqueTimer_timeout():
	atirar()
