#! /bin/zsh
#
# ------------------------------------------------------------------------------
# Es un ejercicio de parseo de argumentos con 'getopts'
# Ver:
# http://wiki.bash-hackers.org/howto/getopts_tutorial
# http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt
# http://stackoverflow.com/questions/16483119/example-of-how-to-use-getopts-in-bash
# Fecha: 2016-10-18
# Creado: Ezequiel Meinero
# ------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Print ayuda
function Uso {
    print "Uso:"
    print "\tparser [-F fecha] [-H horario] [-d Delta time] [-u user|code]\n"
    print "\tdonde:"
    print "\tFecha: es la fecha del marcaje en formato YYYYMMDD o YYYY-MM-DD"
    print "\tHorario: es el horario del marcaje en formato HH:mm"
    print "\tDelta Time: es el delta time desde el momento de ejecucion en segundos"
    print "\tUser: usuario o codigo\n\n"
}
#-------------------------------------------------------------------------------


print "\n"
print "Ejercicio de parseo de argumentos con 'getopts'"
printf "-----------------------------------------------\n"
print "[*] Lista de argumentos: "$@
print "[*] Cantidad de argumentos: "$#
print "\n"

# for i in {1..$#}; do
#     print ${i}
# done

while getopts ":ab:c:f:F:hH:u:U:" opt; do
    case $opt in
        a) 
            echo "[+] '-a' se encontro." >&2
            Uso
            exit 1
            ;;
        b)
            echo "[+] '-b' se encontro, se espera argumento"
            echo "[-] Argumento: $OPTARG"
            _B=${OPTARG}
            ;;
        c)
            echo "[+] '-c' se encontro, se espera argumento"
            echo "[-] Argumento: $OPTARG"
            _C=${OPTARG}
            ;;
        [f,F])
            echo "[+] -F se encontro, se espera una fecha"
            echo "[-] Argumento: $OPTARG"
            _F=$(date "+%Y-%m-%d" --date=${OPTARG})     # con esto parseo y formateo la fecha
            print "[*] La fecha parseada es $_F"
            ;;
        h)
            Uso
            exit 1
            ;;
        H)
            echo "[+] -H se encontro, se espera un horario"
            echo "[-] Argumento: $OPTARG"
            _SECS=$(( RANDOM%60 ))                                  # valor de segs random para que no quede 
                                                                    # siempre en 00 segundos
            _H=$(date "+%H:%M:%S" --date="${OPTARG} $_SECS secs")   # con esto parseo y formateo la fecha
                                                                    # y le sumo SECS segundos random 
            print "[*] La hora parseada es $_H"
            ;;
        [u,U])
            echo "[*] u se encontro."
            _U=${OPTARG}
            print "[*] User: $_U"
            ;;
        \?)
            echo "Opcion invalida: -$OPTARG" >&2
            Uso
            #exit 1
            ;;
        :)
            echo "Opcion -$OPTARG requiere argumento." >&2
            exit 1
            ;;
    esac
done

print "[*] Saliendo..."
shift $((OPTIND-1))
printf '<%s>\n' "$@"
#print "[*] Optind: $OPTIND"
#
#echo "b = ${_B}"
#echo "c = ${_C}"

