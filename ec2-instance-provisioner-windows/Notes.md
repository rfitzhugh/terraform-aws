This requires your IP to be granted SSH acccess. 

To do so, go to VPCs in AWS and add `All TCP` and then select your IP. 

You will also need to generate a key, to do so use the bash console (MacOS) and type:

```
ssh-keygen -f mykey
```