#Check your working directory
file.exists("household_power_consumption.txt")
data<-read.table("household_power_consumption.txt",sep=";",header=T)
data$Date<-as.Date(data$Date,format="%d/%m/%Y")

#Tidy Data
data07<-subset(data,data$Date=="2007-02-01"|data$Date=="2007-02-02")
data07$Date<-as.Date(data07$Date,format="%d/%m/%Y")
Ex.Time<-paste(data07$Date,data07$Time, sep=" ")
Ex.Time<-strptime(Ex.Time,format="%Y-%m-%d %H:%M:%S")
tdata<-data.frame(Ex.Time,data07[,3:9])
for (j in 2:8){
  tdata[,j]<-as.character(tdata[,j])
  tdata[,j]<-as.numeric(tdata[,j])
}


#Plot 4
par(mfrow=c(2,2))
plot(tdata$Global_active_power~tdata$Ex.Time,type="n",xlab="",
     ylab="Global Active Power",cex.lab=0.7,cex.axis=0.7)
lines(tdata$Global_active_power~tdata$Ex.Time)

plot(tdata$Voltage~tdata$Ex.Time,type="n",xlab="datetime",
     ylab="Voltage",cex.lab=0.7,cex.axis=0.7)
lines(tdata$Voltage~tdata$Ex.Time)

plot(tdata$Sub_metering_1~tdata$Ex.Time,type="n",xlab="",
     ylab="Energy sub metering",cex.lab=0.7,cex.axis=0.7)
lines(tdata$Sub_metering_1~tdata$Ex.Time,col="black")
lines(tdata$Sub_metering_2~tdata$Ex.Time,col="orange")
lines(tdata$Sub_metering_3~tdata$Ex.Time,col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c("black","orange","blue"),cex=0.2,pt.lwd=0.0001,border="white")

plot(tdata$Global_reactive_power~tdata$Ex.Time,type="n",xlab="datetime",
     ylab="Global_reactive_power",cex.lab=0.7,cex.axis=0.7)
lines(tdata$Global_reactive_power~tdata$Ex.Time)

dev.copy(png, file="plot4.png",width=480,height=480)
dev.off()
