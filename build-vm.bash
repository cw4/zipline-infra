INSTANCE_NAME=${INSTANCE_NAME:=myvm}
MACHINE_TYPE=${MACHINE_TYPE:=n1-highcpu-2}
PROJECT=${PROJECT:=myproject}
ZONE=${ZONE:=us-central1-a}
scriptdir=$(cd $(dirname "$0"); pwd)

which gcloud >/dev/null
if [ $? -ne 0 ]; then
  echo 'gcloud not in $path'
  exit 0
fi
if ! $(gcloud auth list | grep -qs '(active)'); then
  gcloud auth login
fi

gcloud config set project quant-magic-1
gcloud compute instances create $INSTANCE_NAME --image centos-7 --zone us-central1-a --machine-type $MACHINE_TYPE --no-boot-disk-auto-delete
instance_ip=$(gcloud compute instances list | grep -P "\\b$INSTANCE_NAME\\b" | perl -p -e 's/^\S+\s+\S+\s+\S+\s+\S+\s+(\S+)\s+.*$/$1/')

echo instance IP is $instance_ip

ssh_options="-o 'UserKnownHostsFile /dev/null' -o 'StrictHostKeyChecking no'"

# wait for vm to be ready
i=0
while [ $i -lt 50 ] ; do
  i=$((i + 1))
  eval "ssh -o \"UserKnownHostsFile /dev/null\" -o \"StrictHostKeyChecking no\" $instance_ip /bin/true" && break
  sleep 1; echo -n .
done

# copy over and run the script needed for zipline dependencies
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" $scriptdir/on-vm-root.bash $instance_ip:~/
ssh -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -t -t $instance_ip sudo bash ~/on-vm-root.bash
