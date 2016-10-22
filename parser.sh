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

print "\n"
print "Ejercicio de parseo de argumentos con 'getopts'"
printf "-----------------------------------------------\n"
print "[*] Lista de argumentos: "$@
print "[*] Cantidad de argumentos: "$#
print "\n"

# for i in {1..$#}; do
#     print ${i}
# done

while getopts ":ab:c:F:h:H:u:U:" opt; do
    case $opt in
        a) 
            echo "[+] '-a' se encontro." >&2
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
        F)
            echo "[+] -F se encontro, se espera una fecha"
            echo "[-] Argumento: $OPTARG"
            _F=$(date "+%Y-%m-%d" --date=${OPTARG})     # con esto parseo y formateo la fecha
            print "[*] La fecha parseada es $_F"
            ;;
        [h,H])
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
            ;;
        :)
            echo "Opcion -$OPTARG requiere argumento." >&2
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))
print "[*] Optind: $OPTIND"

echo "b = ${_B}"
echo "c = ${_C}"

