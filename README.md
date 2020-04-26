
## To kill the process with some name
  ```
  FindProcess = "python3"
  ps aux | grep $FindProcess | awk '{ print $2; system("kill -9 " $2)  }'
  ``` 
