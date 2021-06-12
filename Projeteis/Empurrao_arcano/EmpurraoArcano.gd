extends "res://Projeteis/Projetil.gd"

func _ready():
	velocidade = 4
	dano = 0
	$Alvo.global_position = get_global_mouse_position()


func _on_TimerAcabar_timeout():
	self.queue_free()


func _on_Area2D_body_entered(body):
	if (body.has_method("_empurrao")):
		body._empurrao($Alvo.global_position)
