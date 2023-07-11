#도, 서울시, 광역시 추출
data <- read.csv(file.choose(), header=T, fileEncoding = "euc-kr") #data에 인구자료 저장(header는 제목줄의 존재여부를 의미함)
head(data)

x <- grep("도$", data$행정구역.시군구.별)#끝에오는 것은 달러기호($), 시작하는 것은 caret기호(^)를 사용함
x
data2 <- data[c(x),]#c(x)벡터로 만들어주는 함수 c()를 사용(x만 써도 상관없다)
head(data2)

x <- grep("서울특별시", data$행정구역.시군구.별)
x
data3 <- data[c(x),]
head(data3)

x <- grep("광역시$", data$행정구역.시군구.별)
x
data4 <- data[c(x),]
head(data4)

data5 <- rbind(data2, data3, data4) #데이터 타입이 같아야? 병합할 수 있다
head(data5)
#tail(data5)
dim(data5) #행과 열의 개수

write.csv(data5, "population.csv", row.names = F, fileEncoding = "euc-kr")#write.csv를 사용하려면 데이터내용과 파일제목은 필수로 들어가야한다
#한글이 포함되어 있을 경우 fileEncoding 필요함(디폴트값은 utf-8이다)
#row.names 속성을 FALSE로 설정하면 행번호를 제거할 수 있음





data <- read.csv(file.choose(), header=T,fileEncoding = "euc-kr")
head(data)
#쉼표의 좌측은 행, 우측은 열을 나타냄
#쉼표 우측 생략시 모든 열을 나타냄

x <- grep("세종", data$행정구역.시군구.별)
x
data2 <- data[c(86),]

x <- grep("도$", data$행정구역.시군구.별)
x
data3 <- data[c(x),]

x <- grep("서울특별시$", data$행정구역.시군구.별)
x
data4 <- data[c(x),]

x <- grep("광역시$", data$행정구역.시군구.별)
x
data5 <- data[c(x),]

data6 <- rbind(data2,data3,data4,data5)
head(data6)
#tail(data6)
dim(data6)

data7 <- data.frame(행정구역=data6$행정구역.시군구.별, 남자인구=data6$남자인구수.명., 여자인구=data6$여자인구수.명.)
data7

write.csv(data7, "population2.csv", row.names=F, fileEncoding = "euc-kr")
head(data7)
data7
