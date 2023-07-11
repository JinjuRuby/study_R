height <- c(8, 12, 20, 5)
name <- c("영업1부","영업2부","영업3부","영업4부")
barplot(height, names.arg = name, xlab = "부서", ylab = "영업실적", main = "부서별 영업실적", col = rainbow(7))


#수평막대
barplot(height, names.arg = name, xlab = "부서", ylab = "영업실적", main = "부서별 영업실적", col = rainbow(7), horiz = TRUE)


sale1 <- c(8, 12, 20, 5)
sale2 <- c(12, 6, 8, 15)
sales <- rbind(sale1, sale2)
sales
legend_name <- c("1분기", "2분기")
barplot(sales, names.arg = name, xlab = "부서", ylab = "영업실적", main = "부서별 영업실적", col = c("red", "blue"), ylim = c(0, 30), legend.text = legend_name, beside = TRUE)


women
help(women)
weight <- women$weight
weight
plot(weight) # 산점도 (y축의 값만 있으면(값이 1개만 있으면) x축은 개수(인덱스)의 데이터로 분석)

height <- women$height
plot(height, weight, type = "l", lty = 2, lwd = 3) # 순서: x, y / 생략하면 y만 나타낸다



quakes
mag <- quakes$mag
mag
hist(mag)
hist(mag, main = "지진발생강도분포", xlab = "지진강도", ylab = "발생건수", col = rainbow(7), breaks = seq(4, 6.5, 0.5))


summary(quakes) # 기술통계량
summary(quakes$mag)
boxplot(mag)
boxplot(mag, main = "지진발생강도분포", xlab = "지진", ylab = "발생건수", col = 'red')


library(lattice) # 일반 프로그램에서는 이 명령 필요
airquality
xyplot(Ozone ~ Wind, data = airquality)
xyplot(Ozone ~ Wind | factor(Month), data = airquality) # Month를 사용하면 달별로 보여준다 / factor타입을 사용하면 무슨 달인지 알려준다 (대부분 factor를 사용해야 한다)


xyplot(lat ~ long, data = quakes, pch = ".")



quakes$depth
depth.group <- equal.count(quakes$depth, number = 5, overlap = 0) # equal.count(data, number=n, overlap = 0) 여기서는 지진 깊이를 5개 영역으로
depth.group


xyplot(lat ~ long | depth.group, data = quakes)