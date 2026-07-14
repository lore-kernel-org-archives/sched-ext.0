Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6955369D7A
	for <sched-ext@lists.linux.dev>; Tue, 14 Jul 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011805; cv=fail; b=a0b/ShviDk60Pamsrb5eBHrXy8+LuRhn4W7eL5202cgXFiFiCcjH2TdltUkXBgpoaT1KheYSPDnl893qSKtvscrnEGiodsPuxbtSkYhiZaiKPpLT2FnW8lChQUubeGCIk0EySN9bE5PJBalFCjy85y6Pxom+Nac1AwfmM3CdDVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011805; c=relaxed/simple;
	bh=FVlZ3h5c13cUaWiNWELJmMsvyBygZxU4fbk7ey/0O1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aj3Xjh1benshnKXI2Fw2abkqxZxDga2ox1astNx5NAcanBXtXfYRiqtdFFY9Dv+Qd2tRlD8HEfy5sJqlKJYutALIJDLCu1LMJljoy3+5yOExrfO78hWNOfQKQsiD8ZIlpOXiy/ST1CBwDzZjcWYdsgB1+D3ZYVLbybmNYxV+dkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UvsIYhb6; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UvsIYhb6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAN/zY+Jaj+Mq0MET+6LKBS/eKgveTXucCITLLx5hHYMvJEGVt7/IRrXEHJ7On67Eb0ZxmVl2aS6WCVpSSv3qfhUOdGt2tqIWAP+jlMAKZnZlt+egB/o8C3/KUbrnik1kpRs0k+KnaqIbfdbzbBpkU4wSUkrcMMldAsn7ZMrK/XWMpTvivJymZpa/U+HUoQNjXBRgqyaVssSw3EZoLU9SEBUERWA9HF3FcPleTy4NlPxyxW/ZIqy0qwdnrZ/t7IvMMvH7O+L2yY156FHJdPM5S5BeyZASWzEYQ4noOORHTddWrvMIugKu1xmm3eNx+l1hRW8DtXSFGk3HCwUIgw3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0PO0qTpR6ex2rnHyRhVeCrlsEcmEuVwK9YJ7K/qbyQ=;
 b=dahMtAi8jbA2nO7UtPgGAA21u2ikhE3GB+cUeqDgbkLa6sUn/6x0UQHIdkr9QlBrxZTT8M823ga+G5vgBjch46Eem0LkGBv3B/Q7Xj/BHOOBKTK8kfl1VefMhQTRfMsbOroMoN+/D1m2SKrWa4NOHeJy2W8ORnjiuCTXwXBgCV2ghXztfbDIu8v6zshDn4Jrm5L9KSrBwf3X7TAhNVOJdHvouVyFqOwkBh3XxBNGN+UBgtaRebCj0i51lS6WW/OFgKrFEwF/Mfw/bwofy1N1pkBHwyjIjVwUCfmpJhJVy5AvypuLLvSIa5oLKuFPm5cwbBKN66Wr09y6Nvblw5Sb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0PO0qTpR6ex2rnHyRhVeCrlsEcmEuVwK9YJ7K/qbyQ=;
 b=UvsIYhb6R1XxZpvKGyl74MMDJPJqhb5B0HAIWnxILzyeGP3XfyIw9cgZQptn17JU7fkK6iv6zk1DTGfuIRN0WiEYkjY6Iq5F2EjD0g9F5Tt29r9BAs2xpbcdL/ooxRTK0we3ucWCP6BZO5n34G62y+Mm9St0AunqLMo92VCbyo4VKt9et8GObiXazb6zsKUMh3MDB6mA9kx8LtIhivd1+A21HGXk7SXm+LgIlwjkT8Gp0MfiMNiN9X4ThbSGYHPR6lU7e1VVQOsCEwAAOJIoqL7fgGT2QFtUs5OhtCioFQQtHr+zxTSYYBP19cijoz8gIOaRyfRO113J0kA5fxAlrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 06:49:57 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 06:49:57 +0000
Date: Tue, 14 Jul 2026 08:49:49 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 sched_ext/for-7.3 18/33] sched_ext: Add reject DSQ for
 cap-rejected dispatches
Message-ID: <alXcDVSLNErhxcHg@gpd4>
References: <20260709225041.1695495-1-tj@kernel.org>
 <20260709225041.1695495-19-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709225041.1695495-19-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ5PPF75EAF8F39:EE_
