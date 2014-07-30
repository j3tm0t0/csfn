Mappings.amis=amznAmiMapping # specify hash in *header* file

Resources.small=
  Type: "AWS::EC2::Instance"
  Properties:
    ImageId: "Fn::FindInMap":["amis",{Ref:"AWS::Region"},"pv"]
    InstanceType: "m1.small"

Resources.medium=
  Type: "AWS::EC2::Instance"
  Properties:
    ImageId: "Fn::FindInMap":["amis",{Ref:"AWS::Region"},"hvm"]
    InstanceType: "m3.medium"
