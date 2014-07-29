csfn
====

CoffeeScript + CloudFormation = CoffeeScriptFormation -> csfn

## installation
```
$ npm install -g csfn
```

## usage
```
$ csfn
usage: csfn hoge.coffee [ puge.coffee ... ] > hogepuge.template
 or aws cloudformation create-stack --stack-name STACKNAME --template-body "$(csfn hoge.coffee)"

# just convert .coffee to template json

$ cat bucket.coffee
Resources.Bucket=
  Type:"AWS::S3::Bucket"
  Properties:
    BucketName: "my-special-bucket"

$ csfn bucket.coffee
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Resources": {
    "Bucket": {
      "Type": "AWS::S3::Bucket",
      "Properties": {
        "BucketName": "my-special-bucket"
      }
    }
  }
}

# create stack directly from command line by using AWS CLI
$ aws cloudformation create-stack --stack-name mybucket --template-body "$(csfn bucket.coffee)"
arn:aws:cloudformation:ap-northeast-1:123456789012:stack/mybucket/5de182a0-fe91-11e3-92e7-5088487c4896

```

## what you can do with csfn
+ You can write templates more simple way (without tons of {} and ,)
+ You can put comments in the template
+ You can use here document (handy for cloud-init userscript)

```
commands = '''
#!/bin/sh
yum install -y httpd
service httod start
chkconfig httpd on
'''

:

Resources.Webserver=
  Type: "AWS::EC2::Instance"
  Proprerties:
     :
    UserData: "Fn::Base64":command
```
+ You can use loop!

```
# 1 Master
Resources.Master=
  Type: "AWS::RDS::DBInstance"
  Properties:
    AllocatedStorage: 5
    DBInstanceClass: "db.t1.micro"
    Engine: "mysql"
    EngineVersion: "5.6.17"
    MasterUsername: "admin"
    MasterUserPassword: "password"

# 5 x Read Replicas
for i in [1..5]
  Resources["Slave"+i]=
    Type: "AWS::RDS::DBInstance"
    Properties:
      SourceDBInstanceIdentifier: "Ref":"Master"
```
