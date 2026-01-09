Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446F2E7648
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956886; cv=fail; b=BpiusjetVgC+8u/FYoFkEJ7bFClZWOL2lu5JypHVwznxAHEuECHk2j2XdZwrgPJGVhGUmM1PYLyuZyF4fVs4L5Z9rGnz0OXlfuLs+QGeJ4feXhqIoyxPMpngd/4MqMBlDbRBztAC5D2nf17PQTmMNhPpUzIXe4Ye2W7aXgy0j4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956886; c=relaxed/simple;
	bh=DZwvLibzMU4pmYvTybuwHfh71IgbPG+X8LzjINcSQLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EL0OzRyzvNoTV6Im5cl1tp2aQsZF8lokv84QpgW8/jk7gnybjWqReLdZA3G79S+e6rEFSeh2vCxGBKdS8JnnQ1mns0o76wnEQnv1aRkr4Qd8vzZbLX5co4BO9Pu5lHOqOHJLgb0t4b9tpDXHWYLLTizCox40LmaIg35/vzuYsNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UhIz5EQ2; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhIz5EQ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eS7IyX5Qa/bx/O1DvRDdi25X5vRMK9OREHdm4nALyRKznxb51tX0g/IbWDQnx4VO/T/w0ECUMW2ldQNGl+aTnBY3DycPBLW4LkjkYtswjSOTkZX0HKfVD4Q7Inf+B6HHWEzCagrTnGQ7+AhaQa7wgykDQJ8MqTV/d1AenD+VksGNLmbPrGqClyrP2vtZZE1YEBXWH9SkV8gMCpF7OgI5voks4AhjthRtfwOH6Hj1fHyHI5UhENk038xUtLrWbBXInvUGZhbLQVz20mL5ATY3g1reZok2mSgjizf3ZPKNv0JPjIVKdLucAhXA3MPP4JfJufUsUycJ6Vo5a9yLj8DaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLsPDPyI8zWIM6xA1OFj2GD6mbhuIbVI29fB8ImpL18=;
 b=b3YC2ZPgZ+BMlcNXYnybJ4MlMfAqg9Rw4w0G3gck2LnPLgQK2cf/g6JJdkR7A9EWL9sJtvRI/cAchSQ8WTTAW8B9hWUkLyJQArbFnXyUKcxtUyYVCn7jUuCVZe/XoH1nuu4cM3DZS45BWGDsPIvuCS/b7YNz77zJ+PEPFWAE0pE3pjbw/c+plQPHPpzHRGR+Sq8z0DpdMAQxUr1ADWBmZWsC2sNs1BJygDo9Y/vwA9kCDUvcHHVG4YeL+9yiOVngEd4Zuw7hxQFyTLDpp30wXxOT2eEWo6woq803BqBe0WUiDGTzo57dxzyN7JEFltRfMi6Y9n1HXoGy+UJUNdx6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLsPDPyI8zWIM6xA1OFj2GD6mbhuIbVI29fB8ImpL18=;
 b=UhIz5EQ2IDqllV/JvemAxXyKayAwLDUaFq+lDk4yS5guQa5gYko6rSgfdqz3hNIlmBCxUZdv0UaRJymszX77BBkjFMphXrDpqkJEZfkYp8sa112i0O1llNLdCRLeRIgjFtXaMFXdoXJ1lQXDziehtqTiyc2Mtr+v4XhAOZwuhT5EsXldj7GnJLCqgFYthTNJF5HkXPW9ywJ3hmYHt3SJTna3aSdrdI5Bu+8GwM/QG0UOW9TgY+cXJmTm2pBsWKLAcLfZiTdoYHvjGDYJg6oWCSV2PoNg1YwZeC6S0L7vqqvdTUR088v2yC0Ns3fQmIXYfI7Lls+MWCyMlkIsy5kwKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 11:07:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 11:07:58 +0000
Date: Fri, 9 Jan 2026 12:07:55 +0100
From: Andrea Righi <arighi@nvidia.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: changwoo@igalia.com, etsal@meta.com, guodongtai@kylinos.cn,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	tj@kernel.org, void@manifault.com
Subject: Re: [PATCH v2 1/1] sched_ext: Add error logging for dsq creation
 failures
Message-ID: <aWDhi0l1mHxjCg-H@gpd4>
References: <aWDUbVsJXth8KuqW@gpd4>
 <20260109103916.93454-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109103916.93454-1-dongtai.guo@linux.dev>
