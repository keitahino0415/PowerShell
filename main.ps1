$ROOT_PATH =  Get-Location
$FILE_MONITOR_PATH = "./File_Monitor.ps1"

#対象のフォルダ指定
$MONITOR_FOLDER_PATH = ("./target_file/")

#下記に対象のファイル名を記載
$TARGET_CONF_PATH = ("./Target_Conf.text")

#リトライする回数
$RETRY_MAX = 30

#リトライする頻度
$WAIT_SEC = 1

.($FILE_MONITOR_PATH)
File_Monitor $MONITOR_FOLDER_PATH $TARGET_CONF_PATH $RETRY_MAX $WAIT_SEC
