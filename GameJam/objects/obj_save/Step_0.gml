
if (file_exists("save.sav"))file_delete("save.sav");
ini_open("save.sav")
ini_write_real("oito","verdade",global.oito)
ini_close()
