Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D614F90
	for <sched-ext@lists.linux.dev>; Wed, 30 Jul 2025 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753854640; cv=fail; b=fSBBwLGwVGIhDUxCEfDWy/WN05U8LtgqQVYUQrD1Ma4S8Jqk8sUndMC7ON+ojB70uy23o86OKgqNyPUYCvhzYgrq43EIN7vy+9ylLzRNhvohtTxylbi3fA4uXrAx2MYErMc7/fK9VV15hNIGiQae5urSAsHxWpCKy5NFuvc22Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753854640; c=relaxed/simple;
	bh=mmC3qrWibLTFBENsX5rI8TLxZJt7pONy9W1AwJb0u2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cf4QECa5ikSXtuNJGGvmWwQXo28L3f52v0rEpJRg93PsFyPlhCuKwRQ1J0mv+o60pMV7xZTZjIz61SgngjJs5CU6huIPIMUAq+o6ey9a3Y5vKTHutUkAVC27Bz2MfkuLFqbwkM5ygy5YkPobwqJJ6q8gTK7g8trPjfqYQRopP50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g7AdZyPx; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g7AdZyPx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEDoNXyCbJ75/l1Qbft0c+hnu3BRQha8a19dPtFCj2XWVwBwG6ZADFFcAMkN4lUUZegd825gHucfOT9yFcfx/69QbZmZm8GsPY2AvSEJY7tDLI3mbl2Q+4N2ETIX/KgodJOWixwlPVzD4mjcKncLgU1UUyhzl4nUX+x8UoMCJRn2v1v/wKuHOJpedtFz2tJE9NrgBCfIgzwwxR5x+84DgYsd4D5yzc5n4i63TNJ/5OUS7a5s1KC9dNhDuru+73CpXnOmjcAZMyIM1VYqUNwG2rwAQMpW6+G65j69GY4mZRD+uLuBp4/1y4xLAqPhNRiMe8PZCx4tbtokyycX2MorVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpDUmXZV2EHlbe2NCbfuXYMe2kWTZILQ0GwFCsQ2caI=;
 b=axTefIFs1XfGmG9jyq+/ez0vRFji8LbO1soFC2STSwbe44nSpawyN8Unt57y6qXcRsAI4EtOP9+AqBYX0xOROslVLjbcvneQiR1dWeSCjfin0+TfVBV5H7yXvl5OpCG8W/bZ3CZ3XY/X9cjBZYM5IYRQGvK0RAx48bNJ8+SXFhzPcDbLhr5oZPU9LlVODW1D2rNiXl6nC1iohPMyuGO28YxU+v7xBkXGfp1vMmc+P1W17I87rWRVaVn4LyUUqWwPYJscTI81nljT52kP94atajyoOcNGuPWJWPHYi1ZuKM8nXYbczNfr2/mPdkrAZSJpvgv+5G5c7JJj1UTdzJw1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpDUmXZV2EHlbe2NCbfuXYMe2kWTZILQ0GwFCsQ2caI=;
 b=g7AdZyPx0N1l26pdHP3b+tvS63+MydsZKJHP+CNYZPsMNLdrR8dpUpAFG66YV8ntO8kzcLGmx1gLfzou1lfhby/4fVLAHaUYhZPWCp77/94ZYmgKtnmr7iPWuTl+MTqoFe1OIhBihZcjozZSrNaVcNxr8lxIpJlmlg0V+bu7RXCmZVhh9vOuhEDAvwUQLPubhnVIlGldsv8q65E+z5vd+KBJpTLNzyTvP1fLXlyQ3UZyFaM/iP+DAWz2Ybe5ZXm9r8mSLLDuy2q24IqUQ0zTdwaS2a08i2PgHTEHi0EruGcf7u2Q6MyTLeJ18xkADQeJxJ6gSiBikZ7NYOKRQ44V6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 05:50:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 05:50:31 +0000
Date: Wed, 30 Jul 2025 07:50:22 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Tejun Heo <tj@kernel.org>, void@manifault.com,
	sched-ext@lists.linux.dev,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
