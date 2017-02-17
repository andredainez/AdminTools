#/bin/bash

NUM=100
BS=1m
COUNT=5
METHOD="/dev/urandom" # secure: ++++
# METHOD="/dev/random"  # secure: +++-
# METHOD="/dev/zero"    # secure: +---

# =========[ KILL ]=========================
let TOTAL=NUM*COUNT

if [[ $1 == 'kill' ]]; then
    for (( i = 0; i < 20; i++ )); do
        ddpid=$(ps aux | grep "dd if" | grep -v grep | awk '{print $2}')
        if [[ $ddpid != "" ]]; then
            kill -9 "$ddpid"
        fi
        sleep 0.1
    done
    exit 0
fi

if [[ $1 ]]; then
    c_dir="$1"
else
    c_dir=.
fi

if [[ ! -d $c_dir ]]; then
    echo "Does not exist: $c_dir"
    exit 0
fi

cd "$c_dir"

prefix="-RANDOM-DATA-FILES-REMOVEIT"
date_0=$(date '+%Y-%m-%d-%I-%M-%S')
folder="$date_0$prefix"

mkdir "$folder" && cd "$folder"

echo "Removing Previous ..."
echo ""


for i in *"$prefix.txt"; do
    rm "$i" 2>/dev/null
done

echo "Fill disk ... ($COUNT mo)"
echo ""
date_start=$(date '+%Y-%m-%d %H:%M:%S')

for (( i = 1; i <= $NUM; i++ )); do

    if [[ $i == 1 ]]; then
        # FIRST : We get random data (slow)
        dd if="$METHOD" of="$folder".txt bs=$BS count=$COUNT 1>/dev/null 2>/dev/null
    else
        # THEN : we copy it. Faster.
        date="$(date '+%Y-%m-%d-%I-%M-%S')-$RANDOM$prefix"
        cp "$folder".txt "$date$prefix".txt
    fi

    let mo_filled=$COUNT*$i
    echo "------ $mo_filled / $TOTAL mo"
done

date_stop=$(date '+%Y-%m-%d %H:%M:%S')
echo "=== Start / Stop: $date_start --> $date_stop"

cd ..
