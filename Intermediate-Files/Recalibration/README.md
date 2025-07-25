#Aqui se guardan los archivos resultantes del script 09-CicloforBaseRecalibrator que ejecuta 08-BaseRecalibrator.sh
#Este paso es crucial para eliminar los sesgos sistemáticos de secuenciación
#Primero se crea una tabla de covariables con BaseRecalibrator y se aplica al arcivo .bam de la carpeta DedupsBAMs con ApplyBQSR
#Las buenas prácticas recomiendan hacer el procedimiento dos veces