Message-ID: <aImynqM32NKYDoE6@gpd4>
References: <0b8111c6-1b14-41dc-a674-14a6361992b3@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8111c6-1b14-41dc-a674-14a6361992b3@arm.com>
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 2214c50c-fa2e-41d5-7d90-08ddcf2cfeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+SREMkcJRP0q8QXdRHthHMX1pwlSHJFELRourRWjc5crP/Z+rAsw0YmUm/QQ?=
 =?us-ascii?Q?UsoWUg5ZnFz8DeNCtORm/tKjS4kcU4VClnYqBtYuCK3GK+9icEBWq+fWPGU9?=
 =?us-ascii?Q?IWq4vejdCWNNDOkzMnC+23l7YZDnweidhcNIpZGol5lr90hoB7tRBlN7+j7p?=
 =?us-ascii?Q?CIK0yVQ7hkwl2oyJpL5HG9Yuw27l71s3dpcK8dsuBYZG3+bbCauvsViXqL+H?=
 =?us-ascii?Q?Z1A7k6SFCsA5DIFCFMt1St7GwgyXfRFXQm274FTRdCg9xlfP38ypFydP8IVM?=
 =?us-ascii?Q?YlV/+yxCHX5KUP21SFD8qNWYDn0vLMj40iqfZFSbQVNieF5atnzNYrt/3GN1?=
 =?us-ascii?Q?1HgTySLzi55Lmmjssfmb/XWJEP3DgcHYGP7hYpE8B4PGwAPpr4xh70lyKPdi?=
 =?us-ascii?Q?djJQeobrza0L0/wm6HcbgySyAcSdV9pq4dEPKXjEm4IwD9raNouMouF75+Q3?=
 =?us-ascii?Q?xF6XE5vnMBslzJLP4q7F1pjUl+l1ZQfNEkoCcA0cnIj2pKRemVSmDTByZE2M?=
 =?us-ascii?Q?SmLUtVUmjpHJZLn1r1jqw8eIxuKs12BW6WNf1tGqfmaiXaXOQltoLLIQOIGw?=
 =?us-ascii?Q?mIVz5uFmpYtV7RdqBYaSjZ16gkkoIFaBBMFQVdLtJTZvVWpU0ew2ErQ6mj03?=
 =?us-ascii?Q?HSYk2pNxRm3h1qSnUrGOD8m6va1h5kohBKzvHrZkV9m7kjH0EGz+wyC5ezN0?=
 =?us-ascii?Q?ARYV5pkzPlN+B1VvxzJD7kONqbIP8D8K9/yD37nFDvejetQLf//1zbn4B4QB?=
 =?us-ascii?Q?sjQSsX6p1qE7MLGxDSwbF1G2c7Z8YItV0CvP1f57cDmsMZfgXjutitCJ3nbm?=
 =?us-ascii?Q?PUxcuWAXdzMLZ7Imh24Y0hhr1GDQbO8dgE7TESVKkXQehtV+Xa/xu0rCPrcN?=
 =?us-ascii?Q?xCy/luTNJNhBM1wU1RAScsIdxDCKEl7IFAgtVUZfcbowEHWd0Gu3LXUm/XEu?=
 =?us-ascii?Q?2FpFVjHZ+uy2Cp10lez4C4k80Nwxtaio1xYidwgOfNgIrZqLqWBmKt0PjVjb?=
 =?us-ascii?Q?nJo+vosAA3lz+HF1l1Vp+C63Tft9fjPB8ONb1AEib69iQZaQ4HF7Tx7fHm1J?=
 =?us-ascii?Q?Y9SW+8+qf1qZ5SetoIKgtRs+RQtpQ7gqp1eLfmoSyD3avyxnHNp1+UHNxoEN?=
 =?us-ascii?Q?ZoDKHCFc9edpLEXFQoO4lcsnUF8xa2GQtx4yMdFGrwd7VmRlu2jdgK8HnL4M?=
 =?us-ascii?Q?Mt/+IG5WEd0ONwMsC+WRjObBvoq8lAh8LfOgbj8NoSaONvsrqOpoi24iMaXJ?=
 =?us-ascii?Q?dhMP1FqgcMiWcsfZHeROeLJU56KTzWoFtqPPLZ8OEsLC0Hoc2OWwMg33LOia?=
 =?us-ascii?Q?s+6ZmjT7DNyhdX7L0YQBPT0lnAqytNxFUtjB71DWZfKCP2z/ZBO40n7/QjLv?=
 =?us-ascii?Q?Tt2NS/AzsEHzh5yc0/NKxM8092cUevqNC2BO6vXlnHWYVaAV18T8bGXWMlYC?=
 =?us-ascii?Q?NT0x4A9mqjU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lzF6HQEWbcPlKjS8JMHKixSD08jM64s84Il06uabPPXormCZQZyXSGYQnJP9?=
 =?us-ascii?Q?V8FhZD9RBJPKVJhv2orVL8jplWAfnoIVY/u/Kk1jDcnkYpXHMu2zI5ALx+WG?=
 =?us-ascii?Q?wFvS7hS84xxM2aiYU4fu5UBWQt+P42BqvDNnhvU9u+vNHBEbmuGLoW7BNd/p?=
 =?us-ascii?Q?F1uUkRn1Jvz0CYEfJi99cbKEyFE+SOMy9lb4HfiI9L3F8rzgcp8DZP9QfmfK?=
 =?us-ascii?Q?As4JZz8Gf/gUAPIGzJ7bFxc2QJaOFfJmSi0aK0tE63A0eNl+mXfV0YY8Klgr?=
 =?us-ascii?Q?57t0H49YeMheZO/FXPZcxYKh9cjM0YfzB7t7EiW+tH2mCBJONuPfd5PzwtbV?=
 =?us-ascii?Q?y/qY0Szg1Dy3vSjRVyafy1TMbUE7gnjvxb9rF985aHkkRDusu7lJIlHwUbC1?=
 =?us-ascii?Q?e0uil5ImITTe0FlWMkRXULUdjgIRZnN1xwJ+2lrC6V2h4RCF4M8BMpCN8idp?=
 =?us-ascii?Q?UOLvRvuN2xPSfdwNp03LA3iOxfVc9gaVyVn4F1BucXM5HcGdN3stkkgCxhcr?=
 =?us-ascii?Q?c09yvMDL7V6I1wdenQc43LmOM9CXUgap+dwjBZzq6WPY/a4bOLqcf/Ysqqmm?=
 =?us-ascii?Q?iBcCYKl4mhSZzRxT7zqXI7k9zTmjkkh8/Z3L72nFO0RZla8Wk7x9wVrjtFTZ?=
 =?us-ascii?Q?xGimKwwKXvCDrnC44JWQMWNqAlraNmQSsFbRHFL+O5+ZwS27OxaOuzZmQKkw?=
 =?us-ascii?Q?dwWxhgowUX4C1Knrn0AZFCVkW06kuIK/iMY1Bxkkx/eNQwE0H/81bTMwbdr1?=
 =?us-ascii?Q?UshQvTMlosYJsdBPt99qt6ukFtQTHFRS5+AuKC367q6mVRVxL2/wsF9TIA9U?=
 =?us-ascii?Q?XH36736wByOgA31VhRZS+5DG/N+lhsKS8SRSWeAGWwccsyJIcrHchujT2RvT?=
 =?us-ascii?Q?0d2OW3r7IEAsC8oa+NHxGzpjWp+eVNuKUDAPOFf2aJwwueSvshXbHGRVPLGL?=
 =?us-ascii?Q?SYvqcP5nx2IOUHJ3AErrMQ39QQ9l6LtuywMkcaf2Wms4/pAfvMVrUscEb98x?=
 =?us-ascii?Q?k5lClYAC0RrJmsrcLRHd6YzAnvApA410yCc5KUFRpKh90QDZltesKsHsM3su?=
 =?us-ascii?Q?x3D+8Em1OcJ46tDJPcwgtM9MyDEuyXWBjVnimdiwgBHkVCwNRfUXcHU402fb?=
 =?us-ascii?Q?ZcF9WkcPtGmopjvirRR0IeD2nh6cu6uGWMuD6sATAIxzffPw8N0Dc5kP2Aap?=
 =?us-ascii?Q?ejmZF1MXkKl0HPPsjJEf2nVK3PRY+N2Ye+inKZja6KWYVEB6XuaIp1oVBHXQ?=
 =?us-ascii?Q?amKKXod1ZD7t2iztX5B+r9JBywYPTj8XBIQ9zPaK8MAJ0XVikl1HVW43iFjp?=
 =?us-ascii?Q?Nkk29pkHsqp0xqXPaxLeihJMYFJGC5vKkmzziXeM1sfeGMWLeGenFIw4D6Wi?=
 =?us-ascii?Q?CbYWi6SPdf4OrkYP8Oeg0lYgg5581YApjKsfxlS+9nkU/XmryrVmKlY0DYAf?=
 =?us-ascii?Q?Dm3wuedY6aHKEx5Ssm967AbhN8O/Nw7c17XWx5cxnMriSnm7VChBbZjur73P?=
 =?us-ascii?Q?P0oIJ/SjOKcwJERJgtjutn1109M3kc+J3dlyiGAbCLrJvOZEATGR/wVYpUBm?=
 =?us-ascii?Q?BkN05Co+X5HCqWhP+9fYc3EgBoEMCpDjNxxTeFOq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2214c50c-fa2e-41d5-7d90-08ddcf2cfeb3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 05:50:31.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCrhNDq+uk7addEm5pKO3VksW/zc4wL4yIuucCTkLYnJG1ypZxN3IPENUdkIui/PnyRL8Kwdqx1qugJAtnq/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

Hi Christian,

On Tue, Jul 29, 2025 at 05:03:36PM +0100, Christian Loehle wrote:
> scx_bpf_cpu_rq() obviously returns NULL on invalid cpu.
> Mark it as such.

Makes sense. Maybe add something like the following to the commit message
to better justify why we want the verifier to enforce the NULL check:

While scx_ops_error() is triggered on invalid CPUs, the BPF scheduler
doesn't exit immediately, so there's a window where scx_bpf_cpu_rq() may
return NULL and still be dereferenced.

With something like that:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Cc: stable@vger.kernel.org
> Fixes: 6203ef73fa5c ("sched/ext: Add BPF function to fetch rq")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 7dd5cbcb7a06..b734f55f3318 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7599,7 +7599,7 @@ BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
> -BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
> +BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_RET_NULL)
>  #ifdef CONFIG_CGROUP_SCHED
>  BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
>  #endif
> -- 
> 2.34.1
