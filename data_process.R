setwd("C:/Users/p-condemine/Documents/D4Good/")
load("dt_aida_pri.RData")
require(data.table)
nms=names(dt_aida_pri)
labs=grep("DIM",x = nms)

for (l in labs){
  lab=dt_aida_pri[[l]]
  if(length(names(lab))==2){
    for (k in which(!1:length(dt_aida_pri)%in%labs)){
      tab=dt_aida_pri[[k]]
      if(names(lab)[1]%in%names(tab)){
        num=which(names(tab)%in%names(lab)[1])
        lev=data.table(x=factor(levels(factor(tab[[num]]))))
        setnames(lev,"x",names(lab)[1])
        lev=merge(lev,lab,by=names(lab)[1],all.x=T,all.y=F)
        tab[[num]]=as.factor(as.character(tab[[num]]))
        levels(tab[[num]])<-lev[[2]]
        dt_aida_pri[[k]]<-tab
      }
    }
  } else {
    for (k in which(!1:length(dt_aida_pri)%in%labs)){
      tab=dt_aida_pri[[k]]
      if(names(lab)[1]%in%names(tab)){
        id_lab=names(lab)[c(grep(pattern="CD_",x=names(lab)),grep(pattern="ID_",x=names(lab)))]
        id_tab=names(tab)[c(grep(pattern="CD_",x=names(tab)),grep(pattern="ID_",x=names(tab)))]
        id=names(lab)[which(id_lab%in%id_tab)]
        tab<-merge(tab,lab,by=id,all.x=T,all.y=F)
        dt_aida_pri[[k]]<-tab
      }
    }
  }
}


dt_aida_pri<-pblapply(dt_aida_pri,function(x){
  for (nm in names(x)){
    format=class(x[[nm]])
    print(format)
    if (format%in%c("character")){
      x[[nm]]<-factor(x[[nm]])
    }
  }
  x
})
names(dt_aida_pri)<-nms

lapply(dt_aida_pri,summary)

save(list="dt_aida_pri",file="db.RData")


