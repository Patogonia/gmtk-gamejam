extends "res://Inimigos/Inimigo.gd"

const PROJETIL = preload("res://Projeteis/Projetil_morcego/ProjetilMorcego.tscn")

var velocidade: float = 30
var direcao = Vector2(1,0)


func _physics_process(delta) -> void:
	if (vivo):
		direcao *= velocidade
		var colisor = move_and_collide(direcao*delta, false)
		direcao.x /= direcao.x * (1 if direcao.x > 0 else -1)
		if ($RayCast2D.is_colliding()):
			$RayCast2D.cast_to.x *= -1
			direcao *= -1


func _on_AtaqueTimer_timeout():
	if (vivo):
		atirar()


func atirar():
	var projetil = PROJETIL.instance()
	get_parent().add_child(projetil)
	projetil.iniciar(self.position - Vector2(0,-30), self.position)
