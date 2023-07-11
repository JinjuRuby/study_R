# 선형회귀 분석
head(cars) # 속도와 제동거리 관계
help(cars)
summary(cars) # 통계적 요약
str(cars) # 데이터 구조 요약
plot(dist~speed, data=cars) # 회귀모델에서 독립변수와 종속변수 지정
                            # ~를 기준으로 종속변수 ~ 독립변수의 순서
model <- lm(dist~speed, cars) # y = Wx + b, 선형회귀
model # y절편 -17.579, 기울기 3.932
abline(model) # 추세선, 경향선
coef(model)[1] # y절편
coef(model)[2] # 기울기

b <- coef(model)[1]
W <- coef(model)[2]
speed <- cars[,1]
pred <- W * speed + b
pred
compare <- data.frame(pred, cars[,2], pred - cars[,2])
colnames(compare) <- c('예상', '실제', '오차') # 열이름 생성
compare
