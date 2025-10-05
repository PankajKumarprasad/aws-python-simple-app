# aws-python-simple-app
end to end C.I aws project

Few error you will get while doing the end to end CI aws python flask app

1.  if you are only using parameter-store but not using variable then then you get build error ?
solution -  go to buildspec.yml and add blank varible( in the old yaml not neccessary in new yaml syntax)
env:
  variable: {}



2.  make sure you copy  the parameter-store variable name correctly otherwise you will get error like "Phase context status code: Decrypted Variables Error Message: parameter does not exist: /myapp/docker_credential/url"  - just go to system manager and check the variable name

3. make sure your dockerhub token ( account setting-> access token ) have read/write permission - so that aws codebuild can push the latest version of docker image to your registry.

4. give SSMAdminAcess to your service role of codebuild to access AWS System manager. click on the serive role (arn:aws:iam::aws-account-id:role/service-role/codebuild-
   python-aws-app-service-role)  -> attach permission -> SSMAdminAccess( for demo purpose ) ->save

5. Give permission 
Privileged
Enable this flag if you want to build Docker images or want your builds to get elevated privileges.

******************************************************************************************************************************************************

for the CD part
--------------------

1. After creating the EC2 instance you need to attach IAM role to it so codeDeploy can acess it. for attaching you go to ec2-instance-id -> action -> security -> Modify IAM role . but you are not able to find the role even after creating it
solution -  For those who are not able to update IAM role to the EC2 instance created, pls follow below steps to solve the problem. 

IAM --> Roles --> Create role --> AWS Service --> Use Case (select EC2) --> Next --> Permission Policies --> Select "AWSCodeDeployFullAccess"

Now if you seach you will get the it role


2. While creating deployment group you will get an error like "AWS CodeDeploy does not have the permissions required to assume the role arn:aws:iam::aws-account-id:role/codeDeploy_deployment_grp_role." 
solution - go to role/codeDeploy_deployment_grp_role -> trust relationship and add below

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "codedeploy.amazonaws.com",
                    "ecs.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}




