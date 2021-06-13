extends "res://Projeteis/Projetil.gd"

var forca = 200

func _ready():
	velocidade = 40
	dano = 0


func _on_TimerAcabar_timeout():
	self.queue_free()


func _on_Area2D_body_entered(body):
	posicao_alvo = $RayCast2D.get_collision_point()
	if (body.has_method("_empurrao")):
		body._empurrao((body.position - position).normalized(), forca)
