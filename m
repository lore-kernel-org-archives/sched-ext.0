Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3B3FFAA9
	for <sched-ext@lists.linux.dev>; Mon,  2 Mar 2026 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464705; cv=fail; b=I0TngZ9BPLixmeFvPx90++Y7tLCihOTIAJc7/Wy3HoHYi7IMAsqz/VAAjUXQ+9LQIPrRRNTHKq1L6SPykq/oK5fz1GUMh4vqK4qDK6xDyMn4OoN7X5Oa9gVjwcrMxZp+PBo07RKZIlkH7JoLTmZBVydyb405SNrUDMPml5LZ0uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464705; c=relaxed/simple;
	bh=mremFYFa83QptwGBt7/ruCQ8135xpQB+RkJVuuVxZSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GTtRDQG0LzmRLObPsru/mbD5xyc4jW3D/UWNX6wzvuO7zuA9UYZEl285NHQREr15MB9KLX9lC8CNaCtrJLrvT16E7cIEXSCMXDLgFa2TDoqARsemcqsMS7gpXZsThWAYfRW88gT3VhvwTu5Da7J+Ug9K9EZaaZYGqY0AgPHr60U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Um06qx2F; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Um06qx2F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdML7j3ZIf4kt0FbtKw1+AYthsf7cOyho5CnlHYb8Z+W0tWyZxjRGbWL8MEHdTsolAj06MpCiXOaqQ88GHuunWeXoRXwGbXIhtufb2hW2NlAn8Kw7LopREWCe7w3yuqx4etnun6E4f+Y9jXD/PNxk0lx89vv3q12ZOCH2FeDzYUm4M+x6h1rXRcgQQ+AqP28N7Xk6gnJcpI0Q0DtOjbjpULLBIDh8BRvEcO1VoEXTyfcHcpfPFZ2cVFqybB0xeEXG+hnxTwWRklxFE3X1W8+fCCoQg8xnbhjCAvFgLNmNi5EJFJPejTFASIaajMZE8vAtHqnHGz7jqtJeMlC0ydrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/HICPOkfnLsuWEzPJG11u3zF5lVDImTCJoQhRdIH6Y=;
 b=GXaBkn46GxEcVqA2YhafDXs5yqw/rNQoKyZaQzh1jPGuS0Y/qIkAPmLzj6OKZSzNOM+bTqqGSttvi/Z428RB5pg1QiYIju0TUrrkGDHHtNNvewrQ1sPTWdbKlsSWlC6DpP4lEyI15Tfi9/8RfChoSk5ytQPUhtelCepzXpbaMv+g60868sRpTm/i6vrAzF59qWK0CSMLp3y/HsfzsLEs+w1tY0NtB7ia2cu9ZIhGWDjjinVdhwBbilYDDQwxbs36bVCvu6Jpt6JutRN21lXaS/X5cLY37R+K3W/M8r/VF5GHkIJZsRjntlpcfCL+7LSaUm67FrNkFX3yI+e8MAVcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/HICPOkfnLsuWEzPJG11u3zF5lVDImTCJoQhRdIH6Y=;
 b=Um06qx2F8KgJrQRKP1XZMcA76JFgCYUCq1gPPmPQeTXC48MdoPit4+a9X7Qo4mkSAi5S821FD/zr3WYYUo2Fj8LOlv49Y7dRUpT8u3cbxvggy7FtMOHr8RPDvICz3x5cj/xMQaqyeJFQ4IqNCKZvPOvQS5UfslQjlVRWWUP/t4rTgmTH6KcIz1cw5RwqEC977A+qWecbYKs/LEa113onT3Ei607MlXzVmU4MiA/rebL6GtwR+Tjoc28mp8pTaTC6eZlOUVQHGzUFj0p1w62iq+QbCaN9+gI3p+RNgj4jsRRreS7q8FxqnAiiRLiq7cGkK1mLR7kTlEg8AQ+zg6UgWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 15:18:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 15:18:21 +0000
Date: Mon, 2 Mar 2026 16:18:15 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: changwoo@igalia.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sched-ext@lists.linux.dev,
	shuah@kernel.org, tj@kernel.org, void@manifault.com
