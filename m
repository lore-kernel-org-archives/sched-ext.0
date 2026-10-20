Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485917;
	b=Fa671e5PjeOSbXbQs5qIz187EMFdi60e/wyU+BtvmcrO/WDHWl2wSnSXwmKZhaWFO8hb
	 BRK5fUjBUfTNPfDKjgOoFCzU/LSufktcgROdZbfY5ksdlZ+jHgvFu3RJGdic8ZrzAM/bw
	 BOBHmsIOl53JYYtONYNwmivSgW4dB3zm8UitSxUTYmDSkpKpsyGgn7wBcqHPRY/rYNjq6
	 LRHMw1SD0bTCQqScjTd5wigq+nRgOEOMU/ZRnv9Bm1snedA/o0KDMBxcSG7+XL3h9EH0h
	 DQG+R0yXLBD/oQkSbaIxKoFhPgAHleWNg8ENiSy7vDnj+c/z0G5mi+Iaa9XHn0MeM8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485917;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pHxvttKDKxAFuOPIJb6HHy6WQKEi1sF0CENBJ4XtEvI=;
	b=ryexEpnMPFJgSDbAjtlCQ/CE8aJjj1oh8YivFAhDpMpGoTVTZClKj8+xkqT04KWmDrcW
	 z4ftOCj4JsC7E30+7lAGPfJQxav4WHd0deleCDwydHJE3mxrP2UC9MBV1QsUfLEapw8dn
	 xaGdPTtzt6pd6LOmyyR7+xeHY/7klXox5Jz0ZuEXIbBfUtAzndh5hBD0CuCrGfeV57hnn
	 ZJCF7C/fotFKd6uobTvTTeWwsI3ICdZCsnUKOeMpwqevF6T2ahfOPp4Ej8mJIuuLEw1ya
	 q6yqHYvEuC7rSThJuK2jSo3cT4y0hgFFOqJys1TmXu3msZwJxPsg47DKHEvpn5WAFCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bO15XgDb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.38
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAABB606A31D
	for <sched-ext@lists.linux.dev>; Tue, 20 Oct 2026 08:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAABB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bO15XgDb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gw9IXxu4tu092iIj0GBPuevB3QbPvcujxEQx+iMbnfOJ9fkH7szqW+ayxQrsURl82JW20aHbSrUDYEQnSDYyz1+9lksHj6i7VdBnSnyqy/9tJ0Zzu9w2iWNJ0GRk+O0L9SUhvWeCqnDKIeZM9PKiHn9s3SCFIydJsXyLRZElBR1a6aNZjgPi1pM0illbzHzcNZSbXveYDvt4M/5gJtL2GyReTjpKdGXqK1R7q9wpB1BZEbQPF7BL9gDe+9MH0F4eJjwGiJAHXxMbWvWAZMYyK0qLqvt1xC0lL7OxbI4J3KB3uJCsjBpS2IuUz/zX3/V8Pt2m38AFCuPwCgq9AWU2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHxvttKDKxAFuOPIJb6HHy6WQKEi1sF0CENBJ4XtEvI=;
 b=SOrhpHvAhAT3mJQtEbIZNwGJy+6jNVxLbmRr6U5WbRSiEfxws+rWXjVPwXTRSX7gakkrz0xk5aoEXq7AVErwOadWwmyPuVtmt+J/whd0h9tr9jgymNlSZzVd7KmOyB0+yH7cAAHwoMeXIo1sJ+C55C0UfbyhDFvX3qqRLRj4WURUhEb/iS5Ygf8W2Lz+Y4czIlmXPTPK1Czj7f9kSeWnfSGhJuh626GplotvxzIMBYdZyJZwbO0DX1Dh62aiN3AQW7PPgKcI64eL4Bl7oSDU9QZk65DBaPkyeTm4z1AOxriv4OtVWZsSYUczH8vBGUZWhGfPSLd7iPMkhJ11EZpj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHxvttKDKxAFuOPIJb6HHy6WQKEi1sF0CENBJ4XtEvI=;
 b=bO15XgDbFv020zJ0t8dH86e1+n/9puw4XOBz8tMhglVTjgpT6iMOo3oZjSCA4Hi7eUt7tv+UPvaY2MaYkPpqkQrTNqISBfNNy0vpIgcgeR4/0pne3qNy6HfCDUXehcD/0mXd9EyfSeJwy6Er3CxyeAa4hatRdgVb82A5JJUPqbsVAo4RmqaoYPCDPj9emYvP3c2pnOIEAP03SindwLNnSqh2YqYuehJbaz1QZL4jF5Q0UxF8s/A7DuaCFD6pNXbOvTOlYQQpRPdZaf0yYdSeXskcZRn2MIrnLEYphYWWNkG1hfrU5wDYvQicEtQSvPEatrJSXezu63zlwm9+jY9Dig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 20 Oct
 2026 08:45:14 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 08:45:14 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sched/core: Avoid requeueing a singleton balance callback
