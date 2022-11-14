
#######  Select DEGs from RNA seq Data
setwd("F:/胶质瘤诱导分化组学数据分析/Data")  
Gene_RPKM=read.table("F:/胶质瘤诱导分化组学数据分析/Data/GBM_gene_RPKM.txt")
Gene_S=Gene_RPKM[,1:5]  ## Sensitive cell line
Gene_R=Gene_RPKM[,6:10] ## Resistant cell line


timestart<-Sys.time()
DEG_S=NA;
for (i in 1:dim(Gene_S)[1]) 
{ for (j in 1:5)
  { for (k in 1:max(j-1,1))
    {if ((max(Gene_S[i,])>=50) & (Gene_S[i,k]>0) & (Gene_S[i,j]/Gene_S[i,k]>5 || Gene_S[i,j]/Gene_S[i,k]<0.2)){
      DEG_S=rbind(DEG_S,Gene_S[i,])
    }
    }
  }
}

DEG_S=unique(DEG_S)
DEG_S=DEG_S[-1,]
timeend<-Sys.time()
runningtime<-timeend-timestart
print(runningtime)


summary(DEG_S)
dim(DEG_S)

plot(c(0,6,12,24,48),DEG_S["STC1",],type="b",main="DEG_S",sub='',xlim=c(0,50), ylim=c(min(DEG_S["STC1",]), max(DEG_S["STC1",])),xlab="Time (Hours)",ylab='Gene Expression')



####  DEG of resistance 

timestart<-Sys.time()
DEG_R=NA;
for (i in 1:dim(Gene_R)[1]) 
{ for (j in 1:5)
{ for (k in 1:max(j-1,1))
{if ((max(Gene_R[i,])>=50) & (Gene_R[i,k]>0) & (Gene_R[i,j]/Gene_R[i,k]>5 || Gene_R[i,j]/Gene_R[i,k]<0.2)){
  DEG_R=rbind(DEG_R,Gene_R[i,])
}
}
}
}

DEG_R=unique(DEG_R)
DEG_R=DEG_R[-1,]
timeend<-Sys.time()
runningtime<-timeend-timestart
print(runningtime)


summary(DEG_R)
dim(DEG_R)

plot(c(0,6,12,24,48),DEG_R["STC1",],type="b",main="DEG_R",sub='',xlim=c(0,50), ylim=c(min(DEG_R["STC1",]), max(DEG_R["STC1",])),xlab="Time (Hours)",ylab='Gene Expression')


########## 

intersect(rownames(DEG_S),rownames(DEG_R))


#####  Save DEGs 
setwd("F:/胶质瘤诱导分化组学数据分析/Results")  
write.table(DEG_S, file="Drug Sensitive Genes.txt") 
write.table(DEG_R, file="Drug Resistant Genes.txt") 


DEG_S=read.table("F:/胶质瘤诱导分化组学数据分析/Results/Drug Sensitive Genes.txt")
DEG_R=read.table("F:/胶质瘤诱导分化组学数据分析/Results/Drug Resistant Genes.txt")



names_SR=union(rownames(DEG_S),rownames(DEG_R))

Node_gene_1=Gene_S[names_SR,]
Node_gene_2=Gene_R[names_SR,]

dim(Node_gene_2)
 