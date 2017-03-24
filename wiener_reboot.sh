
SC_SCRIPT="$(realpath "$0")"
SC_SCRIPTNAME="$(basename "$SC_SCRIPT")"
TOP="$(dirname "$SC_SCRIPT")"

PDU1="10.4.3.12"
PORT="4"

bash ${TOP}/on_off_at_port.bash ${PDU1} cycle ${PORT}

