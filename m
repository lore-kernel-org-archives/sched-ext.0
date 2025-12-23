Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ACD17A305
	for <sched-ext@lists.linux.dev>; Tue, 23 Dec 2025 00:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766451055; cv=fail; b=hNY9LXMILDo9tI0K5I72oPL39aNjiZ67LNAGlsQG4HBr6U6xvB8PMdr4BFpvqABerxUb2B5Et8FzM3WqZ0e/F5VJsG44OSiGV70aPPZAQopsbXMw/AUnFYTi7cjqYLGXrVz/FM+ZltjdWztU0UeWv2ADDBz1xwj38gVNSMLYQ08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766451055; c=relaxed/simple;
	bh=pbFTUcHN+l/P35bS4pWw0K1Nnv8C5NUudsmHzjmyf94=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z8OhDfGJpb6svQUp9c72ZMDG+lkZPwMyG/Y4Cm24uhuNz/XN6rNWdXq9OHXa2nUoJjj7Bcl+sqfzPgRZW5+McUyYMHRywvz2IzQr8QCA/wWRJ3VuP5FgHwX5RnPp4QjVtwt2AdG3tKz2Ks+xXl4FUpM4YJEgX2Y9LAhk1E9QMro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DA1vQHPt; arc=fail smtp.client-ip=52.101.48.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DA1vQHPt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/A3yjH7wY4O8KHFmfCNRtOQkD2G+Lq+xbGrT99/XJSErCu7TCRw5ZunZcqw1ZHs6C3db+FSFUY4JQA87/+KydyuUqtKyn5m4I5EzEn1YiIET76thrdymERUUCB5c43f6duTSJQl1lRQLnkC6HvXHko0oX88DZrvBJ9k70yiyIGyqO9i4B4MN1nGFhksOejnxdKXosJazynjC7bGvsJztA/cP996u4TjUYFqM/OHpT0rFu20cMHXKKalgKOgu3uNxn7LaXz0ZHx1CDiTJ8D+B9nle3YNMymKPOW7k8oyvKqMhGw0WG5AWry1OvFfzDzSkJcMmJQSCEv62VvpNeB/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U6k+LfdH9b2PdQzExRvP6RVzpHIVZXfNbzFGWYGuVs=;
 b=I9n5Xp1DumYZziUzyUrPz2Rq4TVsgMo+EDh9P3CCThLcVh7FKGmM7fEHRbgU+R7SpRzT9ZXeeYJ/hdCkC3kBSzLHdJ2J8PikXZ9axOoy86oBK553EH3rwxtrqIYjuvOg6Z9bOF5WTkRdlF65M7G3qhEkzbNbSAFfnd6Tx3zhkMLk+YQ+4OmN3dPfZZ0hyKKPU8ZWsWKMuYcdX+F1rgYYkbRLlQIJIxARVOKfGBGd2I9Xo2e7IkcO/0Hgp9/pyTV7qM1+M/N48XukWLoh0x4DcQt9SuGGrazCyYe5ys4UiiOxfLlO8WMtT2ygNdMpnaSY+ai1qv7SDCt73ItW0Vyf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U6k+LfdH9b2PdQzExRvP6RVzpHIVZXfNbzFGWYGuVs=;
 b=DA1vQHPt+4o39CiX2DpKMMAK1qXomyEoS1kxzuqx5nsxo5Em293MyyyijUGd6Ax+TYZHSeOrFCfwFpwM09bTXtN/TjIzpxRjiyytKvrHrlWfUTXkTYMWaQesQ2bHR16n12mRv+ogYDr9DOrR0xCNzuiLmYl9Oad81/32bqVhcAbZEjZLw9V9pVPqGFK9kSnWES+1j7GWcWkagD0g0mKV4Y4y6r58KDfJIMUrASUobAazygv62FIfgDaWuoH7Ft38rC7rlGOJ4eAVeCDjXTLGcoYWQRpPe7vvXJyStZF0Q41edZmvJt4Ml03dUXDh3CDlmlYELqyhEafdZa8ufTAS3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 00:50:50 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 00:50:49 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev
