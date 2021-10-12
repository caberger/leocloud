echo "alter user"
echo "this server can only be accessed within this namespace, so we don't care that everybody can see this trivial password."
echo "ALTER USER 'user'@'%' IDENTIFIED WITH mysql_native_password BY 'password';"|mysql -uroot --password=password --database=mysql 
echo "done alter user..."
