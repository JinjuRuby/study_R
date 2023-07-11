install.packages("RCurl")
install.packages("rvest")
install.packages("stringr")
library(XML)
library(RCurl) # 웹사이트 접속 및 다운로드 관련
library(rvest) # 태그 분석 및 스크래핑 관련
library(stringr)


searchName <- URLencode("노트북")

url <- paste("http://browse.auction.co.kr/search?keyword=%eb%85%b8%ed%8a%b8%eb%b6%81&itemno=&nickname=&frm=hometab&dom=auction&isSuggestion=No&retry=&Fwk=", searchName, "&acode=SRP_SU_0100&arraycategory=&encKeyword=", searchName, "&v=g", sep = "")
url
htmlDoc <- read_html(url, encoding = "UTF-8") # 유니코드형식 인코딩된 사이트 # HTML문서 가져오기 #정제하는 작업 필요
prod_name1 <- html_nodes(htmlDoc, xpath="//span[@class='text--title']")
prod_name1 # 파일을 텍스트로 만든다?
prod_name2 <- html_text(prod_name1) # 경로의 내용만 추출 (태그가 사라짐)
prod_name2
prod_name3 <- str_trim(prod_name2) # 문자열 양쪽 공백제거
prod_name3

#가격정보
price1 <- html_nodes(htmlDoc, xpath="//strong[@class='text--price_seller']")
price1
price2 <- html_text(price1)
price2
price3 <- gsub(",","", price2) # 특정문자열 치환(price2에서 ","를 ""로 치환)
price3

df <- data.frame(상품명=prod_name3, 가격=price3) #행렬(테이블)구조로 만든다 = 데이터프레임 형식으로 변환
head(df)
View(df) # 테이블 형식으로 볼 수 있다

write.csv(df, "webscrap.csv", row.names = F, fileEncoding = "euc-kr") # 엑셀에서 사용할 경우


url<- "https://ncov.kdca.go.kr/tcmBoardList.do?brdId=&brdGubun=&dataGubun=&ncvContSeq=&contSeq=&board_id=140&gubun="

doc <- getURL(url) # 시큐어사이트일 경우
doc
htmlDoc <- htmlParse(doc, encoding = "UTF-8") # 파싱가능한 변수
htmlDoc
board_subject <- xpathSApply(htmlDoc, "//td[@class='ta_l']/a", xmlValue)
board_subject
board_part <- xpathSApply(htmlDoc,"//div[@class='board_list']//tbody/tr/td[3]", xmlValue)
board_part
df2 <- data.frame(제목=board_subject, 담당=board_part)
df2
write.csv(df2, "board.csv", row.names = F, fileEncoding = "euc-kr")
