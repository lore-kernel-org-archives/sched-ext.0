Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A13B1035
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268460; cv=fail; b=dy33c6akzMdCNjMOGZeALPfwbVMsL8qLUE5r38y3N4oYUbLncBjBckk7tGQIyrvShKCXKoEEoEzZ+gADX3wtS1bBCYLB+PWMbQ36cVGG7PM/Kq1lil/uW0yeKo6mI6mMCEJ6lndbMZTdEr0EKcpjjCbg8BhOcaJnXgbehQkeg14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268460; c=relaxed/simple;
	bh=uQZw/WqxO2/05PdtsQgb+3yGnjxS2Pre757YDDLf31w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D44IIC6M5V5k44d+CxkOh33P2pA7V+dw/06YfhWCt3Uq+Mq0IwD9NazdRohuFemIcO5/UNpRIx4BO5o/smT8XJwZzGF6FaCRF1Kj9nCkL3NDB3BVLsWpnyJfpT0bQ+CUss15T/Fe8lIVs+M0mi6KxOmFR/gSl0xorxPPP0RyiHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DOssfVTH; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DOssfVTH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywLYelwzJrtZaE39kkBBbNPJ3nG7k4ryJOYnlytRGpPCCsZtjcD/iRfSfJlAedKR85pPnprAqm3U+ykSESDlRso6scU3mdgcgAJYBJGHGeHO1xQ5NZfImwOGrxFB5TV4WsLKVXvXgL9Xa78jv4ExmMJ/DvY4paPZdKAl/V/4UVtdY5jR9Q/dr9pLhWp1ed3IJdy7aAtRcMNi/WnxauCuBKK4UHCLiewCi80fTpVR8wN6UoAFZ76MLOfOi8puuZvkFLc88WXfMBtlr+apjn9zzwIcpe0CfcHG+6W4V+PL9V8ArobN+VVwOCzI+GVFrqXymBYhvpcE4akmTIl6ILIIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKkTdwgXdaJRcAgvaowbaQhd74w2AgMr+hlp0jw89yE=;
 b=cV61grujkBEiFtcJNQHabKoo1eSp8UA3misvIA9JpRffQe81/KQgAgikk9Omkaeze7LYbuyXn5OOd/4kNfPD4583vUgwxwAMxxsbUdp0A/GpjVKsSflThei62bKcl0WyDXQEJI9OPnBakBvVMn75GJg0cNSJmuhhRUNyWsF0IScekUfFNfzjOBPomPflM/BpATV0032YIw7XFJs6aACKoKYq+krQ1u/mxF8HKtiM62mzaqOTjNBpiTpoWhX/Zqahs5aqM+un7ifIyLj5OsjDE9s2584ZZL5h6DPdFaoM7PriknUcd5gVm0wJgpVoQMw9+2sYVetlXONfL6+dCzqdkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKkTdwgXdaJRcAgvaowbaQhd74w2AgMr+hlp0jw89yE=;
 b=DOssfVTHGnWkiILdi8Mi/gk1LeIVoNv7jzVu0ncDqusnG7asqFYzF2t2A1kDR1Nffa9BibclBmG3GOIaMl/tjNAHqY8GGh9NwLTwodUkvePpxZcnpKnu4YQQYKue0MattEvz2fA1YmR/ACR5/jlMARY+Msg9O9MbIIY1jWY8uy8eGGLYmRK4E5kWNiXOTzisOSdAUBD2AKhbbJo290YaDSK/ACiSSTjAftS02rh9FHeqj2xzw6T4PCYnHgMCGRPP8+gzs2C+PYPlEvF//qFpwwc1fAl1pyKuHDDEkIOKBeObpH8jj7UYIfrj+VpsxbLA7cNCQst6ZJh8k7xkfgl8tg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 20:20:56 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 20:20:56 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched_ext: Don't leave the kick_sync wait queued across a core-sched pick
