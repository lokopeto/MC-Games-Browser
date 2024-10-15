extends Node
@onready var status_display: Label = $"../Status" #status text

var git = "\"utils/git/bin/git.exe\"" + " "
var zip = "\"utils/7z2300-extra/x64/7za.exe\"" + " "
var curl = "\"utils/curl-8.1.2_2-win64-mingw/bin/curl.exe\"" + " " #location of git, space adittion for command execution

var git_clone = "https://github.com/lokopeto/UltraMenu.git" #git url for git.exe clone
var folder_name = git_clone.replace("https://github.com/", "").replace("/","-").replace(".git","") #simple syntax for name, only works on github
var java_versions = ["8", "11", "17", "21"]

var rcon_port = "26666"
var rcon_pass: String = str(randf_range(0, 99999999999999999)) + str(randf_range(0, 99999999999999999)) + str(randf_range(0, 99999999999999999))

# java for executing
var java8 = ""
var java11 = ""
var java17 = ""
var java21 = ""

# download links of java
var java8_down
var java11_down
var java17_down
var java21_down

func java_type(java_type: String):
	if java_type == "temurin":
		java8_down = "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u422-b05/OpenJDK8U-jre_x64_windows_hotspot_8u422b05.zip"
		java11_down = "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.24%2B8/OpenJDK11U-jre_x64_windows_hotspot_11.0.24_8.zip"
		java17_down = "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.12%2B7/OpenJDK17U-jre_x64_windows_hotspot_17.0.12_7.zip"
		java21_down = "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.4%2B7/OpenJDK21U-jre_x64_windows_hotspot_21.0.4_7.zip"

var servers: Dictionary = {
	"lokopeto-UltraMenu": {"url": "asd","java": "21","jar": "purpur"}
	
	
}
