#######################################
# EC2
#######################################

# Find AWS instances by Tag
# 1 tag e.g Type
# 2 Value e.g bt-core-node
aws_ec2_find_instance_by_tag() {
  aws ec2 describe-instances --filters "Name=tag:$1,Values=$2" --query "sort_by(Reservations[].Instances[].{LaunchTime: LaunchTime, InstanceType: InstanceType, State:State.Name, InstanceId:InstanceId, PRIVAT_IP:to_string(NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress), PublicDnsName:PublicDnsName, TAGS:join(' ', sort(Tags[].Value))}, &TAGS)"
}

aws_ec2_find_instance_by_private_ip() {
  aws ec2 describe-instances --filters "Name=private-ip-address,Values=$1" --query "sort_by(Reservations[].Instances[].{InstanceType: InstanceType, State:State.Name, InstanceId:InstanceId, PRIVAT_IP:to_string(NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress), PublicDnsName:PublicDnsName, TAGS:join(' ', sort(Tags[].Value))}, &TAGS)"
}

aws_ec2_find_instance_by_id() {
  aws ec2 describe-instances --instance-id $1 --query "sort_by(Reservations[].Instances[].{InstanceType: InstanceType, State:State.Name, InstanceId:InstanceId, PRIVAT_IP:to_string(NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress), PublicDnsName:PublicDnsName, TAGS:join(' ', sort(Tags[].Value))}, &TAGS)"
}

aws_ec2_change_instance_type() {
  aws ec2 modify-instance-attribute --instance-id $1 --instance-type $2
}

aws_ec2_get_userdata() {
  aws ec2 describe-instance-attribute --instance-id $1 --attribute userData --query "UserData.Value" --output text | base64 -d
}

aws_ec2_start_instance() {
  aws ec2 start-instances --instance-ids $1
}

aws_ec2_stop_instance() {
  aws ec2 stop-instances --instance-ids $1
}

aws_ec2_terminate_instance() {
  aws ec2 terminate-instances --instance-ids $1
}

#######################################
# Security groups
#######################################

aws_show_sg_for_instance() {
  TMP=$(aws ec2 describe-instances --instance-id $1 --query "Reservations[].Instances[].[SecurityGroups[].[GroupId]]" --output text)
  aws ec2 describe-security-groups --group-ids $TMP --query "sort_by(SecurityGroups, &GroupName)[*].[GroupName, GroupId]"
}

aws_sgs() {
  aws ec2 describe-security-groups --query "sort_by(SecurityGroups, &GroupName)[*].[GroupName, GroupId]"
}

aws_sg_get_name_from_id(){
  aws ec2 describe-security-groups --group-ids $1 --query "SecurityGroups[].[GroupName]"
}

aws_sg_show_infos(){
  aws ec2 describe-security-groups --group-ids $1 --query "SecurityGroups[].IpPermissions[].{ToPort:ToPort, IpProtocol:IpProtocol, FromPort:FromPort, CidrIp:join(' ',IpRanges[].CidrIp), GroupId:join(' ',UserIdGroupPairs[].GroupId)}"
}

#######################################
# EMR
#######################################

aws_emr_active_cluster() {
  aws emr list-clusters --active --query "Clusters[*].{ID: Id, NAME: Name}"
}

aws_emr_last_steps() {
  max=$2
  if [ -z $max ]; then
    max=10
  fi
  aws emr list-steps --cluster-id $1 --max $max --query "Steps[*].[Id, Status.State, Status.Timeline.CreationDateTime, Status.Timeline.StartDateTime, Status.Timeline.EndDateTime]"
}

aws_emr_step_runtime() {
  START="$(date -u "+%s" -d @"$(aws emr list-steps --step-states=RUNNING --cluster-id $1 --query "Steps[*].[Status.Timeline.StartDateTime]" --output text)")"
  END="$(date -u "+%s")"
  echo $((END-START)) | awk '{print "Current Step runtime: "int($1/60)" minutes"}'
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
