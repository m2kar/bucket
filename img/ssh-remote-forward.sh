#! bash
# connect by
# ssh -o "ProxyJump proxy.isrc" -p $(ssh proxy.isrc cat m2-ssh-port.txt) localhost
set -x

if [ -z $PROXY_INTERVAL ];then
  PROXY_INTERVAL=5
fi

if [ -z $JUMP_HOST ]; then
  JUMP_HOST=rui@sec-ali2.vulgraph.org
fi

echo "=======================init proxy=========================="
while : ; do
  echo ""
  echo ""
  echo "connect to imakar-ryzen:rdp by:"
  echo "      ssh -vNC -L 127.0.1.2:43389:localhost:\$(ssh $JUMP_HOST cat ryzen-rdp-port.txt) $JUMP_HOST"
  echo ""
  echo ""
  echo ""
  rand_port=$(shuf -i 43300-43399 -n 1) ;
  echo "$rand_port" | ssh $JUMP_HOST "cat >ryzen-rdp-port.txt" ;
  ssh -NC -o ExitOnForwardFailure=yes -R $rand_port:localhost:3389 $JUMP_HOST;
  echo "ssh closed by remote"
  echo "restarting...."
  sleep $PROXY_INTERVAL ;
  echo "=======================restart proxy=========================="
  echo "restart proxy1.isrc `date`" ;
done;