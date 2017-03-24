# raritanpdu_snmp

A simple script to reboot an outlet of PX3-5260V [1] in order to reboot a board quickly.

### Information

* PDU2-MIB file form the ratitan PDU directly
* Recent MIB file is found at [2]
* SNMP Usage is found at [3]


## Requirement

Centos
```
# yum install net-snmp net-snmp-utils
```
```
mkdir $HOME/.snmp/
ln -s ${PWD}/mibs ${HOME}/.snmp/mibs

```

### Reference
[1] http://www.raritan.com/product-selector/pdu-detail/px3-5260v

[2] https://www.raritan.com/support/product/px3

[3] http://cdn.raritan.com/download/PXE/v3.2.30/mib-usage.pdf
