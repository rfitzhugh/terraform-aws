This requires your IP to be granted SSH acccess. 

To do so, go to VPCs in AWS and add `All TCP` and then select your IP. 

You will also need to generate a key, to do so use the bash console (MacOS) and type:

```
ssh-keygen -f mykey
```


Then RDP, login with Terraform username. You can see the .txt file located in the C:/


can also generate key with (replace instance id): 

```
aws ec2 get-password-data --instance-id i-asdfasdfasd --priv-launch-key mykey
```