
library(dplyr)

hos <-read.csv("dataset - Copy.csv")
x<- hos$hospital_death
xl<- "Hospital ID"
yl <-"No. of Deaths"

df_grp_region = hos %>% group_by(hospital_id)  %>%
  summarise(hospital_death = sum(hospital_death), 
            .groups = 'drop') %>%
  arrange((hospital_death)) %>%
  slice(1:10)

alive = hos %>% group_by(hospital_id)  %>%
  summarise(hospital_death = sum(hospital_death), 
            .groups = 'drop') %>%
  arrange((hospital_death)) %>%
  slice(11:1000)

print(df_grp_region, n= 150)

x=df_grp_region$hospital_death
length(x)
y=df_grp_region$hospital_id
y

x1=c(alive$hospital_death)
length(x1)
y1=c(alive$hospital_id)
y1


a<-length(x1)
b<-length(y1)
a


png(filename="plot_alive.png")
plot(y,x, ylim=c(-1,1),xlim=c(1,200),pch = 16,cex = 3,col="green",ylab="Vitality status", xlab= "Hospital ID")
points(y1, x1, ylim=c(-1,1),xlim=c(1,200),pch = 16,cex = 3,col="red",ylab="Vitality status", xlab= "Hospital ID")


dev.off()


png(file="piepercent.png")
p<- c(length(x),length(x1))
pie(p,col=c("pink","lightblue"),labels=c(round(100 * p/sum(p), 2), "%"), main ="Patient Vitality")
legend("topright", c("Alive", "Expired"),cex = 1, fill = c("pink","lightblue"))
dev.off()
