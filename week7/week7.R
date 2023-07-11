gc
df
x<- read.csv(file.choose(), header=T)
x["mag"]
x$mag
head(x)
install.packages("wordcloud") # 설치 RColorBrewer도 같이 설치된다.
library(wordcloud) # 사용하겠다는 선언
word <- c("서울", "부산", "대구")
freq <- c(300, 230, 150) # word와 인자개수가 같아야한다.
wordcloud(word, freq, colors=rainbow(7), random.order = FALSE, random.color = FALSE)

pal <- brewer.pal(8, "Dark2") # 패럿 설정
wordcloud(word, freq, colors = pal, random.order = FALSE, random.color = FALSE)
data <- read.csv(file.choose(), header = T, fileEncoding = "euc-kr")
head(data)
data2 <- data[data$행정구역.시군구.별 != "전국",  ] # *******************************************시험에 나온다
x <- grep("구$", data2$행정구역.시군구.별)
data3 <- data2[-c(x), ] # c를 넣는게 좋다(벡터함수?)
head(data3)
x <- grep("도$", data3$행정구역.시군구.별)
x
data4 <- data3[-c(x),]
head(data4)
tail(data4)
data5 <- data4[data4$순이동.명. > 0, ]
head(data5)

word <- data5$행정구역.시군구.별
freq <- data5$순이동.명.
word
freq
wordcloud(word, freq, colors = pal, random.order = FALSE, random.color = FALSE)

install.packages("wordcloud2")
library(wordcloud2)
word_table <- data.frame(word, freq) # 단어와 빈도수, 이름을 지정하면 그 이름을 쓴다
word_table
wordcloud2(word_table) # 기본형 wordcloud2

wordcloud2(word_table, backgroundColor = "black", color = "random-light") # 배경 검정, 단어 밝은색

# 행정구역별 총인구수를 wordcloud, wordcloud2로 표현
library(wordcloud) # 사용하겠다는 선언
library(wordcloud2)
data6 <- read.csv(file.choose(), header = T, fileEncoding = "euc-kr")
data6
data7 <- data6[data6$행정구역.시군구.별 != "전국",  ]
y <- grep("구$", data7$행정구역.시군구.별)
data8 <- data7[-c(y), ] # c를 넣는게 좋다(벡터함수?)
data8
y <- grep("도$", data8$행정구역.시군구.별)
data9 <- data8[-c(y),]
data9
word2 <- data9$행정구역.시군구.별
freq2 <- data9$총인구수.명.
wordcloud(word2, freq2, colors = pal, random.order = FALSE, random.color = FALSE)

word_table2 <- data.frame(word2, freq2) # 단어와 빈도수, 이름을 지정하면 그 이름을 쓴다
wordcloud2(word_table2) # 기본형 wordcloud2
wordcloud2(word_table2, backgroundColor = "black", color = "random-light") # 배경 검정, 단어 밝은색