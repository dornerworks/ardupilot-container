#!/bin/bash

numCopters=$1
initialAgentLat=$2
initialAgentLon=$3
initialAgentAlt=$4
initialAgentHeading=$5
incrementStepLat=$6
incrementStepLon=$7
COPTERMODEL=$8
SPEEDUP=$9

incrementStepAlt=0
incrementStepHdg=0

echo "Number of Copters: $numCopters"

# Start ArduPilots
LAT=${initialAgentLat}
LON=${initialAgentLon}
ALT=${initialAgentAlt}
HDG=${initialAgentHeading}

echo "Initial Position: $LAT,$LON,$ALT,$HDG"
echo "Increment Lat: $incrementStepLat"
echo "Increment Lon: $incrementStepLon"
echo "CopterModel: $COPTERMODEL"
echo "SPEEDUP: $SPEEDUP"

arduPilotInstance=0

if [ $numCopters != 0 ]; then
	for i in $(seq 0 $(($numCopters-1))); do

           VEHICLE=arducopter
           INSTANCE=$arduPilotInstance

           export SITL_RITW_TERMINAL="screen -D -m -S Copter${INSTANCE}"

           mkdir /${VEHICLE}${INSTANCE} && cd /${VEHICLE}${INSTANCE}

           cp /copter.parm copter.parm
           echo "SYSID_THISMAV   ${INSTANCE}" >> copter.parm

           simCommand="/ardupilot/Tools/autotest/sim_vehicle.py \
              -I${INSTANCE} \
              --vehicle ArduCopter \
              --custom-location=${LAT},${LON},${ALT},${DIR} \
              -w \
              --speedup ${SPEEDUP} \
              --add-param-file copter.parm \
              --no-rebuild \
              --no-mavproxy"

           echo "Starting Sim ${VEHICLE} with command '$simCommand'"
           exec $simCommand &
           pids[${arduPilotInstance}]=$!

           #Make it so all the instances don't start at the same Lat/Lon
           LAT=$(echo "$LAT + $incrementStepLat" | bc)
           LON=$(echo "$LON + $incrementStepLon" | bc)
           ALT=$(echo "$ALT + $incrementStepAlt" | bc)
           HDG=$(echo "$HDG + $incrementStepHdg" | bc)

           # Increment arduPilotInstance
           let arduPilotInstance=$(($arduPilotInstance+1))
           
           # This shouldn't be necessary, but let's give it some time to spin-up
           sleep 3

	done
fi

#sleep 3
#screen -list

# wait for all pids
for pid in ${pids[*]}; do
    wait $pid
done
