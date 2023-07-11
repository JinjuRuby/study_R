 x <- 100
if (x > 0) {
  cat(x, "는 양수")
} else {
  cat(x, "는 음수")
}

 
 
x <- -100
if (x > 0) {
  cat(x, "는 양수")
} else if (x < 0) {
  cat(x, "는 음수")
} else {
  cat(x, "는 zero")
}



score <- 95
x <- ifelse(score >= 90, "best", "good")
cat(x)



tot <- 0
for(i in 1:10) {
  tot <- tot + i
}
print(tot)



sum <- 0
i <- 1
while (i <= 10) { # 조건식이 참일 경우 반복
  sum <- sum + i
  i <- i + 1
}
print(sum)



sum <- 0
for (i in 1:10) {
  if (i > 5) {
    break # 반복문 중단
  }
  sum <- sum + i
  cat(i, sum, "  ")
}



sum <- 0
for(i in 1:10) {
  if(i %% 2 == 1) # 홀수의 합
    next # 아래 행을 생략하고 다시 반복
  sum <- sum + i
}
print(sum)



#함수 정의
func1 <- function(a, b) {
  result <- a + b
  cat(a, '와', b, '의 합은', result)
}

#함수 호출
func1(10, 20)
func1(1, 2)



#함수 정의
func2 <- function(a, b) {
  result <- a + b
  return(result) # 결과 반환
}

#함수 호출
cat(func2(20, 30))

x <- func2(10, 20)
cat(x)

a <- 10
b <- 20
y <- func2(a,b)
cat(a,'와', b,'의 합은', y, '입니다.')



x <- c(1,2,3,NA,5,6,7,NA,9,10)
print(mean(x, na.rm = T)) # na : Not available
print(length(x)) # NA를 개수에 포함
print(sum(x, na.rm = T))



result <- ifelse(!is.na(x), x, 0) # 결측치를 0으로 치환
print(result)
print(mean(result))



result <- ifelse(!is.na(x), x, mean(x, na.rm = T)) # 결측치를 평균으로
print(result)
print(mean(result))



airquality
x <- airquality$Ozone
cat("결측치를 제거한 Ozone농도의 평균:", mean(x, na.rm = T))

result <- ifelse(!is.na(x), x, 0)
cat("결측치를 0으로 치환한 Ozone 농도의 평균:", mean(result))

result <- ifelse(!is.na(x), x, mean(x, na.rm = T))
cat("결측치를 평균으로 치환한 Ozone 농도의 평균:", mean(result))