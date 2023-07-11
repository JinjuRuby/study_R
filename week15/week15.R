# 2022-01-01 ~ 2022-06-30 종가를 학습하여 주식시세 예측
install.packages("nnet")
library(nnet)
data <- read.csv(file.choose(), header = T, fileEncoding="euc-kr")
head(data)
data$종가 <- as.numeric(data$종가) # 숫자형으로 변환하여 오버라이드
df <- data.frame(일자=data$일자, 종가=data$종가)
df
df <- df[order(df$일자),] # 일자 기준 오름차순 정렬(하지만 행 번호가 마지막부터 시작한다)
df
# 행 번호 변경
n <- nrow(df)  # 행 갯수
n
rownames(df) <- 1:n  # 행갯수만큼 행이름에 저장, 행번호가 1부터 시작됨
rownames(df)
df



Pnorm <- (df$종가-min(df$종가))/(max(df$종가)-min(df$종가))*0.9+0.05 # 현재 종가가 전체 종가의 어느 부분에 위치하는지 확인하기 위해 수식 사용
df <- cbind(df, 종가norm=Pnorm) # 열(column) 중심으로 bind
df # 최소값 0.5 최대값 0.95
n80 <- round(n*0.8,0) # 80% 위치 계산 (행)
n80
df.learning <- df[1:n80,]  # 훈련데이터
df.learning
df.test <- df[(n80+1):n,]  # 테스트데이터 (98부터 121까지)
df.test



# 10일 데이터로 5일을 예측한다 (하루씩만 차이나게 구성)
# 신경망 구성
# 1 ~ 10 -> 11 ~ 15
# 2 ~ 11 -> 12 ~ 16
# 3 ~ 12 -> 13 ~ 17
# 4 ~ 13 -> 14 ~ 18
INPUT_NODES <- 10
HIDDEN_NODES <- 10
OUTPUT_NODES <- 5
ITERATION <- 100 # 반복 횟수



# 신경망 예측 함수
getDataSet <- function(item, from, to, size) {
  dataframe <- NULL
  to <- to - size + 1
  for (i in from:to) {
    start <- i
    end <- start + size - 1
    temp <- item[c(start:end)]
    dataframe <- rbind(dataframe, t(temp))
  }
  return(dataframe)
}



# 신경망 구성을 할 때 입력을 할 때 마지막 5개의 데이터는 예측 데이터이므로 제외한다.
in_learning <- getDataSet(df.learning$종가norm, 1, 92, INPUT_NODES)
in_learning # 훈련데이터셋 입력용 (데이터가 92개인데 83까지 출력되는 이유: 저 숫자는 10개 중 가장 앞의 데이터이므로  83이다. 그 줄 마지막 데이터가 92이다.)
# 신경망 구성을 할 때 출력은 최소 11부터 가능하다(오리지널 데이터 제외하기 때문)
out_learning <- getDataSet(df.learning$종가norm, 11, 97, OUTPUT_NODES)
out_learning # 훈련데이터셋 출력용(정답용) (데이터가 83까지인데 데이터 개수가 92개인 이유: 위와 동일)



# ---------------------------------------------전처리 끝---------------------------------------------
model <- nnet(in_learning, out_learning, size=HIDDEN_NODES, maxit=ITERATION)


in_test <- getDataSet(df.test$종가norm, 1, 19, INPUT_NODES)
in_test
predicted_values <- predict(model, in_test, type="raw")
predicted_values # 신경망(RNN)이 예측한 결과값(norm)
Vpredicted <- (predicted_values-0.05)/0.9*(max(df$종가)-min(df$종가))+min(df$종가) # 실제 종가로 역변환
Vpredicted # 환산한 예측 종가



# 검증
Vreal <- getDataSet(df.test$종가, 11, 24, OUTPUT_NODES)
Vreal # 발생했던 정답 데이터, 놈(norm)으로 변환되기 전 데이터
ERROR <- abs(Vreal - Vpredicted) # 절댓값, 오차 저장
MAPE <- rowMeans(ERROR / Vreal) * 100 # 100분율로 변환 Vreal: 실제값, ERROR: 오류값
MAPE # Mean Absolute Percentage Error(평균절대비율오차), 오차의 비율로 모델 비교 (실제값과 얼마나 차이가 나는지 백분율로 표현)
mean(MAPE) # 평균



in_forecasting <- df$종가norm[88:97]
in_forecasting
predicted_values <- predict(model, in_forecasting, type="raw")
Vpredicted <- (predicted_values-0.05)/0.9*(max(df$종가)-min(df$종가))+min(df$종가)
Vpredicted # 현재 데이터셋에 없는 결과, 7월 이후 데이터와 비교필요



# 결과 시각화
plot(71:97, df$종가[71:97], xlab='기간',ylab='종가',xlim=c(71,102),ylim=c(1000,3200),type='o') # 97부터 예측한 5개의 데이터를 추가하기 위해서 xlim을 102까지 설정했다.
lines(98:102,Vpredicted, type='o', col='red') # 그래프 추가 (lines함수로 이어붙일 수 있다.)
abline(v=97,col='blue',lty=2)
