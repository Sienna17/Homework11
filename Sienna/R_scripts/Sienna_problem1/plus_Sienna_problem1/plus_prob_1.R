copy_dir<-function(dirname, prefix){
  wd<-setwd(dirname)
  
  my_wd<-getwd()
  basename_wd<-basename(my_wd)
  files<-list.files()
 # browser()
  n<-length(files)

  new_dir_name<-paste(prefix,basename_wd,sep="")
  Sys.setenv(new_dir_name = new_dir_name)
  system("mkdir $new_dir_name")

 #browser()
  for ( i in 1:n){
    cur_file<-files[i]
    Sys.setenv(cur_file=cur_file)
    system ("cp $cur_file $new_dir_name")
    setwd(new_dir_name)
    new_filename<-paste(prefix, files[i], sep="")
    Sys.setenv(new_filename=new_filename)
    system("mv $cur_file $new_filename")
  }}

copy_dir2<-function(dirname,prefix){
  wd<-setwd(dirname)
  my_wd<-getwd()
  basename_wd<-basename(my_wd)
 
  files<-list.files()
  n<-length(files)
  
  new_dir<-paste(prefix,basename_wd,sep="")
  #browser()
  dir.create(new_dir)
  
  
  #browser()
   for (i in 1:n){
     cur_file<-files[i]
     file.copy(cur_file,new_dir)
   }
  browser()
  setwd(new_dir)
   for (i in 1:n){
     cur_file<-files[i]
     new_file<-paste(prefix,cur_file,sep="")
     file.rename(cur_file,new_file)
   }
}
  



