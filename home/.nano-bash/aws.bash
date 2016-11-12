#######################################
# EMR
#######################################

# Find AWS instances by Tag
# 1 tag e.g Type
# 2 Value e.g bt-core-node
aws_find_instance_by_tag() {
  aws ec2 describe-instances --filters "Name=tag:$1,Values=$2" --query "sort_by(Reservations[].Instances[].{InstanceType: InstanceType, State:State.Name, InstanceId:InstanceId, PRIVAT_IP:to_string(NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress), PublicDnsName:PublicDnsName, TAGS:join(' ', sort(Tags[].Value))}, &TAGS)"
}

aws_find_instance_by_id() {
  aws ec2 describe-instances --instance-id $1 --query "sort_by(Reservations[].Instances[].{InstanceType: InstanceType, State:State.Name, InstanceId:InstanceId, PRIVAT_IP:to_string(NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress), PublicDnsName:PublicDnsName, TAGS:join(' ', sort(Tags[].Value))}, &TAGS)"
}

aws_show_sg_for_instance() {
  TMP=$(aws ec2 describe-instances --instance-id $1 --query "Reservations[].Instances[].[SecurityGroups[].[GroupId]]" --output text)
  aws ec2 describe-security-groups --group-ids $TMP --query "sort_by(SecurityGroups, &GroupName)[*].[GroupName, GroupId]"
}

aws_get_export() {
  if [ -z $1 ]; then
    echo "Please provide a profile"
    return 1
  fi

  ID=$(aws configure get aws_access_key_id --profile $1)
  KEY=$(aws configure get aws_secret_access_key --profile $1)
  echo " export AWS_ACCESS_KEY_ID='$ID'"
  echo " export AWS_SECRET_ACCESS_KEY='$KEY'"
}
