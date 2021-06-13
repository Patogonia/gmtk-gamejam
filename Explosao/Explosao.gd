extends Area2D

func _ready():
	var tamanho = self.scale
	$AnimatedSprite.play("default")
	$Tween.interpolate_property(self, "scale", tamanho, tamanho * 1.7, 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, "modulate", self.modulate, Color("#00ffffff"), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property(self, "scale", self.scale, tamanho * 2.4, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	self.queue_free()


func _on_Explosao_body_entered(body):
	if (body.has_method("dano")):
		body.dano(1)
	if (body.has_method("_explode")):
		body._explode()
