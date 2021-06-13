extends KinematicBody2D

var vida: int = 2
var vivo: bool = true
var imune: bool = false


func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		dano(1)


func dano(dano_tomado):
	if ((not imune or dano_tomado >= 100) and vida > 0):
		vida -= dano_tomado
		$Tween.interpolate_property(self, "modulate", Color("#ffff4040"), Color("#ffffffff"), 0.2, Tween.TRANS_LINEAR)
		$Tween.start()
		if (vida <= 0):
			vivo = false
			$Tween.stop_all()
			$Tween.remove_all()
			morrer()
			$Tween.interpolate_property($AnimatedSprite, "scale", $AnimatedSprite.scale, $AnimatedSprite.scale / 3, 0.3, Tween.TRANS_LINEAR)
			$Tween.interpolate_property($AnimatedSprite, "rotation_degrees", $AnimatedSprite.rotation_degrees, $AnimatedSprite.rotation_degrees + 360, 0.3, Tween.TRANS_LINEAR)
			$Tween.interpolate_property(self, "modulate", Color("#ffffffff"), Color("#20ffffff"), 0.3, Tween.TRANS_LINEAR)
			$Tween.start()
			yield($Tween, "tween_all_completed")
			self.queue_free()


func morrer():
	pass
