#include<stdio.h>
int c[10][100];/*对应每种情况的最大价值*/
int knapsack(int m,int n)
{
int i,j,w[10],p[10];
for(i=1;i<n+1;i++)
        scanf("/n%d,%d",&w[i],&p[i]);
for(i=0;i<10;i++)
      for(j=0;j<100;j++)
           c[i][j]=0;/*初始化数组*/
for(i=1;i<n+1;i++)
      for(j=1;j<m+1;j++)
           {
            if(w[i]<=j) /*如果当前物品的容量小于背包容量*/
                     {
                      if(p[i]+c[i-1][j-w[i]]>c[i-1][j])

                           /*如果本物品的价值加上背包剩下的空间能放的物品的价值*/

                         /*大于上一次选择的最佳方案则更新c[i][j]*/
                            c[i][j]=p[i]+c[i-1][j-w[i]];
                            else
                            c[i][j]=c[i-1][j];
                     }
              else c[i][j]=c[i-1][j];
            }
return(c[n][m]);
                    
}

int main()
{
    int m,n;int i,j;
    scanf("%d,%d",&m,&n);
    printf("Input each one:/n");
    printf("%d",knapsack(m,n));
    printf("/n");/*下面是测试这个数组,可删除*/
     for(i=0;i<10;i++)
      for(j=0;j<15;j++)
         {
          printf("%d ",c[i][j]);
             if(j==14)printf("/n");
         }
    //system("pause");
}
