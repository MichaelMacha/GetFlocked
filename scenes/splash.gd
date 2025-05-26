extends Node3D

func _ready() -> void:
	$Sprite3D.modulate = Color.from_hsv(randf(), 0.8, 1.5)
	$AudioStreamPlayer.play()

func _on_audio_stream_player_finished() -> void:
	queue_free()