Date: Tue, 20 Oct 2026 10:43:19 +0200
Message-ID: <20261020084400.845842-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020084400.845842-1-arighi@nvidia.com>
References: <20261020084400.845842-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0162.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::13) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: b7edee2b-f41a-4fcb-f750-08df2e867558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BCEorDpnCWdF16GAvBlbCzNuMzGvPZiuCleL85wr1FNkEw0orBmUkios+u/nS9hiYSnVLOgyxQsskAgPms9bkX7scGhMry6YJSfQJ6fAYPn1jFsvDWEBD1XKgPfSGziekps4LGSqR4/cBPgsAmFTq45lo4BZ0OpIEyvS8NOe78H+RaYbY2DcfUq6uNlFpVK8KUgsX/VJgto3ssGRg8EZwTTbmlGAI7+ou78aO82vR99HNSRtT28SGgQYG6SMMcx+Axz97prRzc2qLBuyEZUwJOVqjHWu3PeIna57woRaAX8U0GkqzfwHbc11E0JxJoFqJRPtqOxgWyPza5imKYKjsohRGJKhnSzuMz/o86jR3Sv4Icpnw0JIW9nrJyQlE2XrMKqp6YWTc9dDPrdOFivT7muPSDUhJig+K8NCz3tp3jYxMPUmNahLdFB5lxDQrguqP+MRt941VQgrzMdkmRMhnmlBK3GvgwB+NKmsAp9zyZ2vXpOpqjt1/yJAF6NCwhchDQuq+jibxhOsOsBXKrNQi8T5PVmIFD7voXixysPnw1KSPs+ENqb2Q+st3AwoT6Et7VuaS2dTdXT6pLTP8nYlsw7v6jJI+Yf2DgVorVRi0Mw4j4tTplwOKu9DSBbWnNJwkm4kK/YDZ3QVrkzI1veyMBIBGqXhJ2TWhbOu/lVMw+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?73cWGA4W3GqXO5MuJD4e8mu5pFGMefwKYfjhqjlnMcazer0muHqZmVYgyEST?=
 =?us-ascii?Q?rhNWMGbEBT2nR73uayJutZfQQdF6ABVLoJfOi9V+8EO29zCu7zMLUAOUKxoC?=
 =?us-ascii?Q?glUZdT0eCsG6rSxO0IIqm3eQHEzN4lpaeanvLUFHLioYqgIbOHIcTP8H78GU?=
 =?us-ascii?Q?4EibW0RMDnwTm9+PRjMrmHDsV/5W+YSEoGzIsmrqoSNOfJ650yF5Of9zF30h?=
 =?us-ascii?Q?cPyD1Rrv9W4JQ7zBpO+4ChizxtyesSHxqQ56PtqGEiOQ7AVaZWXrCxoAWgGY?=
 =?us-ascii?Q?5iaHiKHiigEq726F0Cg67dtfIZ0Ve93DARMUKKHjm83xSugYPe/Av2+4v+k8?=
 =?us-ascii?Q?qt7JlySJO5hII2+kXAei3+sA5r7HjUxTgbKxne5SsujoHGbobNsoe6dvhZSv?=
 =?us-ascii?Q?gXw3V8uOX2ElVSGxbon7wCmyZCtcIIcJVYU27goZLX3K2/tS5ZnNZRzbNwHS?=
 =?us-ascii?Q?SBiyuo1iVME3um0gRSN82RDl3iSlcHjfy92Ab8kt4VowHry+2sZ3sFRgQhJ+?=
 =?us-ascii?Q?ytSAhVJ9fgHeQ2jCax/yN0ShDijU5wOxceJ/Yl99+9aHJJ4lg7SuVYwrSMbk?=
 =?us-ascii?Q?R9wceb7zStKHO5ddWidRYy/eXurhcTk+vFTMlc6E8alo3UGSXSXp+dUJQ5cA?=
 =?us-ascii?Q?U9sdm+jhMCeaAResbkXIs8qN7TJUKKAxwwBF9z9HaRnKa0xn5n0bbtWXyUAa?=
 =?us-ascii?Q?+ZxEjTfNfEsQtwJIm094bGGMGqZNjQcE/XJYvI9nXxuo6ZI4LhGM61zCxDYR?=
 =?us-ascii?Q?JVOaI2wlYmeRX55EP934zD01rCkz4SppkXKtdAewJYQ6CDYw8QFkxNV3t2ww?=
 =?us-ascii?Q?Vt7kJJIXNzd1R4DxUKMeyOcdi+lt8FG09FARCNskHp2nMUmvYj3j0VIzqjIx?=
 =?us-ascii?Q?vyUxZL241efT3YDwKyx6Gty6x1Km933PWSTuqAX4+wRxAB6+1TFb1AdJYHUw?=
 =?us-ascii?Q?h7bK6YXu6Nid2WVwPdlFLmVra2HvyBBMFHnIcb/ont1FJvHb3ikzCwMntFSR?=
 =?us-ascii?Q?9yMOj5J8GTmud7lmbjfMQlRRewL9rLplDVy2lqSt1Y6I2+7p9ZI15Y2fngW3?=
 =?us-ascii?Q?TbiJZOFfxYf39etHermHFGIteQBzvL1W+HyLUYvzt7v07Zjv5E+gqIqUgWpo?=
 =?us-ascii?Q?+J8ceg6fTyVaJidWS+h2dcPSVK815YIJ7hjleLGKB4rm9Gzpm7CXRymeQLT6?=
 =?us-ascii?Q?/nIuiFlMnKCIXdieQZOa+AkjY6vgRpOmrmwzlfys2pao7yA+vW3Vu41jrf90?=
 =?us-ascii?Q?YfJrpQ347FhUVA9sagXRjgD+EX7vwdgeD5h49Z6VU7fHsUiVI5WRM/mwwNDX?=
 =?us-ascii?Q?SMRrD2h+tUkubfI/VB0Jr8UR5jC2hOTEFP0/3QuNhefHV8YHr9hPhAof3qH0?=
 =?us-ascii?Q?/jBaBDAaWURiLe0PY9qQhnvupI8J6EumlmpjHJYzsDvMTSXODxlu84dQiFG3?=
 =?us-ascii?Q?Wi3YTSVIRyykfng+YUsO9WW/DgxC+gcnp3wif6qS4MEHgxpMJl/IER6hoER2?=
 =?us-ascii?Q?ZaxVJY2edLlYmc8kARoLAED4l7qv3VHAFU0XjsCxJYQVdm3RBnxJHBKuBSl2?=
 =?us-ascii?Q?2E1QMxwwntxLDEgApEWZy68gqp/NKtbYlHvBMbvfSvDp08fXOSE2afmVPILD?=
 =?us-ascii?Q?NdT6CVoygTGsfqEoXnzPiWaHhOnn94OJT5lHqmGL5sGC4adKgV9CwcDgjYFM?=
 =?us-ascii?Q?hFBBkugqAlqTXcK9Ogv5F6gLfCCjls8g5LcXUefGxfngmpiN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7edee2b-f41a-4fcb-f750-08df2e867558
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 08:45:14.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqHfJwa2Jyd+6wDvCxaS3hH6BJndwD6e/9aRf0scLv+D2ShNlZfYQ8UE9efp2eIQ1yfsXuNOcbz7fZLt1wjZdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220

With proxy execution, __schedule() can call set_next_task_scx() with
SNT_REPICK and then SNT_PICK for the same donor. Both calls queue the
kick_sync balance callback while kick_sync_pending remains set.

When the callback is the only list entry, its next pointer is NULL, so
the existing duplicate check misses it. Queueing it again links it to
itself and causes the wait to run twice.

Also check whether the callback is already the head of the list to
reject the second insertion.

Fixes: e2859566ffbc ("sched_ext: Queue the kick_sync wait from set_next_task_scx()")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/08cac02c604dd73ef96fc92eb29d692b@kernel.org
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/sched.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9e7993256c817..628765910934a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2175,7 +2175,8 @@ queue_balance_callback(struct rq *rq,
 	 * balance_push() is active, see the comment with
 	 * balance_push_callback.
 	 */
-	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
+	if (unlikely(head->next || rq->balance_callback == head ||
+		     rq->balance_callback == &balance_push_callback))
 		return;
 
 	head->func = func;
-- 
2.56.0