X-MS-Office365-Filtering-Correlation-Id: 959a5b9b-2858-4e61-d22d-08dee1741e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GzuqivWrcPsDosa1TQT5Y17fiS4XC169UUSxRNq9EFNwUNnwH4hFgmyC73ZTRa1Up9OfsrWVA/uHTYmy/OPKX7WK7oXUA8CVJ8gC2q4tHQ+9oBhd41c3BUmBcJUnhT77/UzE8kwKutAZRfhJwVblW02KL/uuntOClGz0xzj0HvTKbGsJ/lfoVEqkDuLM/0SMJWbmMtFZmXN9wUAud9poye9JIuhw2dHiyDkDC9vougqT1XFhVI4pP7y6AeUVd6APzAkwS/b46dfxrG5GnHzHUv1IVDrtY9PH6cczq5R6Un0uYyUlwicHkgAW9ss0XKy2QCbWZbnBemee2DU9dsuY8/uHccq14jFrlqgfJ1AqP3JIsKQ22c4pJYi9xxVi91961/KGNmo6jHjbI3iJtV9sTwAXJdwYgbGkAo9m/tCKz8/XlFLbMbcRcemdkqC5zkGa2ZAVQs0sMoes4MCfWBggJ+6qi/ZGTuC1KHFnTINmkk8kkjw7Z1EGb9Bptodi25lu4UI4U/3AoHjkPasCIRE2emmuzw+v0rsQbKpSogU8UxM+2K9kK+66QdZzJFK6FBXBpJknSdHL3r5fhWt62tivXuGeNk5VYlvn/Aq8x5qGIhH/y8W84jF+tMqoyXAhC6is208PZ9J6e5xS6zAbwKdLuNVTqD1Hzwqgmb6iWJkk5lw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?14uo/TLXkCq4v7fC1fAKcVWJtchyqF3tW9O2jkq7YA3uQoEhyPonS4BgUd5A?=
 =?us-ascii?Q?FnqdZ8blUFpzn7C/P09kIW0UzGUtmwIv5nHEha01UOm1ZzpYdvloJRBh5sNE?=
 =?us-ascii?Q?f96UyA0tWSyYEVAZLt+Aa+AXTzqnW1Nzm3egc3m1h/CkezsjWIxyvEhZ7D0o?=
 =?us-ascii?Q?5JPtdSLN9bW/ULseSi+CGYA9rOFaRibGRZYJ67tNE7isVEt+lF82XEULKS88?=
 =?us-ascii?Q?tpYp/1hNmAP5fsWsYuYVPTxtvRIvYGJhimUlfJOcH+23fXJV+Zhy+tirx5rY?=
 =?us-ascii?Q?aOLktTqQI3/RKKFek+BHaU/b/mMjEh1CEnIMyiJObUFzDX1Qz2awIxB/XCFK?=
 =?us-ascii?Q?sZeeQuRFoi1/p2n0uH+ALymS3XLIS3j4sdrZKBw09ngDi14b6vrMtZ8+l60R?=
 =?us-ascii?Q?l/lpuR82PFbGI0nI3HNQU5fkJ/ipyqmBzdAYW7TqwGMP3LDfqS6+0XgMOHPN?=
 =?us-ascii?Q?YFxaTcL0STxwKdm74ozFykLAr+N+9QTeFQBMwF5m+n+Q+GEfKafeQwjXv0kQ?=
 =?us-ascii?Q?kpznlWQF6+29Ybdy39PTUe6sQJ1QJxDyWSnvmotgXHPSxUD1EkwZmvIAHcaq?=
 =?us-ascii?Q?NoBAFEj4naTKtEyiH08PXF+WfwOH6UXzhDcyu+Go1U53CAhVFEce7kcLfKXN?=
 =?us-ascii?Q?2aSILxw3yRriFWuikRb1LJ3gync1LM6t1gIpWFj685vbTnafwIHpNWAnN7J4?=
 =?us-ascii?Q?Uql8faz3v/puE3JlCFrAknDWVpswIFOZKHzp//mrbW79o+fxM2IqcvY7r8sa?=
 =?us-ascii?Q?X4P1XRAgbqjNtJ1RvR50womztCroQ3xKcbhWblYgJW4xv/j9ipiC80AxexB3?=
 =?us-ascii?Q?nMHbaMNqGopgCfImjkZ7en718au9+LUAU3IhxvFxlGTq4tJ8ZgtmLqX69xuc?=
 =?us-ascii?Q?NUIpT489PgpEv8rvwNLyfkHLrhNNJyiETvtSTDDq85uyL0go8I4NwTRj4Yiz?=
 =?us-ascii?Q?cJojURQWkVZrrQk+6dhpPgw7dF7pYEGbvEeOsFC73bQSTdFnN8rUPo5J1g50?=
 =?us-ascii?Q?0EvKwr2fv/cVxaWZRJH3xnXK2HpE2XVDjy8IyKZXA7n7x35kmaWpHKCuwC/y?=
 =?us-ascii?Q?4tUM5+8P4svjV/tbXR9hEX1DOwuonznFBsQDvFEtFFovVgQyJe3+DLkjy/EI?=
 =?us-ascii?Q?2xvWi4OhndSpLKPZd77HaLLqBdy+696ZM0KXUN2HFTX4ZhypC8p9bACMKrR+?=
 =?us-ascii?Q?hwRGLPhvCH9qsg36Zjy3Lyx52LKNF9jA/Kyl/w7wuE538bBzWkjIij2tT6Qm?=
 =?us-ascii?Q?fqvwlnPBJAgbMpFRxHyHekWXroFBRlMAnLh8DZNS1k420AVwuHZgKlvDeLFx?=
 =?us-ascii?Q?bBkGCHe3HPF8e1BPN6tZM0eyCuDmaEGedXpOmWrBRW9LilxqXUONd1DJwn30?=
 =?us-ascii?Q?EAn9dnU+6+WktgHmUXaHMYIXK+rayTXM03J/bbYGg2EYX+xCBiKzUIBN+RD+?=
 =?us-ascii?Q?VUiYinHIlSLKC6/2AfZWCJ+84YKNCCGO8zJNijFNFtzgPTkzeL42lvqjBm2s?=
 =?us-ascii?Q?yZvDZdVFKhLH7V7HtQAscvAp9EZ0lyUcVRG/29xPe4jIoljvcAESpvAYmCoj?=
 =?us-ascii?Q?UUJiB+JeyVUZFV+1NxQUbNOzILSv7da1iO5RE8GIGTS6FPKyQR7Amao/p2ac?=
 =?us-ascii?Q?x0kRfYmOiwXSQKXciq4EXxgLRewu0DnokhTBPcMQrKdva/S8E8GY9gBmY98o?=
 =?us-ascii?Q?5a6oqmkldTBscajpsSlO2rvINNYkcbl7AM1VuSr8UiIfscAtQlf5B75O6NTy?=
 =?us-ascii?Q?vnn+lOYDgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959a5b9b-2858-4e61-d22d-08dee1741e25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:49:57.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2f+chGenyNeTh91P607ddyXhY3TcaSPnB/O6ufx4r4MVN+36zgKIzVoxHj0RUkL8iOI7WsR7BzwzJw2kE1Ozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39

