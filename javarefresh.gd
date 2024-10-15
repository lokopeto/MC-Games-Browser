extends Node
@onready var java_8_ds: Label = $"../Javastatus/Java8"
@onready var java_11_ds: Label = $"../Javastatus/Java11"
@onready var java_17_ds: Label = $"../Javastatus/Java17"
@onready var java_21_ds: Label = $"../Javastatus/Java21"

var host_statusdisplay: String #the text for display
var java_verify

func java_verif(): # verify if java is instaled
	var verify_temp: Array

	for java_ver in Utils.java_versions: #simple verification
		java_status_display(java_ver, 2)
		var java_exe_ver = FileAccess.file_exists("./java/java"+java_ver+"/java.exe")
		var javaw_exe_ver = FileAccess.file_exists("./java/java"+java_ver+"/javaw.exe")
		var java_zip_ver = FileAccess.file_exists("./java/java"+java_ver+"_down.zip") # .zip is the curl output

		if java_exe_ver and javaw_exe_ver and !java_zip_ver == true:
			verify_temp.append(true)
			java_status_display(java_ver, 0)
		else:
			verify_temp.append(false)
			java_status_display(java_ver, 1)
		# verify_temp is the boolean colection of all java verifications

#		print(java_exe_ver, javaw_exe_ver, java_zip_ver)
#		print(verify_temp)

	# the final words
	if verify_temp.has(false):
		java_verify = false # reinstall the java
	else:
		java_verify = true # ignores the download
	return java_verify

func java_status_display(java_type: String, status: int):
	var text_display: String
#	print(java_type, status)

	if status == 0:
		text_display = "Pronto"
	elif status == 1:
		text_display = "Error"
	elif status == 2:
		text_display = "Verificando"
	elif status == 3:
		text_display = "Instalando"
	
	if java_type == "8" and java_8_ds:
		java_8_ds.text = "Java8 = " + text_display
	elif java_type == "11" and java_11_ds:
		java_11_ds.text = "Java11 = " + text_display
	elif java_type == "17" and java_17_ds:
		java_17_ds.text = "Java17 = " + text_display
	elif java_type == "21" and java_21_ds:
		java_21_ds.text = "Java21 = " + text_display


func _on_timer_timeout() -> void:
	java_verif()
