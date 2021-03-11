## Get Info of the RPM file 
```
rpm -qp --info fake.rpm 
```

## Get Info of OS of the RPM file
```
rpm -q --qf '%{os}\n'  fake.rpm 
```