Hi Tejun,

On Thu, Jul 09, 2026 at 12:50:26PM -1000, Tejun Heo wrote:
> When a sub-scheduler dispatches a task to a CPU it lacks the required
> capability on, the task must be rejected rather than allowed to run.
> 
> Add the machinery for that. Each rq gets a reject DSQ, a kernel-internal
> holding queue that is never run and that the BPF scheduler cannot reach. An
> insert that must be refused is diverted there instead of the local DSQ, and
> a deferred requeue then hands the parked tasks back to the BPF scheduler to
> re-decide. A cap revoke extends this to already-queued tasks. When the
> revoke reaches the cpu's effective caps, the cpu scans its local DSQ and
> reenqueues the tasks that no longer qualify.
> 
> A migration-disabled task must run on its cpu, so a capless one is admitted
> anyway and counted in the new SCX_EV_SUB_FORCED_ADMIT event.
> 
> This is preparation for the actual sub-sched cap enforcement. The divert is
> wired but inert here.
> 
> v2: Admit offline-rq and migration_pending inserts to local, not reject. (sashiko AI)
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

> @@ -1344,7 +1351,12 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
>  				 struct scx_dispatch_q *dsq, struct task_struct *p,
>  				 u64 enq_flags)
>  {
> -	bool is_rq_owned = dsq_is_rq_owned(dsq);
> +	bool is_rq_owned = false;
> +
> +	if (dsq->id == SCX_DSQ_LOCAL) {
> +		dsq = scx_local_or_reject_dsq(sch, rq, p, &enq_flags);
> +		is_rq_owned = true;
> +	}

With CONFIG_EXT_SUB_SCHED=y, this calls scx_local_or_reject_dsq() for every
local DSQ insertion even when there are no sub-schedulers attached. It shouldn't
be too bad, but the hot path still pays for the out-of-line call and the
CID/capability bookkeeping.

Maybe the same static key that I suggested for the ops.update_idle() case
(PATCH 28/33) can be used here as well and we could do something like:

    if (!static_branch_unlikely(&scx_has_sub_scheds))
        return &rq->scx.local_dsq;

Thanks,
-Andrea
