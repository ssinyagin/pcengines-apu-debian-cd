## this script tests the SSD reliability by creating tens of thousands
## of small files and periodically removing those which are older than 1
## hour. The script also loads the CPU quite significantly, so the heat
## dissipation is tested as well.


TSTDIR=/var/tmp/x
BATCHSIZE=10000

test -d $TSTDIR || mkdir $TSTDIR

while true; do
    
    date
    
    CNT=$BATCHSIZE
    while [ $(( CNT -= 1 )) -ge 0 ]; do

        FNAME=`openssl rand 64 | openssl md5 | awk '{print $2}'`
        openssl rand 333 >${TSTDIR}/${FNAME}
        
    done
    
    echo Done creating $BATCHSIZE files
    
    find ${TSTDIR} -type f -mmin +60 -exec rm '{}' ';'

    echo Done cleaning

done

