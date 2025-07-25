#Los archivos VCF pass serán los archivos de entrada en SigProfiler, el cual se corre en 
#lenguaje de Python y puede realizarse dentro de la misma terminal Linux con el comando

python3

#Y se realiza lo siguiente
from SigProfilerMatrixGenerator import install as genInstall
genInstall.install('GRCh38')

from SigProfilerExtractor import sigpro as sig

def main_function():

sig.sigProfilerExtractor(input_type="vcf", output="../Results/sigProfiler/ ", input_data="../ Results/VCFs/VCF_pass/", reference_genome='GRCh38', exome=False, minimum_signatures=1, maximum_signatures=10,nmf_replicates=100, cpu=4, make_decomposition_plots=True)


#Se obtienen diferentes carpetas y gráficos. 
#En los resultados obtenidos se encuentran tablas que sirven como archivo de entrada para deconstructSigs.
