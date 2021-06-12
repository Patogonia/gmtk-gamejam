extends "res://Projeteis/Projetil.gd"

func _ready():
	randomize()
	velocidade = rand_range(70,100)
	dano = 1
	$Tween.interpolate_property(self, "rotation_degrees", self.rotation_degrees, 80, 1.5, Tween.TRANS_LINEAR)
	$Tween.start()
