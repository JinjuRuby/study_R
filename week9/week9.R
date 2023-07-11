# 인구현황(XML) 조회
install.packages("XML") # 한 번만 사용하면 된다
library(XML)
xmlFile <- xmlParse(file.choose())
xmlRoot(xmlFile) # top-level 노드 출력 (꼭 작성해야하는 코드는 아니다. xml문서내용을 확인할 때 사용)
df <- xmlToDataFrame(getNodeSet(xmlFile, "//population")) # xml파일을 dataframe으로 변환(행열구조로 만들 수 있는 상황일 때 사용) population만 찾으면 데이터 프레임으로 만들어 준다는 코드
head(df)

x <- grep("특별시$", df$area)
data1 <- df[c(x),]
data1

x <- grep("광역시$", df$area)
data2 <- df[c(x),]
x
data2

data3 <- rbind(data1, data2)
data3

area <- data3$area
area
population <- as.numeric(data3$total) # 숫자 형식으로 변환
population
options(scipen=100)
barplot(population, names.arg=area, xlab="지역", ylab="인구수", main="지역별 인구수", col=rainbow(7))


# 시도별 실시간 측정정보 조회
install.packages("xml2") # 한 번만 사용
library(xml2)
url <- "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?serviceKey=TIjTrvP2KOqIZkZokEFIWRzzoxPM6XKKPutsei6BjVvDIm99seCK0JyoDAOfPtl4WsDJhdjjDbSr9qigB7AoJg%3D%3D&returnType=xml&numOfRows=100&pageNo=1&sidoName=%EB%8C%80%EC%A0%84&ver=1.0" # 공백이 있으면 안된다
url

doc <- read_xml(url) # 요청한 URL로부터 XML 데이터 획득
xmlfile <- xmlParse(doc) # XML 파싱
xmlRoot(xmlfile) # XML 전체 데이터 출력
df <- xmlToDataFrame(getNodeSet(xmlfile, "//item")) # item노드의 서브 노드들을 항목명으로 하여 데이터 프레임으로 변환
head(df)
stationName <- df$stationName
pm10Value <- as.numeric(df$pm10Value) # 숫자형으로 변환
barplot(pm10Value, names.arg=stationName, col=rainbow(7))



# 제주 지역의 실시간 측정정보
url2 <- "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?serviceKey=TIjTrvP2KOqIZkZokEFIWRzzoxPM6XKKPutsei6BjVvDIm99seCK0JyoDAOfPtl4WsDJhdjjDbSr9qigB7AoJg%3D%3D&returnType=xml&numOfRows=100&pageNo=1&sidoName=%EC%A0%9C%EC%A3%BC&ver=1.0"

doc2 <-read_xml(url2)
xmlfile2 <- xmlParse(doc2)
xmlRoot(xmlfile2)
df2 <- xmlToDataFrame(getNodeSet(xmlfile2,"//item"))
stationName2 <- df2$stationName
pm10Value2 <- as.numeric(df2$pm10Value)
barplot(pm10Value2, names.arg = stationName2, col=rainbow(7))



