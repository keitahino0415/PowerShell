#受信ファイル監視処理
Function File_Monitor(
    $TARGET_PATH
  , $TARGET_CONF_PATH
  , $RETRY_MAX
  , $WAIT_SEC
){
  $COUNT = 0
  $TARGET_STRING = @{}
  $REPLACE = @{}
  $CHECK_FLG = "1"
  $DATA_FLG = "1"
  $DATA_ARRAY = @{}

  $buf = (Select-String -pattern  "target" –path $TARGET_CONF_PATH | foreach{$_.ToString().split(":")[3]})
Write-host($buf)
  For($i=0;$i -lt $buf.COUNT;$i++){
    $DATA_ARRAY[$i] = $TARGET_PATH + $buf[$i]
  }

  For($i=0;$i -lt $DATA_ARRAY.count;$i++){
    $CHECK_FLG += "1"
  }

  Write-host("-----受信監視処理-----")

  #ファイル監視処理
  While($COUNT -lt $RETRY_MAX){
    For($i=0;$i -lt $DATA_ARRAY.COUNT;$i++){
      If(Test-Path $DATA_ARRAY[$i]) {
        $DATA_FLG += "1"
      }else{
        $DATA_FLG += "0"
      }
      If($DATA_FLG -eq $CHECK_FLG){
        Break
      }
    }
#    フラグ確認用
    Write-host($DATA_FLG)

    If($DATA_FLG -eq $CHECK_FLG){
      Write-host("やっと対象ファイル揃った！！！")
      Write-host("----受信監視処理----")
      Break
    }
    Write-host("対象ファイルまだ来ないのかよ・・・")
    $DATA_FLG = "1"
    Start-Sleep -s $WAIT_SEC
    $COUNT++
  }
}
