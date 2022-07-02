
OPT=$1

if [[ $OPT == "apply" ]]; then
   echo "Apply Backend.."
   cd global/backend &&   terraform init && terraform apply -auto-approve  && cd - 
   sleep 10
   cd global/backend &&  mv backend.tf.bak backend.tf  && terraform init && cd -
   echo "Apply Network.."
   cd env/dev/network &&  terraform init && terraform apply -auto-approve && cd -
   echo "Apply Services.."
   cd env/dev/services &&  terraform init && terraform apply -auto-approve && cd -
   echo "SUCCESS" 

fi


if [[ $OPT == "destroy" ]]; then
   echo "destroy service resouces....."
   cd env/dev/service && terraform destroy -auto-approve && cd - 
   echo "destroy network resouces....."
   cd env/dev/network && terraform destroy -auto-approve && cd - 
   echo "destroy backend resouces....."
   cd global/backend && mv backend.tf backend.tf.bak  && terraform init -migrate-state  && terraform destroy -auto-approve && cd -
fi