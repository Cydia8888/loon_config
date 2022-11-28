/***********************************
#!name=Color Widgets
#!desc=桌面小组件会员解锁 初次使用需点击恢复购买
#!icon=https://raw.githubusercontent.com/deezertidal/private/main/icons/colorwidgets.png
#!homepage=https://github.com/deezertidal
#!author=Marol62926

[Script]
http-response https://api.revenuecat.com/v1/(receipts|subscribers)/* script-path=https://raw.githubusercontent.com/Marol62926/MarScrpt/main/colorwidget.js,requires-body=1,max-size=0
[MITM]
hostname = api.revenuecat.com
************************************/

var obj = JSON.parse($response.body);

obj.subscriber.entitlements = {
      "pro":{
              "expires_date":"2029-05-26T05:05:04Z",
              "product_identifier":"cw_1999_ly_3d0",
              "purchase_date":"2022-04-09T05:05:04Z"
      }
  },
  
obj.subscriber.subscriptions ={
      "cw_1999_ly_3d0":{
              "billing_issues_detected_at":null,
              "expires_date":"2029-05-26T05:05:04Z",
              "is_sandbox":false,
              "original_purchase_date":"2022-04-09T05:05:04Z",
              "period_type":"normal",
              "purchase_date":"2022-04-09T05:05:04Z",
              "store":"app_store",
              "unsubscribe_detected_at":null
      }
  }

$done({body: JSON.stringify(obj)});
