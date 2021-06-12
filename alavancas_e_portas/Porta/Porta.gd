extends StaticBody2D

var aberta: bool = false

func abrir():
	aberta = true
	$AnimatedSprite.play("Aberta")
	$CollisionShape2D.disabled = true