Date: Sat, 17 Oct 2026 22:05:15 +0200
Message-ID: <20261017202025.3834954-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017202025.3834954-1-arighi@nvidia.com>
References: <20261017202025.3834954-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0186.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::7) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 704df23c-238e-472f-9c44-08df2c8c263c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|261009223327099003|261009223027099003|261009221727099003|261009220027099003|261009221227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	A1fpP8W5hewSVOlz0GwxW7REoYzT+h2iNACevJB6EmohtHpH1rgDBhZWOHX/3VCUdPt1L61zn7DbV47A0b1VwZw+xaOLFZdnAk7gYdXHgXnVWBehtkgG29oABq0jAbJEiez9UGHOtDYVZPjVLLgReb2LXCCgxOuF0P24AE4Y5GBeh1o+1lFVq1on7kMO1L89MFXWYxTqpqQaLpBH8IKqWzHe3odckqw9qr/ZVOiTuBCYmEG05ETtCc+wXJXFFvdFVbKweRhUJUf9Ux/+sFixrnKXZcLS5fKQQQrEKdggfcHI9AxMP/rDLyfQvKjvHP+vi42MmWuGej9TDPtLbEnNQyEZGExIoEK61JxNI7X8wuLPwvuz/ZOy5qHbNFzRdFOPeuM9XqeEsQq8CvuIDhvWI63QmEP59z2ZTHrb6/uKL9pl8Iyaye2hEgFBKrS+e9iOWt1liwtn9XQR7n1is0yBw3RAbtcsJ41s7qDpjT5YEtHv69CovAxv3oDz9Wl/xluCOoNGmpmVWr9U/PU3W9WCvAl4wCH8IOjkyeCxD6Iho+nJYWd7XsPeHHv9vR4xqtTMDbyo81x5yduVcVgCwxQJ6LO0Jae3OlvC+V2AAcR1rX32hX3FDV1O4RholG8mGvt3er/TkWHHdgq9QycRS56nefs3BpECJJgooU7CVTdByHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(261009223327099003)(261009223027099003)(261009221727099003)(261009220027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/fIKylddw13lhNC0BlbmwZMJf5uv+6+YHwS1eb54g89bxWyrAmRWRsPBIEG?=
 =?us-ascii?Q?Fz/0evcw6pQ4I//F03eikuOLeWJC+0ql7wKGjes5OxPTfXukEPD0VlcTqsXg?=
 =?us-ascii?Q?YnIUX5uLtvqqlHHcawIvXyESW+X0isLX9zinfeF41QAw6Mp5TEYx6aIOMsSB?=
 =?us-ascii?Q?pS40kRxHrH+4xpVqLQSvQP3epTDM5L8rwSjsKQtAelBBeozN2gNrIPx4bXTU?=
 =?us-ascii?Q?uOKFKbqGuMa7JihWMjCWTcAEVW8A2IX8y+s2i8aKNdUJh2p7H6AH0ZEnOefT?=
 =?us-ascii?Q?3dph8FxM4H++os+LCNLGuVqONh/SW9VicJT6jhDycC6ucb9u5IcSQ1ijhh99?=
 =?us-ascii?Q?hjLCsqcjY+2BdZY/o6Rts2Kj4QASitcPSXZsZcj4e8cmO+R0pT2wvSc6X+zb?=
 =?us-ascii?Q?BuVTP4cec2bqZlcVWOQ1WvlFUmoNxewsHdCCJyQo0qvp30dJboIYGl2YLA7y?=
 =?us-ascii?Q?yJ3U9BPfi73JGuEjqCKr6xIN0OgfvF4CfqvxMama5WB9oRk9/GLW8FHr+2Hx?=
 =?us-ascii?Q?/0yh3yUstAgy/O73QAmLGQRvwvbpqNr8JNI4r/z2VYF92A5Cqv9ozwfIrkaP?=
 =?us-ascii?Q?oNfuNdYgY3clFUU2o3vdzwJbbxx5MqT+UriSiOy7uo3uJGnq2RnLahfA6Y2V?=
 =?us-ascii?Q?q8bLWoiiQYvVh2az7ZaA6vR7yf+A8IR0TJfVODp5mbLFErjoyf72r1IT72Q8?=
 =?us-ascii?Q?KWqIwquGCGxqz7p0yRQMYMNNritD0mx9dJitCfGTx2BsQdH4w4WZ5wT6zC2E?=
 =?us-ascii?Q?QCNkuC2UHSlZn+bll8PCvBPC0UfQJaeMn0w2fmptjjfewc6/F+WomCyzjxMD?=
 =?us-ascii?Q?5VHZOR068/T9UhlTwj/q/uDkgf+pi0tnMxpxIIfV396LhrI2dDxvOy4oJ9sL?=
 =?us-ascii?Q?B3HV6r1JETU0F6dW2DOklQuLyOftOWSa6/nldKA45QKrrv+xZfJiyef/70L4?=
 =?us-ascii?Q?RFuBUHjpgGzxxaqo3veV6KlQ8h7K+EQ/d+jLWtgj38Rg7Z3Wgt3K9ITkFu6n?=
 =?us-ascii?Q?f0bKTKyojcn6AkUQmqgw6jX2nFj20uo09Sk+tJv4FvTvGpMgMPSZFT3DtzB6?=
 =?us-ascii?Q?SUtykRwfvhd9zXWiBDdz4jFSadnkXWKP+WwGw1+cVMdtsTRCfPy5Ar4GFibw?=
 =?us-ascii?Q?rS6bS/5e4kiF7FjN08mRrw7iYC86OoAKl1uTVcHSMgkktHE0e1qC9yKsLgk6?=
 =?us-ascii?Q?BANmX7TS9iTl6k47gy7F8MV3E34cJ7ubJ9f/7MGpcCC+VfWIX4pBfpGExwG8?=
 =?us-ascii?Q?N3wo0Q+yZt48dhcDYuw6hS4rukjmIGXHOuWip+0KrAsfX0awlgbU8DtQesU/?=
 =?us-ascii?Q?YjbnNVCSx5bmruLvqr2s8P8mTDJZyqPsAXGV3F9tnXW4mtOxqgwpkkUdeXXZ?=
 =?us-ascii?Q?xhugZBy6PKj+rMd1WFXo2G0uSXsQrCpuQkKXrKQzB+6lQwARPxptUqtBxXYe?=
 =?us-ascii?Q?WSEr57HTJ9DwUkuGomf8uDSB4xQu+aOyxh9puZk1ponHqTLJaV7VYUAu5E0s?=
 =?us-ascii?Q?alMXW8fHYc+H76kHB121s7oYzCtfu7F1/rv/uR3bCWAru0UlLDY1oXjuRaDU?=
 =?us-ascii?Q?mi2xltQpQbgUVnu8rLG4AVYjEvOppCFx8gQkAue+80Cu9GN9Ovq85bYny2Yl?=
 =?us-ascii?Q?5fYGeq1cBB4iExovpSCBhfE2aRoxpy0Ka6PB2oTm3pfgAWkXqezUq30LNulb?=
 =?us-ascii?Q?QYhLz5yK/yEC56Z7aqq7m2lRjgRAtSDb8gy0vV9NC8lqSfAi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704df23c-238e-472f-9c44-08df2c8c263c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 20:20:56.0165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OLb0wyhRGnmMh1SttnjM5gdhC/c5OwOZCNhfuTC6V9ckAXGlvEnbyf1DYfT9phCI1sd7Gyx5+zJ25KfEZMfuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

The SCX_KICK_WAIT wait is deferred to rq->scx.kick_sync_bal_cb, which a
final pick queues on the local rq. Under core scheduling, a pick that
returns a task isn't final: pick_next_task() goes on to pick the SMT
siblings, and their dispatch can release the shared rq lock with the
callback still queued. A CPU acquiring the rq lock in that window then
finds a pending balance callback and triggers the warning in
rq_pin_lock().

Unlike the deferred work, the kick_sync wait can't be moved to irq_work,
since it needs to wait with IRQs enabled. However, during a core-wide
selection the rq lock is only released by a dispatch, which already
restarts the selection through lock_drop_seq.

Fix this by taking the kick_sync callback off the local rq before each
dispatch of the selection. If the rq lock isn't released, queue it
again right away. Otherwise, set kick_sync_pending again, so that the
next final pick of this CPU queues it, as done for a non-core pick that
returns RETRY_TASK.

Fixes: 415cb193bb97 ("sched_ext: Fix SCX_KICK_WAIT deadlock by deferring wait to balance callback")
Cc: stable@vger.kernel.org # v7.0+
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 43 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0c5ed97c4d080..2348d5b72eb26 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3369,6 +3369,28 @@ static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
 }
 
 #ifdef CONFIG_SCHED_CORE
