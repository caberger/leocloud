# Cloud Deployment

To work with the cloud you must have [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) installed. 
The subfolder [parts](./parts) contains the files to deploy the application to your cloud account in your personal cloud namespace. 

Before you can use this you must do the following:

- Install your config file into your ~/.kube folder

   Replace $GITHUB_ACCOUNT with your github account name and $EMAIL with the prefix of the email that you have used to register in the LeoCloud (only the part **before** the **@**). 

   There is a script [create-deployment.sh](./create-deployment.sh) that you can use to do this automatically. 
   Let us suppose your github account is _john-doe_ and your email is _john.doe@example.com_
   Then you can run:
```bash
   cd k8s
   chmod +x ./create-deployment.sh
   ./create-deployment.sh john-doe john.doe@example.com
```

When you add a github Secret *EMAIL* to your project that contains the e-Mail address that you used to register in the LeoCloud this 
e-Mail will be used to create your deployment.yaml file in the documentation (github pages) of this project. 
Otherwise the ingress for [john.doe](https://en.wikipedia.org/wiki/John_Doe) will be used.
This yaml file will contain the correct ingress for your service.

This will generate a file **deployment.yaml**

After that you can run

```bash
kubectl apply -f deployment.yaml
```

To remove your deployment from the cloud again you execute the following:
```bash
kubectl delete -f deployment.yaml
```