Subject: [RFT] sched_ext: Skip stack trace capture in NMI context
Date: Mon, 22 Dec 2025 19:50:37 -0500
Message-Id: <20251223005038.62406-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:208:530::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: d71c6ac1-c47f-46a6-9d2e-08de41bd50d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJpdE0gflQ2P/jHvjl5xjY8OiZxcwWVpBlnmYPydXthefNeP4c0XPn8iTbal?=
 =?us-ascii?Q?vH0oEBqte+9sGSYRyV2fxzPedVdUJ6zXoI9Ys6irElSbJIsbExeqF/bXbyJv?=
 =?us-ascii?Q?WW4zgMLXe90jLZ9WbFZvKxAVu/nMk0K5oJ3ZhdSz4qg0Gkd5Aod+Qwe/qUQG?=
 =?us-ascii?Q?ByT/6GLfazHAsl4KwMEeg8r83P842VkoQJQLGSps3nK648QKbyQp8Quwkvq/?=
 =?us-ascii?Q?X2bqCeoNc8VCJweW1BLlUhoQRRC1G6xtJ+jmCFxCrlwt/KVrxlFpwLzPD42U?=
 =?us-ascii?Q?DSWtkrZKry83m3SgIo9b3FLI5EliwlnVTG10MLzq7k0//+/2ZujdrP/bKw03?=
 =?us-ascii?Q?5U265AGvH4wgaguVjwy8vNAhaBHjcgBbz5e0WBZdLFMxGVl3raqjZu2UdnIq?=
 =?us-ascii?Q?uXZeY7mAgAi4KY9CX0g0eGUq6lds60nR4wkAZbsVbFLVn0NLiWUn1jWlIC4V?=
 =?us-ascii?Q?dtkDPSXwB1/KHmlIPXb1zNVZBccBcjOly/gYsoEXN2yM7MsWeRijf5yr6gUb?=
 =?us-ascii?Q?dgM8l1HLPrfoBau4WQUE24fWLULXPJGpGLqoly4bq1M6PFrPT7OkYDOTd5ac?=
 =?us-ascii?Q?Djz9kMF8NJxIoLk1pPQ7Z0LnCcK5aK6hxk8AhjiWhhwEpk35cPzExZ6g40U8?=
 =?us-ascii?Q?4O5nXrS4qX1fqLqD//vncmHZRO5oImZS0oVsRe0jTVO1T3A1KptYbF4bOiq/?=
 =?us-ascii?Q?J6WlWVC7nNwh53mcGuE1Zt/XkVBWi4cXmdLWuKYl6oCBTiRrDiqgZCnTw8q4?=
 =?us-ascii?Q?maaANvX8bdoZT0mXKtJFDcKGJJfI0IlD/MaMyU758a2CQPyzN9n0oNZ75o2G?=
 =?us-ascii?Q?5gx6+XHZNtKpjzXYPIv+DUGi7FvOoHgK2QXifDXFzDsDXifRoli9HnIU2mpL?=
 =?us-ascii?Q?ZLLBxbRTD7HH/qr2q1NMZv9PDA5hzBV050YKlfZAY9UmcEgH2IBtaoKaUTpz?=
 =?us-ascii?Q?hfNRG9Fl0lboVLj+ipAYzL8jHVr1SHUeRxLMpoOP1Qc8ppl1ccxurOIQDlv8?=
 =?us-ascii?Q?o0Clfkyc6eAIVW4YhYjLvPVtFKP/EHSUl3lc4sW2uzHcry6C/+SL6l7c2Tun?=
 =?us-ascii?Q?TJCNww3ZBFIBU3RTISP5AKNXypQpZfzU2bNc/q2LBb7hMSDZSCdtM+khXaB6?=
 =?us-ascii?Q?Ous96ccBgYtvCEuXEWMRYH2kPfPbFM9vCSNMPjfkK6rl4CWxnnQO0xQ9p3Ku?=
 =?us-ascii?Q?9G9CgpewgKQVhQxV1OFQSI8fv97yIydgHBWnBmcLil/4Q3544IoELCdk0oRk?=
 =?us-ascii?Q?pZ1GrRQj84SjyglP/76741ZDTMLgck8FMnpWIsqJK/QMUbm8Z7/LNrB5VfYs?=
 =?us-ascii?Q?5IRAfuN3I4+r0fC+hzEQn7L0tRFC8wt3DYqJxLEr+mpQcRFCitF9dZYNhQBX?=
 =?us-ascii?Q?K9Jbg3tHm/AfxsfkMacx8dV28YSU/ZQgS5G61ZPDJllQ1tzpu99/ULDaxKLE?=
 =?us-ascii?Q?nJIvtbhBygrIIcKdJM2XuNN+e6jWYfLwmZXsf4yRt1JwA/ML4+2sveyswy2F?=
 =?us-ascii?Q?tAEAE2q6r29vxE8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oh/tAbarn/qF2Uf1cQsaKmIegLwRMpRM+oVJuohDPHy2F+zPqnkRTxa1iKqo?=
 =?us-ascii?Q?SOLbIOiJaW410zFIipEnMHD6K4fGdKIlodjwUtQ09jVycBMEc3A+11Rd3hGy?=
 =?us-ascii?Q?6Qx3kyziAhflNBa+0jsS24Cav/hARI0cn7Kpjm/n9JR6XWFQebYt2qj+xInz?=
 =?us-ascii?Q?NDE2ynqErQ9atx72a+GSxi6ItE+55eHt4B7Sm8Pf94jr0Ni4QOv9toZsFQQH?=
 =?us-ascii?Q?l69EMfWmZkJKytlQmeAYdQ0SmlA3UuTqjBoTaZAyCCqR/MJQrZ2O0G4nmcLr?=
 =?us-ascii?Q?LhQtSiHyJ32+BbJnvHnOnYmhfLQXB8zQZwrr+UldbtpEcMrZtEwHp1IjaCqg?=
 =?us-ascii?Q?HLmMvDsKteOZWhvzt1tCSS8tCE4HzjzVN59NsjDwV/ys1ktPt/1YVe7O5DbT?=
 =?us-ascii?Q?piXGrWWV4SHmsePxANWr/yVLUm5jxaeU+sMszXkF/GbLRNnf3viA/cfKEmgn?=
 =?us-ascii?Q?fFXi3N+baWrxpweUDUGpSVB5p3Z/Ci6fGh7SRkY3iF15BxEbr/psMaZQJWdQ?=
 =?us-ascii?Q?+49oiEeQDu7amPohjq48na5f7hr8CY56QHsS9kE7Gxb9YacZokTeifk+13dE?=
 =?us-ascii?Q?M9Sf+TasycJmW+2X3gOq54Gz8ujkdPSkGJZd1vBvMtbWL1XM3eOjztVU7rTG?=
 =?us-ascii?Q?e0MRnE9+maooqaKhjkBA4HHPwWjlN72DWVN6KwwUXxkbjowSiR+t7rxksgeR?=
 =?us-ascii?Q?OsEant9XaNSmHfQjxc5zeyvRWbAfxrZIRyZu58cX7GY8/P1oucNbBPP/y8kV?=
 =?us-ascii?Q?BM7LBuEHZpblcKTc44QmuYdU/5HHwXU5ikRk4YQWLTAUci4ycT5uD8QtKIja?=
 =?us-ascii?Q?ZLAYmxwhk9xKW1KWZhS2wDXsA7J3l/+cgDpxPX0nO8wSwA5J1vylu9sbS3E2?=
 =?us-ascii?Q?OnVTPSdz+1cGPFGs4OGSG1m1mXhv1r6LfbbWA4aiaa6YBNYiwjaWf+yJH8nx?=
 =?us-ascii?Q?wCrTfKMzEwyB2npYJqkjS4Xqcd18PE1v5IF/8Ymhj/81o44tFXlKua/uOuSr?=
 =?us-ascii?Q?/EA5F+JAtQCefVp9zYNyMbvaIEBtmPR6hKHgc37qBBy4JUdckowGVeSEZQW7?=
 =?us-ascii?Q?j3tXGcv92Sm4B4ca6ycjYPLYb33bvc514jLxvxcOl+CaEo1VM3/AWpYY6hRD?=
 =?us-ascii?Q?yamJeUaSAEOyW/zs31fxDKlYdTVXsnr92Kh/vE4ugJPU16ewL0+uzftz1FD/?=
 =?us-ascii?Q?F31RQ7Y6qE9Gz5aVJ/O+gNj4OoPv0ScTKN/1hMGU4xZGV9r4e9rqSY6PBqDA?=
 =?us-ascii?Q?FvZFKT3+jNzDM6R0VqTeUBsGkmil4NkamWfogml5T2UvxZRPDbMT5hWVV6/q?=
 =?us-ascii?Q?+TQOhOaJX7NrX8K7r5zreIM7oQf/nS5CtTUS4p+SIjJfR95G3as4rLyT7HiP?=
 =?us-ascii?Q?rB4WxOvDFmi44OQOrTZN61IpYPnr2GuMgW4g+8oY7LM0V7fs5JpI/XAKApp5?=
 =?us-ascii?Q?arG//DQNwMsQvtBWZLMXqmsACkQVXzIBpd06lYUgFH6qFJVzR5rTbRAypIKN?=
 =?us-ascii?Q?VUxD0xtNpCDJkUazHaYW4GoYUI6MI/qiR6ZssedMjzQfa/QE9kflcbmE8YyX?=
 =?us-ascii?Q?eXyqiGY43+E4sQxhJI5ZVNU69KOp8zuZg0dmD2o7vD6zipKVVm8U0wOOKABc?=
 =?us-ascii?Q?PZLXxbr7oPWnaZuYUVpLTNvvbslpbHKebxsgjjL8egcquj4MLplI8NhX5xVY?=
 =?us-ascii?Q?TEhP5oDKs+UTdaqFwj+HlJlFO8Uzjw4LP2RQiSfacy/YODC5NVdGJ7ruARDK?=
 =?us-ascii?Q?at2Ko5W8NQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71c6ac1-c47f-46a6-9d2e-08de41bd50d1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 00:50:49.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JoG7DDMwKv1/3YPq90c8gNuZugguRnyjo6lWpCi0VaUVtHPZ0xAMqKVjn2Xy8MiSI4ia6fjplRHbH2ns0z3pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443

stack_trace_save() is not guaranteed to be NMI-safe on all
architectures.

The hardlockup detector calls into sched_ext via the following call
chain when an NMI occurs:

  watchdog_overflow_callback()
    watchdog_hardlockup_check()
      scx_hardlockup()
        stack_trace_save()

Skip stack trace capture when in_nmi() returns true to prevent
potential deadlocks.

Fixes: 582f700e1bdc ("sched_ext: Hook up hardlockup detector")
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 05f5a49e9649..a96255ca3a08 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4678,7 +4678,8 @@ static bool scx_vexit(struct scx_sched *sch,
 
 	ei->exit_code = exit_code;
 #ifdef CONFIG_STACKTRACE
-	if (kind >= SCX_EXIT_ERROR)
+	/* Skip stack trace capture in NMI context as its unsafe. */
+	if (kind >= SCX_EXIT_ERROR && !in_nmi())
 		ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
 #endif
 	vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
-- 
2.34.1

