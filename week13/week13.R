install.packages("igraph")
library(igraph)

# make_star(스타형)
G.star <- make_star(6, mode=c("undirected"), center=1) %>% set_vertex_attr("name", value=c("A", "B", "C", "D", "E", "F"))

G.star <- make_star(6, mode=c("undirected"), center=1)

plot(G.star, vertex.color=rainbow(6), vertex.size=60)
# undirected 방향성이 없다.


# make_ring(링형)
G.ring = make_ring(6, directed = F, circular = T) %>% set_vertex_attr("name", value = c("A", "B", "C", "D", "E", "F"))
plot(G.ring, vertex.color=rainbow(6), vertex.size=60)


# Y형 그래프(Y형 그래프는 Y형 함수가 없기 때문에 그래프를 직접 구현해야한다)
G.Y <- make_graph(edges = NULL, n=NULL, directed = F)
G.Y <- G.Y + vertices("A", "B", "C", "D", "E", "F")
G.Y <- G.Y + edges("A", "B", "A", "C", "A", "D", "D", "E", "E", "F")
plot(G.Y, vertex.color=rainbow(6), vertex.size=40)


# 함수를 이용한 연결 정도 계산
degree(G.star) # 연결정도 중심성
degree(G.star, normalized = T) # 정규화된 연결정도 중심성
CD <- centralization.degree(G.star, normalized = F) # 연결정도 중심화
CD


# 파일 읽기와 그래프 출력
df.fb <- read.table(file.choose(), header=F)
head(df.fb)
tail(df.fb)
G.fb <- graph.data.frame(df.fb, directed = F)
plot(G.fb)


# 1 ~ 50사용자들 그래프
V(G.fb)$name # 노드 이름 출력
v.set <- V(G.fb)$name[1:50] # 1 ~ 50번째 노드집합
G.fb.part <- induced_subgraph(G.fb, v=v.set) # 부분그래프 생성
plot(G.fb.part, vertex.color=rainbow(6), vertex.size=10) # 그래프 출력
# 노드의 개수가 50개 50이상인 숫자가 그래프에 보이는 것은 이름이기 때문


# ID가 1인 사용자와 연결된 그래프
v2 <- which(V(G.fb)$name == "1") # 노드 이름을 이용하여 버텍스 저장
v2
v.set <- neighbors(G.fb, v = v2) # v2와 연결된 이웃정보
v3 <- c(v2, v.set) # 노드 병합(벡터로 합친다)
G.fb.id <- induced_subgraph(G.fb, v = v3) # 그래프 정보 저장
V(G.fb.id)$color <- ifelse(V(G.fb.id)$name == "1", "red", "yellow") # 정보는 G.fb.id에 들어가 있다.
plot(G.fb.id)


# 아이디가 10인 사용자의 친구들을 포함한 그래프 그리기
v2 <- which(V(G.fb)$name == "10") # 노드 이름을 이용하여 버텍스 저장
v2
v.set <- neighbors(G.fb, v = v2) # v2와 연결된 이웃정보
v3 <- c(v2, v.set) # 노드 병합(벡터로 합친다)
G.fb.id <- induced_subgraph(G.fb, v = v3) # 그래프 정보 저장
V(G.fb.id)$color <- ifelse(V(G.fb.id)$name == "10", "red", "yellow") # 정보는 G.fb.id에 들어가 있다.
plot(G.fb.id)