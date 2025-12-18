extends Node

# 建立一個播放器實例
var bgm_player = AudioStreamPlayer.new()

func _ready():
	# 將播放器加到這個單例節點下
	add_child(bgm_player)
	
	# 設定音樂資源（請替換成你的檔案路徑）
	bgm_player.stream = load("res://assets/Farm/Audio/Musics/27 - Chill.ogg")
	bgm_player.bus = "Music" # 建議設定音訊匯流排方便控制音量
	
	# 開始播放
	bgm_player.play()

# 之後你可以透過這個函式在不同場景切換曲目
func play_music(music_path: String):
	var new_music = load(music_path)
	if bgm_player.stream == new_music:
		return # 如果是同一首歌就繼續播，不要重頭開始
	
	bgm_player.stream = new_music
	bgm_player.play()
