# Cloud Deployment

To work with the cloud you must have [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) installed. The subfolder [parts](./parts) contains the files to deploy the application to your cloud account in your personal cloud namespace. 

Before you can use this you must do the following:

- Install your config file into your ~/.kube folder

   Replace $GITHUB_ACCOUNT with your github account name and $EMAIL prefix of the email that you have used to register in the LeoCloud (only the part **before** the **@**). 

   There is a script create-deployment.sh that you can use to do this automatically. 
   Let us suppose your github account is john-doe and your email is john.doe@example.com
   Then you can run:
```bash
   cd k8s
   chmod +x ./create-deployment.sh
   ./create-deployment.sh john-doe john.doe@example.com
```

This will generate a file **deployment.yaml**

After that you can run

```bash
kubectl apply -f deployment.yaml
```

When want to remove your deployment you execute the following:
```bash
kubectl delete -f deployment.yaml
```
