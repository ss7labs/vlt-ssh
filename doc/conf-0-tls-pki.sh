VDIR=/home/pojos/vault
vault secrets enable pki
vault secrets tune -max-lease-ttl=175200h pki
vault write -field=certificate pki/root/generate/internal common_name="ca.agts.intra" ttl=175200h >$VDIR/tls/vault-cacert.pem

