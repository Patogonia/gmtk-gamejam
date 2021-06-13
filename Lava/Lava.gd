extends Area2D

func _ready():
	$AnimatedSprite.play("default")

func _on_Lava_body_entered(body):
	if (body.has_method("dano")):
		body.dano(100)
