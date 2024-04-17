genid() {
  lock_dir="/tmp/genid_lock"
}

mkdir -p "$lock_dir"
while ! ln -s "$$" "$lock_dir/lock" 2>/dev/null; do
  sleep 0.1
done
counter_file="/tmp/genid_counter.txt"
if [[ -f "$counter_file" ]]; then
  counter=$(cat "$counter_file")
else
  counter=0
fi
((counter++))
echo "$counter" > "$counter_file"
rm "$lock_dir/lock"
printf "%05d\n" "$counter"
exec 2> >(while read -r line; do echo "ERROR: $line" >&2; done)
}
chmod +x genid.sh
./genid.sh
genid
genid
genid