Subject: Re: [PATCH] selftests/sched_ext: Fix the incorrect logic validation
Message-ID: <aaWqNx-DDtzzSqW6@gpd4>
References: <aaVAhdw3ZO5kHJ32@gpd4>
 <20260302084130.480694-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302084130.480694-1-yangfeng59949@163.com>
X-ClientProxiedBy: MI1P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b2b0df-7855-4528-82d4-08de786eef20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	bZD9QDYD475Ag66xBOQaiPtIzs0LT5M5bRvul/do4tXtzrv04Lo9yI2UQ7q/v78ADVwpuhE1OsqufMCMxC7icvErkovMpntVFs6iDVkbpZGgNuP8KgPPw4HhFaySo5/Q5HLMY9JQQ3IZlzMC6NU9rW78FFS7YwvKqqgsirPqKDeS4o0S1yeviwzQPo2dRV/gOLQnXe7fymPbhZk382wYsAqx+8n2gfNFllI75l4LE6rExhaVszxH/rxHg7RBCBulhfaYE4qdISNVCm0CKo0BFR56FC6Y3dE06nqjBMgCSjrQYwgewQpFDJgZ/0ox0peAftZqpOfDbnkOaeNjJB7KofhsLeuhTQJ6TvzagLZZXOKgwVs0Fab9+80CtFAiRIfFLxqCopXWHw1FrzWQyI60k7k0s6QNHK/qvI5C/uphafc8+mKkYi6De9DE0nLujqFcp7DjsqNfdosIiC9I8SfueuuVVV4Nq0f96ben9Zq9YKFJxmasnuLPKA1d14SvoeZr7FqXS9nrLsge10HPAcMufdn2/LlpWh/vVYNviaacJAQfU9hTJrjpCczlBFJmazoxD7tmTEytdlbKltZaArSrLlIJ0ByE51XBYAmJJj7BaFpV0P9NhdlRrwYOTuyLmR+udw3CrQd5EVVmvdJtWDQM53rzXfzXCpva8z9macEFHu72enN1GQGbIjLGTiAN73zl7LgFDorp1TsIOUdb+/iMCL039AmDXbiITXbxTFja/yk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2MYpY6AqHXtxh2ysipj/PhZDvRY/ME9ntzDFD/1/Wo+6ei8J4X0xWB1seIW7?=
 =?us-ascii?Q?wK7fJKCWkZ0LHQC0ZHMlwaoxaX3aGWHbhbFL/Q1LhK4HXIJa08rvMkqnAR08?=
 =?us-ascii?Q?bJpssXyjAbqIfGwj7FaTFsIxgUlbzgOnmTSqpZBs96eOegn0JUhD6GL7ECMb?=
 =?us-ascii?Q?7pR7OY6RjtQkQyZ8Cvb4HJJPoauYEhdzPi0aRkSTAOtXV69xdPcl7nG6jzJA?=
 =?us-ascii?Q?jW/NLHASPdhUGBMctHLgqsvB1UMXias6xzuO/FGR5Op80iqbzcgtrpvWTRkn?=
 =?us-ascii?Q?g/vg9DCdetCdpCpoiA90rktMLOKQo+JmVwuOtsugZHyz4PuylinIO7a+sSnj?=
 =?us-ascii?Q?avnprl9fjMd8KRxoUwNV5/29FDNCMm/u84zpJ6joqRV9DdZ3pAAKnNXXNNAE?=
 =?us-ascii?Q?awwwo2JLgkBFVoi+4kXfS+4qUenlzIFUSLgeFVVpoesKke55B0WhGBcs1NG4?=
 =?us-ascii?Q?bLPR2nJfoJDcJFBHBBqgW+ivNXVnUgU3chRRY/tZXL6fcp/vCKjs2+ZKQWC8?=
 =?us-ascii?Q?J/kgo2aRJKgVqpe4otbiPwm6vDM2C/P1+Gt6TM+wzSSzA0mjtjlTAqLb3pqE?=
 =?us-ascii?Q?SMUvWxCdnYJN0/6J/qF0qFDojzLjV9IX+fu4D7tF+jmg6GcdiBBssHMxl+Hr?=
 =?us-ascii?Q?FoDmF0fIxJ0YeyurbVg9AOOM8JlBi6zaSf8aiouVFZme1QN7RRN8Hjsudt3Y?=
 =?us-ascii?Q?HdNYZ1QClmXVHJNGA2PFJuVc3ESlsDB1iNnbuNkOsvFcnFQRNwTS0P2eTyZx?=
 =?us-ascii?Q?ULhJlKkwc4vvGJ4Grp09SgVaZEUvMniI8l3ZdsTa560Zxz4n2b1c3FjSR1Kr?=
 =?us-ascii?Q?Wy8xQ0e48WcUqmy79qSWilbw+c2/HFVaj7SnRtN/HL3Cgzv7Q3W0navk3km4?=
 =?us-ascii?Q?s8ezJju0TLFcRsBUe7uqyztwEybu96N9uYunYkoiYuyIVhd98fqEEaoigH04?=
 =?us-ascii?Q?vKembiaXR9MPtLRtCaKsyo1Bg0s2j1ZELKhKaTWBFT6TBolpSnQuphbr8/GI?=
 =?us-ascii?Q?kan6MKRNWy4SLL+MHFfW+edL3CLpKfG1ZDC4FAJQcr+VO36KRMb01rlDhPNE?=
 =?us-ascii?Q?FSGFvimAxfHvJ+bTjOElNcbxTzLEs4y8FZ0tshHHHDsav9aCErYAjFyzQxw4?=
 =?us-ascii?Q?6vW5BZCvrDPSyaD8h8UQZHBnzYkLXAUSEKynGHS9yudTM64ktDWSoXBGguJK?=
 =?us-ascii?Q?hG40FHDVWKlypZlpqnE26+64o7P0Qjlk3WmgXZByqItbi+rdmMAwiZ5dDHiO?=
 =?us-ascii?Q?eUNjMlwHJmZS6QFsJdv76/83b/26L4kjtuz8z4QbBTutwjZAcU3I4mpJleP3?=
 =?us-ascii?Q?h+TJX/wlBFClPNe+ljtVx7CZpycWbC5CXLE0w2WfxS2nI2m6W+vxA31UrMSM?=
 =?us-ascii?Q?rNYreOaciFZO46/Fly1fxoYh6hfZmVNDplKojyOUb1aP0/Wyh9bRO541xiRP?=
 =?us-ascii?Q?Ngn8HwPucrGCSe7BpVczPV68HnkENgKE2taOxhdmo+7bQGwhH1GiXNmga+5Y?=
 =?us-ascii?Q?JfydD+nMxObVt90gw6KDolS0jwR3USUxrn4OBPlks7XoRhLleh5fekBwBD2j?=
 =?us-ascii?Q?W1+75JaH2IbEUsAahHORmHlfT1wQqpSgJ2aVj4Yaa31rx4LcijGsRSy21Bn/?=
 =?us-ascii?Q?v/nCLEy/n/XJOy8tlwPMYPWLzj36CRkgio1u+oVI6WABGph7GtLW+9G1jTnR?=
 =?us-ascii?Q?/Ba62ny1mzzfAV1bxbqt2MjLMsWm8tTOM5ldjk/AQEqkIpDJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b2b0df-7855-4528-82d4-08de786eef20
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:18:20.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXJsiY482RmedsGa6jrX+Bsmm5yWbUyuyzBqulosOaBHoOADXety0HrQL9m7reRhmxLl4aEEMc+/EVZYrcCEiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130

