tail(quakes, n = 10)

write.csv(quakes, "quakes.csv")
x<- read.csv(file.choose(),header=T)


df <- head(quakes, 100)
gc<-data.frame(lon=df$long, lat=df$lat)

gc
x["mag"]
x$mag
x$mag[2]
x
mag
x[1, "mag"] <- 4.5
x$mag[2] <- 4.6

hist(mag, main="지진분포", xlab="강도", ylab="건수", col=rainbow(7), breaks=seq(4, 6.5, 0.5))

boxplot(mag, main="분포", xlab = "지진", ylab = "건수", col="red")
data <- data[data$행정구역.시군구.별 != "전국",]

head(data2)

x<-grep("도$", data2$행정구역.시군구.별)
x
data3 <- data2[-c(x),]
data3

x <- grep("도$", data$행정구역.시군구.별)
x
data2 <- data[c(x),]
head(data2)

data5 <- rbind(data, data2)
head(data5)
dim(data5)

x<- -100
if(x>10) {
  cat(x, '는 양수')
} else if (x <0) {
  cat(x, '는 음수')
} else {
  cat(x, '는 zero')
}

sum <- 0
for(i in 1:10) {
  sum <- sum + i
}
print(sum)

sum <- 0
i <- 1
while (i <= 10) {
  sum <- sum + i
  i <- i + 1
}
print(sum)

sum <- 0

for(i in 1:10) {
  if(i %% 2 == 0)
    next
  sum <- sum + i
}
print(sum)

func1 <- function(a,b) {
  result <- a + b
cat(a, '와', b, '의', result)
}
func1(10, 20)

x<- c(1,2,3,NA, 5, 6, 7, NA, 9 ,10)
print(mean(x, na.rm = T))
print(length(x))
print(sum(x, na.rm=T))

result <- ifelse(!is.na(x), x, 0)
print(result)
print(mean(result))

x<- c(1,2,3,NA, 5, 6, 7, NA, 9 ,10)
result <- ifelse(!is.na(x), x, mean(x, na.rm = T))

print(result)
print(mean(result))

airquality
z <- airquality$Ozone
print(mean(z, na.rm = T))
y <- ifelse(!is.na(z), z, 0)
print(mean(y))
x <- ifelse(!is.na(z), z, mean(z, na.rm = T))
print(mean(x))


height <- c(8,12,20,5)
name <- c("1부", "2부", "3부", "부")
barplot( names.arg = name,  ylab = "실적", main="부서실적",xlab="부서", col=rainbow(7),height)


sale1 <- c(8, 12, 20, 5)
sale2 <- c(12, 6, 8, 15)
sales <- rbind(sale1, sale2)
legend_name <- c("1분기", "2분기")
barplot(sales, names.arg = name,xlab="부서",ylab="영업실적",main="부서별 영업실적",col=c("red","blue"),ylim = c(0,30), legend.text = legend_name, beside = TRUE)

options(scipen = 100)
women
weight <- women$weight
weight
plot(weight)

weight<- women$weight
height <- women$height
plot( height, weight, ylab = "몸무게",xlab = "키",  type="b")

summary(quakes)
mag <- quakes$mag
hist(mag, main="분포", xlab="강도", ylab="건수", col=rainbow(7), breaks=seq(4,6.5,0.5))

xyplot(lat~long , data=quakes, pch=".")
depth.group <- equal.count(quakes$depth, number=5, overlap=0)
depth.group
xyplot(lat~long | depth.group, data=quakes)


library(wordcloud)
word <- c("서울", "부산", "대구")
freq <-c(300, 230, 150)
wordcloud(word, freq,random.order = F, random.color = F, colors=rainbow(7))

pal <- brewer.pal(8, "RdYlGn")
wordcloud(word, freq, colors=pal)

x <- grep("도$", data3$행정구역.시군구.별)
data4 <- data3[-c(x),]
data5 <- data4[data4$순이동.명.>0,]
word <- data5$행정구역.시군구.별
freq <- data5$순이동.명.
wordcloud(word, freq, colors = pal, random.order=F, random.color=F)
install.packages("wordcloud2")
library(wordcloud2)
word_table <- data.frame(word, freq)
word_table
wordcloud2(word_table)



data.frame(word, freq)



quakes
head(quakes)

head(quakes, n=10)
tail(quakes)

names(quakes)
str(quakes)
#num은 실수가능, int는 정수만 가능

summary(quakes)

write.csv(quakes, "quakes.csv")

x <- read.csv(file.choose(), header = T)

x
head(x)
#100개의 위도, 경도 정보를 데이터프레임으로 저장
df <- head(quakes, n=100)
df

gc <- data.frame(lon=df$long, lat=df$lat)
gc

x["mag"] # 진도를 백터형식으로 추출
x$mag #출력했을 때 앞에 [1]의 의미 가장 처음있는 변수의 위치 ex) [53] 4.6 5.3 4.2 ... ->  4.6의 위치는 53번째이다
x$mag[2]

x[1, "mag"] <- 4.5
x$mag

x$mag[2] <- 4.6
x$mag

mag <- quakes$mag
hist(mag)
hist(mag, col = rainbow(7), breaks = seq(4, 6.5, 0.5), main = "지진발행강도분포")

boxplot(mag, col="red") #검은 선이 중앙값(평균값 아니다), 통계적으로 크게 벗어난 값(극단값)은 동그라미로 표시된다, 빨간부분은 어떠한  범위를 나타낸다

data <- read.csv(file.choose(), header = T, fileEncoding = "euc-kr")

head(data)
data2 <- data[data$행정구역.시군구.별 != "전국",] #전국의 내용을 제외하기 (쉼표의 왼쪽은 행, 오른쪽은 열 중요!! 행하나, 열하나를 다룰 때도 쉼표는 꼭 있어야한다)
head(data2)

x <- grep("도$", data2$행정구역.시군구.별) #"도$" -> 도로 끝나는 행번호 조회
x
data3 <- data2[-c(x),] #x값을 제외한 행
tail(data3, n=15)
