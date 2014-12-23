INSTANCE_NAME=${INSTANCE_NAME:=myvm}
MACHINE_TYPE=${MACHINE_TYPE:=n1-highcpu-2}
ZONE=${ZONE:=us-central1-a}

if ! $(gcloud auth list | grep -qs '(active)'); then
  gcloud auth login
fi

gcloud -q compute instances delete $INSTANCE_NAME --zone $ZONE