X-ClientProxiedBy: ZR0P278CA0104.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: baf3a9ce-027f-4e83-34da-08de4f6f5907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1pgoJiRSi07VrYjlSS+B2IByiJk0eYpdISKi0bntS6xfZTbpWhHIEZdPc1b?=
 =?us-ascii?Q?Gpp4FUYpgQbGqzEHAUBEDqX0Ilrgg909QT7bSiDXLiAnDK5+Fx6LcRpWT8Qb?=
 =?us-ascii?Q?6GQeaR1+UNM7hC2byyXRSBrkVR/UzdY5DnWxByqJMoKWhwJMzsOUI1tpSesG?=
 =?us-ascii?Q?oRTW3Kx2DM/2B+gZZ9RrkCpQsmJe/XlwFWsp8sN/S4XUp6bNuwplCQsQDFdv?=
 =?us-ascii?Q?yv1vFzD3j13pwqDAfJDR5AO8+PTEI8cl8fTcrRbZefmDPo5/oMX9O9b1F08u?=
 =?us-ascii?Q?H6alNTDQsAeC90PVn0RPn/28HXXiELeSa9FEjFHQXcu/1ZDrncfD99IfACcX?=
 =?us-ascii?Q?mugGDZeOOR7QXVvh1Sc45w8CMLkAzTtghBySXoERu4A9Tt1am3dM0ucH66o5?=
 =?us-ascii?Q?3oSYSpR5UT4RgLLxShUxwK5tKRl4Uz+xvHaXsW5nJfA7VyJCcmsv42N9+3eQ?=
 =?us-ascii?Q?hZlGjpTWadk3lteAYoxcNKMdg4bNy2A9hGmc4e1ZhfYcH5a2Y1vV1fBW3yU4?=
 =?us-ascii?Q?7VU20b4hsiCV+RPq9kSCStxZPe7aRgg3N6bOT/8te9zAu9+q5ioEszuC4gam?=
 =?us-ascii?Q?ktRNLHmm08s4oytySrgsYNKyl8rZkSUY7rXwGrjqIh02iIlxzwYvIXM43yX1?=
 =?us-ascii?Q?X4YW9Y/3YUDp2vNHmSpQlIxiB0uWmYWEAo7W4QEOZxFrGHIVbuOl6/5y38J+?=
 =?us-ascii?Q?S4jG6oXVojE9M/MvyWvzwrCjk0uiLWJ6Lhmu0zYBvTjnDfqnreGk2bDxaI7t?=
 =?us-ascii?Q?ka42vMxtlitHR0NNd45cInZeJrrAU05f6nEI78ZzIImY2Rk5MPogyoKlCh1z?=
 =?us-ascii?Q?sAHnO2goziKepDC7bPX8hpAU2Ykxb0DqNkBEyE/Qw20Z5CzEhErnEtObxXg1?=
 =?us-ascii?Q?rEz5maUXuRrbiWpL088NnbkZXMY4N7Qf3AE6Cbp9t6eMTIBcvnAE65GAWJil?=
 =?us-ascii?Q?dzYijesJCKez6MzcbzXqlfdRUYfle7KFlgLgf3Ukvn6pTmVY5mD4ngH3qF/b?=
 =?us-ascii?Q?oQZmLBsoEtwE0Y7C1zvSF32O/AvaT1UYqRYOqSo+1frq9sj4+acBBEWtYV4C?=
 =?us-ascii?Q?ZOeqKGjDuo4P4eo5kQeAIGSls1qyvaw/b+9oPn6z8D06Ond/YUA+ZtpX+nR6?=
 =?us-ascii?Q?UnObOyC8RFjk0rN6aqG7sHB4LvZF7bOIWsBQiq1a9TWhouQT+/8rgPHFhy+t?=
 =?us-ascii?Q?L3FZiwT8HmIWB6Igg4jOEoXF09R95xKv7vFw8GMJ5NzvPJRqwSk3bHk4R27+?=
 =?us-ascii?Q?3fcWxCRWlBaWy1qySvSU/6zzDqyT0CWirZux+MQr/B5f5IX47H2fdAjBR4ma?=
 =?us-ascii?Q?WytFjDo2+Z9WmjzKyQcU+UlMMe68zk6O4uNKRJoOi0r4i44/By6KcNhxsDzH?=
 =?us-ascii?Q?6PEKzNo67GYKYxb2zWg/SbusYDRwfWgL0j/rkIvNwmwlakF/cYWFWHkkIDKy?=
 =?us-ascii?Q?JFEA/5Tmz51WECpNaGLXP+8wURXjv82E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owulQkKyJnM8uO8pKiY/tdoYMGOLU/kGk/qXY5Du5InMKFEVEGs/aPzsE+ei?=
 =?us-ascii?Q?4yPTxC+PWBw6CLYcxnHOb1VMp0sL5o18W9TgtmbjfpjcUZ0ZJFwGYithiocw?=
 =?us-ascii?Q?/t+rAAlILf0M4EREYq1jY0BkaqmT5Sn9yVRPABduc+UnPMWDXawJWheQiKu/?=
 =?us-ascii?Q?qYuOG10P5g9pR+E7zXqv57qJs6v5d3Axf/ce9c1iW+zWOoEBFjiaPAHd/nmf?=
 =?us-ascii?Q?0M1TmJXebQ0AJll5TtlGbe/L4xw5cupdDfJu8BUimqmIXk/Zalvv0djrEpG5?=
 =?us-ascii?Q?BdmpeYZ1pUksmZo4DlkAq+3/mMyA/Ni/QebbWCkPSnvBgNnxWUVkU4Q7p2gQ?=
 =?us-ascii?Q?jOXFdbMaXy2WsOQnhx9Tm5fZnCxLrzBqSLPEga7VpWo4Owa/YJBTveVv02p4?=
 =?us-ascii?Q?ckVxxkbe0NwD3CA7dj2sQQ5fejcE2mlmte9NoY1UGrdw/xg76131RrDCAuSa?=
 =?us-ascii?Q?SBqAOnxLILiMJjFjSbpDinhU9ZO3Vga81dQMRH4DoQTliDsj5AdbQ8etQH6X?=
 =?us-ascii?Q?dzIj3nY/rDK6jZeoI8QgfQvpNgAgb44Y+KNge+7vStS19DYAFSD/LJxxPCGV?=
 =?us-ascii?Q?xDyXW337WBoWCKvH5cfD+hepotqKDnBMKLvOUlxFsHzSTag/AcKcRGTwys5m?=
 =?us-ascii?Q?hwvPtgpTOVX8Mp5xPeZ2DPtCR969q9Qe42eFsj28o4L54ShxQsZXDvWiHfPR?=
 =?us-ascii?Q?N8me13Pz6r1u8NXKzwf45Z+TI9viyLDyCn/zqK+cAqKdooqilKkbsKlWoSFx?=
 =?us-ascii?Q?N/+a3tcPeDspetXZ+qQER548vrRy2FLXu3aHxFKAtbQ9vJGod7SKXu/iVm+6?=
 =?us-ascii?Q?n4RommMFxAcMgaCcjDq9LoUg6rVCulUi2U5iiEuzHzgM/+p+G/TpvHYlyRMf?=
 =?us-ascii?Q?glgEhbLfVkrHKHQ0oDWUdYfinfEitEcMku3tU+XBwTJ9ncqE/Gg2A7ON0aeV?=
 =?us-ascii?Q?DI0Sdtm5RBWsYZbYlxxCxB5GrsAYWqhUH+o3ids7YoUCmohEMbQhTzG6eiLi?=
 =?us-ascii?Q?Q2vmhNSc0DYBn2dqAwASLBKhi0KQeFNn7RQApNCwSGt/SV4/j5oV+EkEJI+T?=
 =?us-ascii?Q?HP2MiOYvlFa3tqiMn2MU/JPkl6XdXinpBr03dll+Bgz3txKpF82y6o6DvfrT?=
 =?us-ascii?Q?R/OKRYPivHVoWHBnep3ZYMHkry+u7mmHbGG3ZRLrKP0uz0NflTE/1i+Q4SqT?=
 =?us-ascii?Q?9AY3KvRQJOtF0x6IZIlCJJ892pe5q6N2FL3ZM7TJpaj6vnDc1QnES+xoQqt2?=
 =?us-ascii?Q?1TMp+rlQuO9MtBs8buHzbMS9wy3BQY+bOmxKVQRq3KBlTvVnOdOLPQ2mimyE?=
 =?us-ascii?Q?woSiiDcmEMG87e/DYr1LGnmRHcMjQ4CD4cg60s+axSvEqLQgPmvnI0gkAsoh?=
 =?us-ascii?Q?Ab0eaMNUe+AUF9UwmwgQi/R9oCy8BTbIfCe7y411ya0qX/mx4d999zoBeHm9?=
 =?us-ascii?Q?6EIIhzjIEZTCaEsbh1hc4j00bQSKEUM281wvy4eomyP5OfCetvSCSwd5ptV0?=
 =?us-ascii?Q?EURZ0yxgzxq4mKqkBqbTI5EkH16fCyWjrL86vVDIU0QmiReTh7hWSwwsphoO?=
 =?us-ascii?Q?3YAAxUDyOOYlNwBEsdoC1rB9/6vqE8jxf/XDsEvBd7Mre2dw6/mWHugwwRqN?=
 =?us-ascii?Q?kwx2yrB9dozyIoGkAEPgirHIQkNSP5kmGJq9TAWwzi7R2iAhY/wxxFHcab53?=
 =?us-ascii?Q?NRCmneLxedp/s7z0cvEquVpqORC8KXsxM1+6Q1rbEtyAqxjF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf3a9ce-027f-4e83-34da-08de4f6f5907
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:07:58.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHJrk9fUkWg4Va7HIrgl6uTNWJvre0yEyV4fHuyumOUxg1QfA/4krGJKVFCWRO1Pvp4Q9AOMBiG0a1ygMgxKNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681

On Fri, Jan 09, 2026 at 06:39:16PM +0800, George Guo wrote:
> > Huh? No, we already get an error message both in dmesg and in stdout when
> > scx_bpf_create_dsq() fails, so I don't think this is required.
> > 
> > Are you sure you were not hitting other issues when your scheduler failed
> > to load silently?
> 
> 
> Hi Andrea,
> Here take an instance.
> You need add bpf_printk in BPF_STRUCT_OPS_SLEEPABLE(central_init), 
> even with dmesg when central_init fails, as central_init have multiply
> error return.

Ok, then maybe we can add a bit more information to the error message,
printing which DSQ failed to be created, for example:

 scx_bpf_error("failed to create DSQ %d (%d)", SHARED_DSQ, ret);

This would be more helpful I think.

Thanks,
-Andrea
