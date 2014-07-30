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
