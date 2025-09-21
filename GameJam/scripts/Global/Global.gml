global.oito=true
if (file_exists("save.sav")){
ini_open("save.sav")
global.oito=ini_read_real("oito","verdade",false)
ini_close()
}
global.vida=3
global.anda_p=true
global.dano_p=true
global.atira=false