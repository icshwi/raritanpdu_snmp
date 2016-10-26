#!/bin/bash
#
#  Copyright (c) 2016 Jeong Han Lee
#  Copyright (c) 2016 European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# Author : Jeong Han Lee
# email  : han.lee@esss.se
# Date   : 
# version : 0.0.1

#
# 1) Download pdu2_mib.txt
# 2) Move it to ~/.snmp/mibs
# 3) Rename it to PDU2-MIB
#

set -efo pipefail

declare -gr GET="snmpget"
declare -gr SET="snmpset"

declare -gr MIB="PDU2-MIB"

# ICS lab, we have only one available currently. 2016-10-25

declare -gr IP="10.4.3.13"
declare -gr SET_USER="essics"


function SET_CMD {
    local ipaddr=${1};
    local outlet=${2};
    local status=${3};
    sleep 1;
    ${SET} -v2c -c ${SET_USER} -m+${MIB} ${ipaddr} ${MIB}::switchingOperation.1.${outlet} = ${status};
}

#snmpset -v2c -c essics -m+PDU2-MIB 10.4.3.13 PDU2-MIB::switchingOperation.1.7 = off
#snmpset -v2c -c essics -m+PDU2-MIB 10.4.3.13 PDU2-MIB::switchingOperation.1.7 = on


# we can cycle it, but we have to wait a period defined by
#snmpset -v2c -c essics -m+PDU2-MIB 10.4.3.13 PDU2-MIB::outletPowerCyclingPowerOffPeriod.1.7 = 2
#snmpget -v2c -c public -m+PDU2-MIB 10.4.3.13 PDU2-MIB::outletPowerCyclingPowerOffPeriod.1.7

# ${SET} -v3c -c essis -m+${MIB} ${IP} ${MIB}::switchingOperation.1.7 = cycle


# What should we do?
DO="$1"

case "$DO" in

    on)
      SET_CMD "${IP}" "7" "on";
        ;;
    off)
      SET_CMD "${IP}" "7" "off";
        ;;
    
    cycle)
      SET_CMD "${IP}" "7" "off";
      SET_CMD "${IP}" "7" "on";

        ;;
    *)
        echo "">&2
        echo "usage: $0 <command>" >&2
        echo >&2
        echo "  commands: " >&2
        echo ""
        echo "          on   : ">&2
        echo "" 
        echo "          off  : >&2
        echo ""
        echo "          cycle :  ">&2
        echo >&2
        exit 0
        ;;
esac

exit
