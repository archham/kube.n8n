

# Prepare N8N setup on k3s node

test -d runtime && echo ERROR, runtime dir exists, not good
test -d runtime && exit 1

genpasswd() {
        local l=$1
        [ "$l" == "" ] && l=32
           tr -dc A-Za-z0-9_=.,+- < /dev/urandom | head -c ${l} | xargs
 }


export NAMESPACE=n8n-devel
export ENC_KEY=$(genpasswd)
export FQDN=n8n-devel.domain.tld
export VERSION="1.0.10"

mkdir runtime
cp -av *.yml README.md runtime/
cd runtime/

sed -i "s/__NAMESPACE__/$NAMESPACE/g" *.yml README.md
sed -i "s/__ENC_KEY__/$ENC_KEY/g" *.yml README.md
sed -i "s/__FQDN__/$FQDN/g" *.yml README.md
sed -i "s/__VERSION__/$VERSION/g" *.yml README.md

echo "Done, go and follow runtime/README.md"