+/*
+ * Take @head off @rq's balance callbacks if it's queued. Returns whether it
+ * was queued.
+ */
+static bool dequeue_balance_callback(struct rq *rq, struct balance_callback *head)
+{
+	struct balance_callback **pprev;
+
+	lockdep_assert_rq_held(rq);
+
+	for (pprev = &rq->balance_callback; *pprev; pprev = &(*pprev)->next) {
+		if (*pprev != head)
+			continue;
+
+		*pprev = head->next;
+		head->next = NULL;
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Dispatch for a pick when core scheduling is enabled. The selection picks for
  * all SMT siblings and the rq_i->core_pick state it builds must stay atomic
@@ -3379,8 +3401,10 @@ static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
 static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *rf,
 					       struct task_struct *prev)
 {
+	struct rq *this_rq = this_rq();
 	enum scx_dsp_verdict verdict;
 	u32 seq = rq->scx.lock_drop_seq;
+	bool kick_sync_queued;
 
 	/* another dispatch is in flight on @rq, let that handle it */
 	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
@@ -3388,6 +3412,16 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
 
 	rq_unpin_lock(rq, rf);
 
+	/*
+	 * dispatch_one() can release the rq lock while the selection is in
+	 * progress (see below), so this CPU's kick_sync wait queued by an
+	 * earlier pick of the selection can't stay queued across it. Take it
+	 * off and queue it again if the rq lock isn't released. Otherwise, the
+	 * selection restarts, so leave it pending for the next final pick of
+	 * this CPU.
+	 */
+	kick_sync_queued = dequeue_balance_callback(this_rq, &this_rq->scx.kick_sync_bal_cb);
+
 	verdict = dispatch_one(rq, prev);
 
 	/*
@@ -3409,8 +3443,15 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
 	rq_repin_lock(rq, rf);
 
 	/* if dispatch_one() released the rq lock, restart the selection */
-	if (rq->scx.lock_drop_seq != seq)
+	if (rq->scx.lock_drop_seq != seq) {
+		if (kick_sync_queued)
+			this_rq->scx.kick_sync_pending = true;
 		return SCX_DSP_RETRY;
+	}
+
+	if (kick_sync_queued)
+		queue_balance_callback(this_rq, &this_rq->scx.kick_sync_bal_cb,
+				       kick_sync_wait_bal_cb);
 
 	return verdict;
 }
-- 
2.56.0