Hi Feng,

On Mon, Mar 02, 2026 at 04:41:30PM +0800, Feng Yang wrote:
> On Mon, 2 Mar 2026 08:47:17 +0100, Andrea Righi wrote:
> > On Mon, Mar 02, 2026 at 02:48:51PM +0800, Feng Yang wrote:
> > > From: Feng Yang <yangfeng@kylinos.cn>
> > > 
> > > When __COMPAT_scx_bpf_pick_idle_cpu_node selects an idle CPU,
> > > it reports that the CPU should be marked as busy.
> > > 
> > > Fixes: 5ae5161820e5 ("selftests/sched_ext: Add NUMA-aware scheduler test")
> > > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > > ---
> > >  tools/testing/selftests/sched_ext/numa.bpf.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
> > > index a79d86ed54a1..98423628b05c 100644
> > > --- a/tools/testing/selftests/sched_ext/numa.bpf.c
> > > +++ b/tools/testing/selftests/sched_ext/numa.bpf.c
> > > @@ -44,12 +44,12 @@ s32 BPF_STRUCT_OPS(numa_select_cpu,
> > >  	 */
> > >  	cpu = __COMPAT_scx_bpf_pick_idle_cpu_node(p->cpus_ptr, node,
> > >  					__COMPAT_SCX_PICK_IDLE_IN_NODE);
> > > -	if (cpu < 0)
> > > +	if (cpu < 0) {
> > >  		cpu = __COMPAT_scx_bpf_pick_any_cpu_node(p->cpus_ptr, node,
> > >  						__COMPAT_SCX_PICK_IDLE_IN_NODE);
> > > -
> > > -	if (is_cpu_idle(cpu, node))
> > > -		scx_bpf_error("CPU %d should be marked as busy", cpu);
> > > +		if (is_cpu_idle(cpu, node))
> > > +			scx_bpf_error("CPU %d should be marked as busy", cpu);
> > > +	}
> > 
> > No, this is not correct. The CPU returned by scx_bpf_pick_idle_cpu_node()
> > should be marked as busy at this point (bit is set in the idle cpumask),
> > essentially it has been reserved/allocated by the caller.
> 
> Okay, I misunderstood.
> The CI test of this patch (https://patchwork.kernel.org/project/netdevbpf/list/?series=1058866&state=*) 
> resulted in the error "CPU 0 should be marked as busy"(https://github.com/kernel-patches/bpf/actions/runs/22548310848/job/65314767856),
> but I don't see the connection between them that would cause this error. Could you explain why this happens?

The is_cpu_idle() test is going to be always a bit flaky in some cases,
for what I see we may have two races:

1) if the first call to scx_bpf_pick_idle_cpu_node() returns a negative
   value, we fallback to "pick any CPU". Between selecting the CPU and
   checking if it's idle, the task running on the CPU may have released it,
   allowing the idle task to run and set the idle bit again.

2) Even if the first scx_bpf_pick_idle_cpu_node() returns a cpu >= 0, that
   CPU might still execute a short-lived task, which then releases it and
   sets the idle bit again.

Given this, I think the most reliable approach is to remove the
is_cpu_idle() check here to avoid flakiness and instead implement something
along the lines of the following. What do you think?

Thanks,
-Andrea

 tools/testing/selftests/sched_ext/numa.bpf.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
index a79d86ed54a1b..209dacdbd117e 100644
--- a/tools/testing/selftests/sched_ext/numa.bpf.c
+++ b/tools/testing/selftests/sched_ext/numa.bpf.c
@@ -19,18 +19,6 @@ UEI_DEFINE(uei);
 
 const volatile unsigned int __COMPAT_SCX_PICK_IDLE_IN_NODE;
 
-static bool is_cpu_idle(s32 cpu, int node)
-{
-	const struct cpumask *idle_cpumask;
-	bool idle;
-
-	idle_cpumask = __COMPAT_scx_bpf_get_idle_cpumask_node(node);
-	idle = bpf_cpumask_test_cpu(cpu, idle_cpumask);
-	scx_bpf_put_cpumask(idle_cpumask);
-
-	return idle;
-}
-
s32 BPF_STRUCT_OPS(numa_select_cpu,
 		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
@@ -44,12 +32,12 @@ s32 BPF_STRUCT_OPS(numa_select_cpu,
 	 */
 	cpu = __COMPAT_scx_bpf_pick_idle_cpu_node(p->cpus_ptr, node,
 					__COMPAT_SCX_PICK_IDLE_IN_NODE);
-	if (cpu < 0)
+	if (cpu < 0) {
 		cpu = __COMPAT_scx_bpf_pick_any_cpu_node(p->cpus_ptr, node,
 						__COMPAT_SCX_PICK_IDLE_IN_NODE);
-
-	if (is_cpu_idle(cpu, node))
-		scx_bpf_error("CPU %d should be marked as busy", cpu);
+		if (cpu < 0)
+			return prev_cpu;
+	}
 
 	if (__COMPAT_scx_bpf_cpu_node(cpu) != node)
 		scx_bpf_error("CPU %d should be in node %d", cpu, node);
