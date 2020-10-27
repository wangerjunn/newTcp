//
//  ApplePayViewController.m
//  NewTcpApp
//
//  Created by xslp on 2020/10/14.
//  Copyright © 2020 xslpiOS. All rights reserved.
//

#import "ApplePayViewController.h"
#import <StoreKit/StoreKit.h>
@interface ApplePayViewController () <SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic, copy) NSString *receipt;
@end

@implementation ApplePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"内购测试"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    [self.view addSubview:self.payBtn];
    
    
}

- (void)applePayAction {
    //是否允许内购
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"用户允许内购");

        //bundleid+xxx 就是你添加内购条目设置的产品ID
        NSArray *product = [[NSArray alloc] initWithObjects:@"bundleid+xxx",nil];
        NSSet *nsset = [NSSet setWithArray:product];

        //初始化请求
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
        request.delegate = self;

        //开始请求
        [request start];

    }else{
        NSLog(@"用户不允许内购");
    }
}

- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [[UIButton alloc] init];
        
        [_payBtn setTitle:@"购买" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(applePayAction) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnWidth = 80;
        CGFloat btnHeight = 40;
        _payBtn.layer.cornerRadius = btnHeight/2.0;
        _payBtn.layer.masksToBounds = YES;
        _payBtn.layer.borderColor = [UIColor greenColor].CGColor;
        
        _payBtn.frame = CGRectMake((kScreenWidth-btnWidth)/2.0, 180, btnWidth, btnHeight);
        
    }
    
    return _payBtn;
}

#pragma mark - SKProductsRequestDelegate
//接收到产品的返回信息，然后用返回的商品信息进行发起购买请求
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response NS_AVAILABLE_IOS(3_0)
{
    NSArray *product = response.products;

    //如果服务器没有产品
    if([product count] == 0){
        NSLog(@"没有该商品");
        return;
    }

    SKProduct *requestProduct = nil;
    for (SKProduct *pro in product) {

        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);

        //如果后台消费条目的ID与我这里需要请求的一样（用于确保订单的正确性）
        if([pro.productIdentifier isEqualToString:@"bundleid+xxx"]){
            requestProduct = pro;
        }
    }

    //发送购买请求
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:requestProduct];
        payment.applicationUsername = @"userId";//可以是userId，也可以是订单id，跟你自己需要而定
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark -- SKPaymentTransactionObserver
//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    for(SKPaymentTransaction *tran in transactions){
            switch (tran.transactionState) {
                case SKPaymentTransactionStatePurchased:
                    NSLog(@"交易完成");
                    [self completeTransaction:tran];

                    break;
                case SKPaymentTransactionStatePurchasing:
                    NSLog(@"商品添加进列表");

                    break;
                case SKPaymentTransactionStateRestored:
                    NSLog(@"已经购买过商品");
    //                [[SKPaymentQueue defaultQueue] finishTransaction:tran]; 消耗型商品不用写

                    break;
                case SKPaymentTransactionStateFailed:
                    NSLog(@"交易失败");
                    [[SKPaymentQueue defaultQueue] finishTransaction:tran];

                    break;
                default:
                    break;
            }
        }
}

//交易结束,当交易结束后还要去appstore上验证支付信息是否都正确,只有所有都正确后,我们就可以给用户发放我们的虚拟物品了。
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    //发送POST请求，对购买凭据进行验证
    
    
    NSURL *url = [NSURL URLWithString:AppStore_URL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];
    urlRequest.HTTPMethod = @"POST";
    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    _receipt = encodeStr;
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", encodeStr];
    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest.HTTPBody = payloadData;
    
    [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            
        }
    }];
    
    NSData *result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    //[NSURLSession dataTaskWithRequest:completionHandler:]
    if (result == nil) {
        NSLog(@"验证失败");
        return;
    }

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"请求成功后的数据:%@",dic);
    //这里可以通过判断 state == 0 验证凭据成功，然后进入自己服务器二次验证，,也可以直接进行服务器逻辑的判断。
    //本地服务器验证成功之后别忘了 [[SKPaymentQueue defaultQueue] finishTransaction: transaction];

    NSString *productId = transaction.payment.productIdentifier;
    NSString *applicationUsername = transaction.payment.applicationUsername;

    NSLog(@"applicationUsername++++%@",applicationUsername);
    NSLog(@"payment.productIdentifier++++%@",productId);

    if (dic != nil) {
        //临时注释
//        userId = applicationUsername;
//        //服务器二次验证
//        [self vertifyApplePayRequestWith:transaction];
    }
}

#pragma mark - SKRequestDelegate
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error:%@", error);
}

//请求结束
- (void)requestDidFinish:(SKRequest *)request
{
    NSLog(@"请求结束");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
