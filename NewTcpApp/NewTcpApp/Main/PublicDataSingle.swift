//
//  PublicDataSingle.swift
//  GroupChatPlungSwiftPro
//
//  Created by 柴进 on 2017/3/15.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

let sharePublicDataSingle = PublicDataSingle()

struct PublicData {
    // structure definition goes here
    var avater = "" //头像地址
    var userid = "" //用户id
    var corpid = "" //公司id
    var realname = "" //真实姓名
    var access_token = "" //accToken
    var im_token = "" //imToken
}

class PublicDataSingle: NSObject {

//    static let sharePublicDataSingle = PublicDataSingle()
    var publicData = PublicData()
    var userId:NSString = ""//用户id
//    var token:NSString = "MDAwMDAwMDAwMJ6tsN_IYpqci3l8Yb20f5uZ3Hyhj3ivm6_LlpmG2oCkgqK837-Iq6uKiWedrculzpnQmqKNaLjRyZSFpZuTo6aSh5vPx2KRn311gJnHqXjLlZWIZn6f1c6ztXTbgcqumpOLl83Gh9ifgJt_mrCkgNiWlZahl56vm6_LfJiHpICkgqKw0b6H2auKiWedrculzoyrh2KPn6_cvqmIlJLLfZmRfLuWs3Snn3qbrZrGuG_OlbqqnX6f1c6ztXTbhsuIYYeIs5a0dKaffXWAqr64msuYqp6lj4ivm6_LdM2EpIGqk4vKy8aIop-Am3-asKSA2I27gGGNZ97bwJOf2ZCUiaGbi7vOtJmqrn92nWaytYeags13Yn6e3c7IqHnenKdwpJtmytXHnJqmlHV_Z63Le5eDp4Opgp-_lbTLfM2EpIFinHu4zcl3t5yVeaKlvrR_m33Nd2GEec3dtaWW3IXbopqFd7DNyZ2nZouKf5qzyn_dfcypmphouM3KqYnegcummoaHr9iunrewi4qAob6kf5t9zZVmg66v2K_Om9CRuIiaiJ2wyLFht62TeW-ZvqmEyICVY52XjLDRyc2q2pyohaiRZqyXvoizopSeraext63bgbmpp4Ofv5W-pGvNhKSBoZxln9y-iK-wepylmrG0f9h90J6mmaLSlcC3bM6ak4mdgp7W2smH2al9dYClvqWMy5W6Z2OWjbjRvpOB2pKojJqIoZuWx3fYqXqfhGLHlIjblrZ7Z36er9ivzp_ekJOJnZt3r5uumqKffXWAmb2UiNWY0Hhhj4ivm6_LeM2EpIGkm2bK1cecmqqTZIChxqiLzoPMe6mCeaeXtKWElYXbjGWGh6_Yrp3ZrItkoqa8k4zZjbqepH6f1c7LzpvVkJSJnZxnuKbIYs2rioVrm8aTZs6Apnyalo2wlceohcydtIBngqGblsd32KqToIykxqRn2n3MqZqPZ7zawKiJ3YHLppqCnd3Ov2O3pot5i5qzyn_dfcypmo5nn9nJqHnZmbiNq4Ke1seunNlnf3mLqr23rpaCqoiajovelrTbfJSHpIGVhXewzb5ir6KUZYSXyKhv1466ZpqEnrCzuKZ5l4y2iXOdZJeqtojFhISckGHHkabOhpWZZIhnwNO5z4XKj8yvgYaLl8-zm6etk6CimsalgNWY3YB_j4m41Lq1fa2dtYWhmmbK3bh2rrB_rHyhxZR3l4qqZquajMCXyc6ryp3OcIKNobOXupmSrH9lpp7Ika7Yg7d8koevuM25y32oms-Jio1n0tyyYNGtf3mupMW2pd-Hqqp7loyX2LS3l9CbqG9jjIuWmb1gzah-nniAxaaquYXPnpKYit7YtbaXlZq5iXWdi7_fvoezl5SdqanFtaKahZaikoKM0tm0qHnVmpOamoV3sM_HY6utkomHmrPLeJ6ApnyrmGefy8e4hM2HyoBkiIjJzrFzq2eUZIyqxbiHzoPMe2ODn7fOsqR9lZuTjaqboazZv4OqbHqgpqDFzW-VjruAYYZ9tNXIznjZkZNwpYKd3c6-Y7eviWRnnca4gNGXz2thmo2o0a_LotuEpIGkm2bK1cecmqCTZYCoxbiHzoPNc6R-orSWyc1szpqUgaiai7fOtJqiqXqfhKfHz3jVjqZ7Z36fp86ypH2UmbhonYKe1d2zdMhrf4aLqLLLoZaApnydmn2o1cnOiM2Hy3xihni73bJ0qmiAhoukrc-AzZbQhKeXiK-br86BxZy5kaCeiM6btmHFaYB5rn62lKHOgKZ8q5aMytqvy6LNhqV8qIiIr5m-nbqufnmDY7LOg92B0Iidgnyv3LSlfN6Fzomchoirlr6Htp-Xg3Nu"//用户token
    var token:NSString = "MDAwMDAwMDAwMJ6tsN_IYpqci3l8Yb20f5uZ3Hyhj3ivm6_LiNuGpZqahXewlshit6-Tn3ylvrR_m33RgGKYfLzevpOX3JqlfKiKfLTVx52mq4pkb6Wtyq3Ojbt0qI1n2tHLtHyagct4moV3sNHHh6emk3V_Z63PhJaXqoiqjWfK3cileNuJqYWhm6Gr2r5imqp6m62axqhv05W6ZpqEnq_cr8qqzZvOjZmbe5vNx4e2n4CbgJTItaGZgpWIlJmJvNG1pY3HnLWiY4h4wMjJhLuhf3mAlMi1ns6Op4hhjmioyMq1jN6RtY2UnYi737-Erp99dYClxpOA1Zaqh5qEnq_ds9uM3IW1hKqHns3espmqqXqggJ2-km-VlbpjnX6f1c6ztYSYhaWEZoZ4u5iyqaqpeqCAnb6Sb9WXpntnfp-rl7WlhNyFy5Crhp6vzrFzq6mKioRhvJOu246VnqaNaLjVyLiIzYfKgKiCnd3Ox3ensJV4b6TGk5rVls9roZh4r5uvy3TNhKSBYpx7uM3Jd7eclXmipb60f5t9zXdhhHmn37W1dJWG24SahXewzcmdp2aLin-as85rlpaqqaR-o7SVv7mFlZvagGeCnqvOsXOrZ5RkjKrFuIfOg8x7YoJ5t5ivyqrNmaiNmZN3r5vHnrepk3WtmsW5hMuXqnirmK6vm6_LeM2EpIGhm6LA1cl3t5yKZG-cvrR_m33Me6R-opfQtLds1JrPkaGde7zLvmKaoYuFf2etzoeVgbqDZY5nt5q1qIzbhaiAqoZ4uNG0hMitfnahZrOojM-OzZlhgp_K0a_Kqs2RlI2rnXuf2a6a0J96m62axbmEy46qiKR-n9XOs6R814HOfZude9KXvoizonqcpZqxtH_YfdCqp49n0tq-k2Takc6jpJOHr5uumqawf5x7qbHbf5eDp3uqfp7dzsiobNKZuGyXk4uXzcaH2J-Am4CryLl40ZfPa5-YjN3ds6Z13pm4bJmFobTbx4OqqXqfgKHHz4jUjqp4Zn6f1trKuKvXhKSBn5OLm9C_iKqfgJ9rYsaordh90JZiloy40a_Los2FtICkgqG028eIo56Tn6Kdx9p_m4vcfJSZibjRs855x5y1iZ2SoazIyYTEr392nZq8tK3OjbqAm4-NtN--lIXamZONpoKe1c65hbN4lWJndrW5mrOGqHhkiYrVl8qpga-RzJugh2Ta0r9g0WaJY6KqtpOu1IK6mWaaoNrZv7ij2JK4kKucZpfbx5rIqoKgoWO9uHzUltCIY4Kg2ZfAqaPNiZGnkotmvMbKeK5ngHZ3YbLLmtGCu3h3l6Osy8CpfJibuX1nkKLRlsZ20K-KZG-SyMxrmYKqh6qXn7ipv86XsJzMo2KQe9a4x3TIa5SfamLFtmbfjqd8Z5h8m77AuGTNmamFpZCKytTJdZZohHmZY8e5eNGXuIB7l2e0zbSonpiGzIlnkHu41MZ1yauGn2equqiA2ZeqY3iCn8C0ybR814HOhaecoqjVv3OqbH56ZqStz4TflpRroY94r5uvy4jbhqWamoV3sJbIYrevkomHmrPKf5iCt3Oofp7dzsq5gdCbzmyZm4u7zrSZq7CVinidx81v05e6qamCeqjfx7hozITOhaebh6_Yrp2vZ5Seb6W-uGfOjrt8l5l90tzAtHyahaSumpt7n9PGh5acimRvqseootB9zaGogXiwz8q5fcqRk3CqnHvS0K6a0K19dYCbxpSA3JW6g5qEnq_er8qqzZyoo6WTh6-bsoSyaoCGoWSzpaGVgaapmo-NztzHuX3QgcumqYeIp5azhK6tgIaHqLCkgN6Numecl2eWzrXKfa2NtZudm6HAvrSEzZCFeJ55vpOIvn3MqZqYZ9LTyMp8moHOhZySobeYs6q2sIqckJmyuIeVgt2em495s5m0pZaVh7WNnJN7s5q-h65peqBmbg"//用户token
    
//    func getToken(uerToken:NSString) {
//        UserRequest.getToken(params: ["appToken":sharePublicDataSingle.token], hadToast: true, fail: { (error) in
//            print(error)
//        }) { (dis) in
//            print(dis)
//            self.publicData.userid = dis["userid"] as! String
//            self.publicData.avater = dis["avater"] as! String
//            self.publicData.corpid = dis["corpid"] is NSNumber ? (dis["corpid"] as! NSNumber).stringValue : dis["corpid"] as! String
//            self.publicData.realname = dis["realname"] as! String
//            self.publicData.access_token = dis["access_token"] as! String
//            self.publicData.im_token = dis["im_token"] as! String
//        }
//    }
}
