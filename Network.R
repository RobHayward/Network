#Some notes on the network session at London R
#dougmet - git hub. 
# igraph (Gabor) and statnet (statistical parts) are the two main packages. 
require(igraph)

A <- rbind(c(0,1,0), c(1,0,1), c(2,0,0))
nodeNames <- c("A", "B", "C")
dimnames(A) <- list(nodeNames, nodeNames)
A
A%*%A
# edge list is more compact
# Can use sparce matrix
#Look at noates
# Alternatively use the igraph package
# Simple but not that useful
# graph_from-Literaral
# A and B connecteed in both directions ++ from B to C and -+ from C to A
g <- graph_from_literal(A++B, B-+C, C-+A)
g
class(g)
# Efficient internal stricture
plot(g)
# details (D - directed, with N names), 3 nodes and 2 edges
#graph) lists 
graph_from_adjacency_matrix(A)
as_edgelist(g)
# two column matrix is back
#--------------------
#Treen network (no loops)
g <- make_tree(10, children = 2, mode =  "in")
plot(g)
# trees important
g <- make_full_graph(10, directed = FALSE)
plot(g)
g <- make_lattice(dimvector = c(5, 5), circular = FALSE)
plot(g)
g <- make_lattice(dimvector = c(5, 5), circular = TRUE)
plot(g)
# make a star network with 5 nodes and then convert to adjacency matrix
g <- make_star(n = 5)
plot(g)
as_edgelist(g)
as_adjacency_matrix(g, sparce = FALSE)
# This does not work above.  Why? 

# Networds from data frames
dolphineEdges <- read.csv("Data/dolphin_edges.csv")
dolphin <- graph_from_data_frame(dolphineEdges, directed = FALSE)
dolphin
plot(dolphin)
# additional columns of the data are attributes of the edges
# table with infomration about the dolphins
dolphinVertices <- read.csv("Data/dolphin_vertices.csv")
View(dolphinVertices)
# This adds the gender of the dolphins. 
str(dolphin)
dolphin <- graph_from_data_frame(dolphineEdges, vertices = dolphinVertices, 
                                 directed = FALSE)
dolphin
# the names and gender have been pulled in. 
# This is the starting point.  Usually there will be two tables, one with the edges
# one with the edges. 
# In a directed network A - b is nto teh same as B - A. 
# network can be truned into a data frame as_dataframe. 
dolphinesDF <- as_data_frame(dolphin, what = "both")
head(dolphinesDF)
# as to csv and export. 
# Can be exported to other formats.
#Network manipulation--------------------------------------------
#Looking at the atributes, adding virtices
# gender attributes 
library(igraphdata)
library(igraph)
data(package = "igraphdata")
data(USairports)
# 755 nodes and 23,000 edges
# don't plot
USairports
# lots of information on every edge
View(as_data_frame(USairports, what = "edges"))
# different types of attribute
vertex_attr_names(USairports)
vertex.attr(USairports, "City")
edge.attributes(USairports, "name")
# Vertex seldctor function
# access the attributes
V(USairports)$City
V(USairports)[1:5]$City
V(USairports)$City[1:5]
V(USairports)["JFK"]
# This can also be used to add new attributes
vcount(USairports)
v(USairports) <- sample(c("A", "B", "C"), vcount(USairports), replace = TRUE)
V(USairports)
#Check that above
#Selct all edges JFK and Boston
# Edge seletor
# E selects edges
E(USairports)["JFK" %--% "BOS"]
# selects 26 of the 23,000 edges
# The edges are the flights
E(USairports)["JFK" %->% "BOS"]
#this woudl only seldct flghts from JFK to Boston
x <- E(USairports)["JFK" %--% "BOS"]$Carrier
unique(x)
# unique carriers from JFK to Boston
inNY <- grepl("NY$", V(USairports)$City)
inCal <- grepl("CA$", V(USairports)$City)
# This could be used to select all flight (edges) between Calafornia and NY. 
ca <- V(USairports)[inCal]
ny <- V(USairports)[inNY]
E(USairports)[ca %--% ny]
# all flights between ca and ny
packageVersion()
#--------------------------------
calAirports <- induced_subgraph(USairports, inCal)
# only keeps the Calafornian flights
# Keeps only the edges determined and the vertices connected to them. 
# Thsi can be used to create (for example) all those flights connected to JFK. 
# I could also be used to take one step away from JFK. 

calAirports
plot(calAirports)
