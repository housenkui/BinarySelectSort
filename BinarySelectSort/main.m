//
//  main.m
//  BinarySelectSort
//
//  Created by 二哈 on 16/11/15.
//  Copyright © 2016年 侯森魁. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 每一趟排序找出最大值和最小值。将最大值放在数列的最右端a[n-1-i]，将最小值放在最左端a[i].直到i=N-1
 */
/*
 1.理清二元选择排序的基本思想
 2.书写代码
 3.写缓存
 4.计算时间复杂度
 */
#define N 100

void printArr(long a[],long n);
//升序
void selectMaxAndMin(long a[],long n);

static NSUInteger exchangeCount = 0;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        
        long a[N] ={};
        
        NSMutableString *mutableString  =[NSMutableString string];
        NSMutableString *mutableString1  =[NSMutableString string];
        
        for (int i  = 0; i < N; i++) {
            
            a[i] = arc4random()%N;
            
            if (i ==0) {
                [mutableString appendFormat:@"%ld",a[i]];
            }
            else{
                
                [mutableString appendFormat:@",%ld",a[i]];
            }
        }
        
        NSLog(@"排序前");
        //NSDesktopDirectory 写入到桌面
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *  path  = [documentPath stringByAppendingPathComponent:@"数据"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:path]) {
            //  创建文件
            
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:@{} error:nil];
        }
        NSLog(@"documentPath  =%@",documentPath);
        
        [mutableString writeToFile:[NSString stringWithFormat:@"%@/排序前%d.txt",path,N] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        //将可变字符串写入到本地桌面
        
        
        //进行二元选择排序
        selectMaxAndMin(a,N);
        
        for (int i  = 0; i < N; i++) {
            
            if (i ==0)
            {
                [mutableString1 appendFormat:@"%ld",a[i]];
            }
            else
            {
                
                [mutableString1 appendFormat:@",%ld",a[i]];
            }
        }
        [mutableString1 writeToFile:[NSString stringWithFormat:@"%@/排序后%d.txt",path,N] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        
        NSLog(@"采样数%d,交换次数%lu",N,exchangeCount);
        
        double T = log10(exchangeCount)/log10(N);
        
        NSLog(@"二元选择排序的时间复杂度为%lf",T);
        
        
        
    }
    return 0;
}

void printArr(long a[],long n){
    
    for (long i =0; i<n; i++) {
        
        NSLog(@"a[%ld] = %ld",i,a[i]);
    }
}
void selectMaxAndMin(long a[],long n){
    
    long max,min,i,j,temp;
    
    for (i = 0; i<n/2; i++) {
        
        max = min = i;
        
        for (j=i+1; j<n-i; j++) {
            
            if (a[j] < a[min])
            {
                min = j;
                exchangeCount++;
                continue;
            }
            if (a[j]>a[max]) {
                max = j;
                exchangeCount++;
            }
        }
        
        temp = a[i];
        a[i] = a[min];
        a[min] = temp;
        
        exchangeCount++;
        
        if (max==i) {
            
            //因为a[min]的值已经替换成了a[i]的值，即a[max]的值
            temp = a[n-i-1];
            a[n-i-1] = a[min];
            a[min] = temp;
        }
        else
        {
            temp = a[n-i-1];
            a[n-i-1] = a[max];
            a[max] =temp;
        }
        
        exchangeCount++;
    }
}

