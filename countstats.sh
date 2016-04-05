# Counts player stats and outputs to CSV
echo "Agent,MU gained,Portals captured,Resonators deployed,Links created,Fields created,Resonators destroyed,Links destroyed,Fields destroyed,MU freed"
PLAYERS=`cut -f2 $1 | sort -f | uniq | grep '^<' | sed 's/[<>]//g'`
for PLAYER in $PLAYERS
do
  MU=`grep -oE "$PLAYER>\s+.+ \+[0-9]+ MUs" $1 | awk '{s+=$(NF-1)} END {print s}'`
  PORTALS=`grep -Ec "$PLAYER>\s+captured" $1`
  RESOS=`grep -Ec "$PLAYER>\s+deployed a Resonator" $1`
  LINKS=`grep -Ec "$PLAYER>\s+linked" $1`
  FIELDS=`grep -Ec "$PLAYER>\s+created a Control Field" $1`
  MU_FREED=`grep -oE "$PLAYER>\s+.+ \-[0-9]+ MUs" $1 | awk '{s-=$(NF-1)} END {print s}'`
  RESOS_DESTROYED=`grep -Ec "$PLAYER>\s+destroyed a Resonator" $1`
  LINKS_DESTROYED=`grep -Ec "$PLAYER>\s+destroyed the Link" $1`
  FIELDS_DESTROYED=`grep -Ec "$PLAYER>\s+destroyed a Control Field" $1`
  echo $PLAYER,$MU,$PORTALS,$RESOS,$LINKS,$FIELDS,$RESOS_DESTROYED,$LINKS_DESTROYED,$FIELDS_DESTROYED,$MU_FREED
done
