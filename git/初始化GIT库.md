# Command line instructions


## Git global setup

```bash
git config --global user.name "xxx"
git config --global user.email "xxxx@xxx.com"
```
## Create a new repository

```bash
git clone git@git.mogo.com:xxxx/test.git
cd test
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```

## Existing folder or Git repository

```bash
cd existing_folder
git init
git remote add origin git@git.mogo.com:xxx/test.git
git add .
git commit
git push -u origin master
```
