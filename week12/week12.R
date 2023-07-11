library(XML)
library(RCurl)
library(rvest)

url <- "https://ncov.kdca.go.kr/tcmBoardList.do?brdId=&brdGubun=&dataGubun=&ncvContSeq=&contSeq=&board_id=140&gubun="
htmlDoc <- read_html(url, encoding = 'utf-8') # 문서반환
title1 <- html_nodes(htmlDoc, xpath="//td[@class='ta_l']/a") # xpath 문법으로 탐색
title1
title2 <- html_text(title1)
title2

# 파이프 사용
title <- html_nodes(htmlDoc, xpath="//td[@class='ta_l']/a") %>% html_text()
title



part <- html_nodes(htmlDoc, xpath="//div[@class='board_list']//tbody/tr/td[3]") %>% html_text()
part
date <- html_nodes(htmlDoc, xpath="//div[@class='board_list']//tbody/tr/td[4]") %>% html_text()
date

df <- data.frame(제목=title, 부서=part, 날짜=date)
head(df)
write.csv(df, "websc.csv", row.names=F)



# 여러 페이지 웹크롤링
df <- data.frame(제목=NULL,부서=NULL,날짜=NULL) # 초기화(데이터 프레임이 한 줄씩 만들어지므로 저장할 공간이 필요하다)
for (pagenum in 1:10) {
  url <- paste("https://ncov.kdca.go.kr/tcmBoardList.do?pageIndex=", pagenum, "&brdId=&brdGubun=&board_id=140&search_item=1&search_content=", sep="")
  html <- read_html(url, encoding = 'utf-8')
  title <- html_nodes(html, xpath="//td[@class='ta_l']/a") %>% html_text()
  part <- html_nodes(html, xpath="//div[@class='board_list']//tbody/tr/td[3]") %>% html_text()
  date <- html_nodes(html, xpath="//div[@class='board_list']//tbody/tr/td[4]") %>% html_text()
  subdf <- data.frame(제목=title, 부서=part, 날짜=date)
  df <- rbind(df, subdf) # 데이터 프레임을 누적시킨다(rbind인자순서: 기존내용 뒤에 subdf가 붙는다)
}
write.csv(df, "websc.csv", row.names=F)



# 1 ~ 10까지의 합(while)
total <- 0
i <- 1 # 제어변수 선언
while(i<=10) { # 조건식이 참일 경우 반복
  total <- total + i
  i <- i + 1
}
print(total)


# next 사용
total <- 0
for (i in 1:10) { # 2로 나눈 나머지가 0일 경우 스킵
  if(i%%2 == 0) # 짝수의 합을 구할 땐 나머지가 1인 경우의 합
    next # 블락 내부의 현재 아래 라인을 모두 생략하고 계속(중단 아님)
  total <- total + i
}
print(total)
