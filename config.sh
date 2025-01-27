#!/bin/bash

export SENZING_ENGINE_CONFIGURATION_JSON='{
 "PIPELINE" : {
 "CONFIGPATH" : "/etc/opt/senzing",
 "RESOURCEPATH" : "/opt/senzing/g2/resources",
 "SUPPORTPATH" : "/opt/senzing/data"
 },
 "SQL" : { "CONNECTION" : "postgresql://postgres:Cr4ckH4mm3r##@192.168.1.2:5432:g2" }
}'
