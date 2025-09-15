trap cleanup SIGQUIT
trap cleanup_term SIGTERM
trap cleanup_kill SIGKILL

cleanup () {
  echo '====received quit'
}
cleanup_term () {
  echo '====received term'
}
cleanup_kill () {
  echo '====received kill'
}
while true
do
  sleep 1
  echo 'Hello'
done
