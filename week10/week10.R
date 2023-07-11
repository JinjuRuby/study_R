# 측정소별 실시간 측정정보 조회(칠금동)

library(XML)
url <- "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?serviceKey=TIjTrvP2KOqIZkZokEFIWRzzoxPM6XKKPutsei6BjVvDIm99seCK0JyoDAOfPtl4WsDJhdjjDbSr9qigB7AoJg%3D%3D&returnType=xml&numOfRows=10&pageNo=1&stationName=%EC%B9%A0%EA%B8%88%EB%8F%99&dataTerm=DAILY&ver=1.0"
doc <- read_xml(url) # 요청한 URL로부터 XML 데이터 획득(단순 텍스트파일)
xmlFile <- xmlParse(doc) # XML 파싱
xmlRoot(xmlFile) # XML 전체 데이터 출력
df <- xmlToDataFrame(getNodeSet(xmlFile, "//item"))
df
pm10Value <- df$pm10Value # 문자열로 처리되어 계산할 수 없다.
pm10Value <- as.numeric(df$pm10Value) # 숫자형으로 변환
dataTime <- df$dataTime
ㄴpm10Value
dataTime
barplot(pm10Value, names.arg = dataTime, col="green")



# URL 분석

stationName <- URLencode("중앙탑면")
url <- paste("https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?serviceKey=TIjTrvP2KOqIZkZokEFIWRzzoxPM6XKKPutsei6BjVvDIm99seCK0JyoDAOfPtl4WsDJhdjjDbSr9qigB7AoJg%3D%3D&returnType=xml&numOfRows=10&pageNo=1&stationName=", stationName, "&dataTerm=DAILY&ver=1.0", sep = "") # paste함수는 쉼표를 이용해서 문자열을 결합할 수 있다. sep속성은 paste함수에서 문자열을 결합할 때 그 사이에 어떻게 할지 지정하는 속성이다.
url
doc <- read_xml(url)
xmlFile <- xmlParse(doc)
xmlRoot(xmlFile)
df <- xmlToDataFrame(getNodeSet(xmlFile, "//item"))
df
pm10Value <- as.numeric(df$pm10Value)
dataTime <- df$dataTime
pm10Value
dataTime
barplot(pm10Value, names.arg = dataTime, col="blue", main = "중앙탑면")



# 칠금동 1개월 데이터 상관분석

stationName <- URLencode("칠금동")
url <- paste("https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?serviceKey=TIjTrvP2KOqIZkZokEFIWRzzoxPM6XKKPutsei6BjVvDIm99seCK0JyoDAOfPtl4WsDJhdjjDbSr9qigB7AoJg%3D%3D&returnType=xml&numOfRows=1000&pageNo=1&stationName=", stationName, "&dataTerm=MONTH&ver=1.0", sep = "") # paste함수는 쉼표를 이용해서 문자열을 결합할 수 있다. sep속성은 paste함수에서 문자열을 결합할 때 그 사이에 어떻게 할지 지정하는 속성이다.
url
doc <- read_xml(url)
xmlFile <- xmlParse(doc) # XML 파싱
xmlRoot(xmlFile)
df <- xmlToDataFrame(getNodeSet(xmlFile, "//item"))
head(df)
tail(df)
summary(df) # 통계적 요약(문자열이므로 통계를 알 수 없다)
str(df)


pm10Value <- as.numeric(df$pm10Value) # NA가 존재해서 오류가 뜬다(통신장비 오류로 인해 발생. 무시해도 된니다.)
coValue <- as.numeric(df$coValue) # NA가 존재해서 오류가 뜬다(통신장비 오류로 인해 발생. 무시해도 된니다.)
o3Value <- as.numeric(df$o3Value) # NA가 존재해서 오류가 뜬다(통신장비 오류로 인해 발생. 무시해도 된니다.)
pm25Value <- as.numeric(df$pm25Value) # NA가 존재해서 오류가 뜬다(통신장비 오류로 인해 발생. 무시해도 된니다.)
pm10Value
coValue
o3Value
pm25Value
# 1개만 이상이 있어도 특정시간의 데이터 분석을 할 수 없다.(NA가 존재하는 특정시간 모두 제거)
df2 <- data.frame(pm10Value, coValue, o3Value, pm25Value)
head(df2)
tail(df2)
df3 <- na.omit(df2) # 결측치 제거한 데이터프레임 생성
dim(df3)
dim(df2)

# 상관계수
cor(df3, method = "pearson")
install.packages("corrgram")
library(corrgram)
corrgram(df3, upper.panel = panel.conf) # 상삼각 출력
