#prediction and confidence intervals
Mother<-c(70,62,72,69,66,69,67,65,69,59,72,58,72)
Father<-c(74,69,73,71,77,77,73,67,75,63,76,71,70)
Daughter<-c(69,64,70,70,69,70,68,64,70,58,71,61,69)

themodel<-lm(Daughter~Father+Mother)

newdata<-data.frame(Mother=64, Father=74)

predict(themodel,newdata, interval="confidence",level=0.99 )


Betting<-c(7,1,2,6,3,2,4,2,3,3,1,5,7,5,6)
Actual<-c(20,6,11,-6,13,19,5,14,20,13,4,-3,5,20,21)

newmodel<-lm(Actual~Betting)

new<-data.frame(Betting=7)

predict(newmodel,new,interval="prediction", level=0.95)
