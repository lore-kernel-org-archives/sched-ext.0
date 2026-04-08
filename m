Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F737AA98
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647733; cv=fail; b=EQgVMiKiKaJblzMXbFPV4Mh2ReHm6NWNqPeivcODUBXdG04CZkkObaPB5WmduDO75XduR+peORe7TaICIwksMkmM49K4e/i33j4oFDDscH1P/0EDtrnym11Z2aT8Q7xJ9CC7053yLaQBPo5Y888SqDDh1EgGFSgiwaCQA/q72ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647733; c=relaxed/simple;
	bh=+3IWPWZRGurI5BeOKW3P+Hgg2JoGiKrmGuQ5KQ4DZpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGjiQELNuwBhr4Vs1EUxAAar9NbNfCfGeiYE3RE4yBTFGGlgv5IwLppgB/BdFzt6k8kbPMQ2NANcBQojtddYGp+3cvcDRsgpCNTh9w6nfZJZxy6t1cp+yzka1pXgJZB0rgAoSW5MHtg3Ca9eO7lQoE9wvGw6HffKp7RvhFS2JTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S30hyixX; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S30hyixX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puRoxF1O+MNIZL81FI/j4AZZDkpgbqO0FQ36Aj7JtqpVPnXIZzrOM0QFZnYlM8Mz6AxTSP8TUJxRSJV8WEvnFjbZYIE/xmr2AicaDN5tN4iTDKGMCfjIYwHkjGY9Q6Rhetn/kZ940MEaCdBnBNEqZkWbrt8MMfU+g2YFtMr3rp3Ugn6SsMbMl8hHDtE0Jf8gSBO+DT6d8ZShF/0LHAcsCWA17DtEK/g0g+GBuqTNtz2XslOW+puyFWL2iVLrQAZvZl8XAEagDDiKqBz1wsA9URUCP9kB1R4i07VOWYr1v9vJXBwSELRfTnDyfZLiSCvgqZYBZ2sBWjfZh3QgM4L5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vnLMpMXFucZVjSIIXdBkfjEYJ88imfzgwfcaM9vrOs=;
 b=xbv0+uv1DShauhzNxi++gOnb9SiTgdhxXHHovbbIxP7qh0a8+foHK9DyzLxw/rPewtAtjTaCPWJHAPqqFL/dpQm9xQDeVECrj5QxOwmUYUWvy4MHjpEyonX5QaAL8ZZmHqTJAmgRwSUC+Yh5SF4R5yWH0EyJGkMRWCs0rb97uGdDM3NXtTn2tg7L0n5a/+pxwgEgKhrnRiP1mSGUXfZOr47h2EQh7ALSWuyYxbNk0cRG+iv8peO1sof0pdUwNwOmlWTnByLLnDVyrcMr0EjSyRFD87TJlDaGOSSX7+ZyK/r8GY1jGJ124CwrROqUVRp1HpADfI1wuDLwymdk9Ue2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vnLMpMXFucZVjSIIXdBkfjEYJ88imfzgwfcaM9vrOs=;
 b=S30hyixXNSvtg4OWR2L5d981EkQ2MlorQRrui75rpM0tEinwphAm4zl7AG5byPOEIpeqN/G4HjMb3jzEYYkmpS1iZiNwN28POkHiaHzYCnnjr0ye1S1K05msYGO/zeHQOEXBC9DGr+rEtz01GBtjULsHbmmOcKTe5KE0c8qAmv62uE6lYnm5d0V0hD5agkkjMG3ccwPS4QG63ZeIX0sVyIygJulRNXZv++sn0ItPgotDqlAn1afvbncOAjKKiW3meEGzEFuabNFJXQrkoDwz675kpuZkEM7wy6NuDfQ1lDSDUQGYaTypsCjR99E/ndcdCsNgVRVnWuUEmot07Cnx8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 11:28:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 11:28:48 +0000
Date: Wed, 8 Apr 2026 13:28:43 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
Message-ID: <adY76wiI82pUBYkr@gpd4>
References: <adUxZ5Qp_vH6cBZj@gpd4>
 <20260408091821.91063-1-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408091821.91063-1-jpiecuch@google.com>
X-ClientProxiedBy: ZR2P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 3583da1d-3a79-4037-9130-08de95620096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Qta0ddsc7dLUR/ClbV0qbjt80bgLp+FdJgM+G1uf/KHmH32vpZfsCvnRZGr8woyZeCS0MupangrLn54nLSndV9GcVl/JCgCzETHYaGbmf1C1jKE3lNw9PJHIPcGj3sTasVZZa0rY4g3fw1P/uuvl/GmINedYL68uKpRrYPeiYiGTPsxUwv+H7MbPMPiloLgvo9ar6fhXc4TVoqdSRnK8enRAGxvrbM5n7zlmcMuxZGEtkEjFOuFq4T8oSB1CSTlgwGAv2zXP+Zq0vFFCUVCqfd+GhAqMGsNIs+GP07TYOmDoBwUXnhkuTjtGI7CiKYH8I0W29W08QrTK8uQb9JJkjRR4Ts9wzhgP+wpBjl4AMb8yj39pIz0FgTmtzLc1NtSdDKynDZpPrWJ2Lz1fFU4sXxKItYlCP/40KejUskNXfN54RinDypCR4YS1j0kATF/X5I7qb3SLiikXF6Eevfob0/TvxGpd0976jjhb7jZedHrTePCv0n4rqc5c53fz+4a66Icjkq3PDwLSShHbhQIysJrc4W60Ysucit3HC0Uk28+cO0iIcc1o+1fuuMAvgEi9eYYPqRy2QL0kyd2bzlrUWSuwY+VJK9JCfiZ1KLa0IMR8H8U/d4NcFzJlVn8UwXMNXP8TvKhGiPvUo0iHqCB9LeClSghJbyPLghbyXh6OhLHn0T5L1F8aDhCSxKdDzImj2JLiTnNq/7KX/xrOkXYEsNnQEeTorUo0VuWGMRo0G3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v+r9dsYZjjjwOrIaIRoxOA0BvPR2a1RAPLvIhwUgTmwV3iBYwKRE+lbl5EKW?=
 =?us-ascii?Q?XQ7Uqwm12qO48RUNA5y6kYhV/vbbptJaCevHzv2uUdrdrltsYii1vVqB9XyZ?=
 =?us-ascii?Q?Zk5qGk+4HGS5/j24sOKFB3lW4L5+BOggURgJ1GfoKDwUXdJkQsyx0eVBu0Xd?=
 =?us-ascii?Q?e0REZ2m8YYsG/UKVM11/KcFPmIibX9cs+ff1jVUjlbbTHx8cf6FA0hYnVVJo?=
 =?us-ascii?Q?ByC4PhqYgbBpRt1MUkCNKRNCrfsnIBJo6aqg66e2aUd6j3GwhTNiiSm4Ebxo?=
 =?us-ascii?Q?U09q5XYn1cv1+39k7bYYWdBy44JYBFoHz0fJUvvVwPEW/0Rg2eNIy+E09reQ?=
 =?us-ascii?Q?5fmVc7/X7qe1yxep8ujerP0cpUNoZPbhZ2wUN+fKEHG7OjebbSZ7WHWubbBA?=
 =?us-ascii?Q?+ZDeCJXV4fZtdJjtvMPWFbVrDIuJQvrJMiToG/lAfnG+Lp+lApaXaA/rlZBJ?=
 =?us-ascii?Q?E5759h7/zb+iki0iPA9+1mZmnPtP7M+lxA9WlkGeyebd90NQ249p2k69Le0g?=
 =?us-ascii?Q?cb2WU0E0/8bwje4TyCCaP3e6fViDgeOsvGqS8q8q7u5N22RcnC+YXsjT5thx?=
 =?us-ascii?Q?J0iSPp2vuycFsjMui7NY+DUKiVNVSc3+n2AIGfMb7aeqkpleqxcMf4pJVbd6?=
 =?us-ascii?Q?UjDVUq9YVlGeK2XpdBTHDyYPiBGKhZuuB6cKLNWbcje4FjDpuRbumMw+cf1q?=
 =?us-ascii?Q?x1G2E8V8Z3VB0RdfIZfkuk1KlQthRWYBLBZmtHblVW23IAtahB3LImjOLG7n?=
 =?us-ascii?Q?QJgvStl0AYma9z+7hAW3NMVNmbkiJPeUQLo/pmLE+N4iW7vd9cQJGq+BP3/I?=
 =?us-ascii?Q?4yY/R0iWhm3qi/n7oIEpQ4qXRmQvuVvRr2EY/Bb/XtM60ZILSVuCZgUNdy0j?=
 =?us-ascii?Q?e3nuZePkf3aAG9g6Sk9jXuhoI7gQpi894NnX1zfdGfQmAVKtJ18M+w222lEp?=
 =?us-ascii?Q?AeYWSF9uJUZcV7diVfezRILIqM9xUc7DxIcAkypZSh4B2Mgiz+mNmudF+1qj?=
 =?us-ascii?Q?clSMA1knTMw3423HUA1kyjLDSXlG5IrjjIgDFlGvafbt4HtGgL7KYpC9iDei?=
 =?us-ascii?Q?VDOtQWLn9OMyPCn1hVH4cxZqS5Vhv96S4p4DvwzXqperW3N2c+m0ejlUFcdC?=
 =?us-ascii?Q?QVAx0UFVDmtmxSedWkM2h+swjRKhPqItSwPFOnJ4fX34org8ayDSC8VR3QcS?=
 =?us-ascii?Q?ZccErU8mPJdVCrlVnQ0nk/Ke5UEvm9bmt5kaDfJ+v+UM8GMCNDNPcekgZC9W?=
 =?us-ascii?Q?OR88fX6rqUaBLUQDG5HJj4UWk0v26a9qfj6aoeuKKXdooNYPEevZR91VIxxC?=
 =?us-ascii?Q?KLrImsdVuxcrK3t6FFxThTNaMsHVAue5Keuu1rLZFFO0jDIY/E6Hlf+cYpho?=
 =?us-ascii?Q?P4bIyjZk0r217ftqAMh7Ax+D5bHcdx5azWejpYjUi7J3EU3jj515sajR13OM?=
 =?us-ascii?Q?CVbGHnWjpL98tKPXURaJeiOV8yJhBCloXLkBKKrXeEaEqyxVNy+zfBNbei4o?=
 =?us-ascii?Q?5q/apSCqf0JJ2dgv6qa8392oi1CqJlgrzhAXVGdB4PLCxFXdZbuev6SD3wYJ?=
 =?us-ascii?Q?UsgkrUuiZllykCYzyneadWpzGHmW+xgDBUzJWM++7ggk/rtrWKKMkVdECi6W?=
 =?us-ascii?Q?hFjGByD1LZLJd/bkcALaAuIOtRmO/T8j+eQ++ObremthA5cxml+UAD/2w6k/?=
 =?us-ascii?Q?gvmzI4Fwps1TcD/A/GrwHT+OfY6yolVPRsCEQt31Dn6ilc+ThbJt0nvJjgYd?=
 =?us-ascii?Q?DxrIYFeDLA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3583da1d-3a79-4037-9130-08de95620096
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 11:28:48.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8u8UWpNd7wtykj3ir625pyLBjZAFxCW1QSv+XBFmxgnZmyoy4lQTJbacyYAmJlPDT3q2mtxNjaW+NSSgivtbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019

Hi Kuba,

On Wed, Apr 08, 2026 at 09:18:21AM +0000, Kuba Piecuch wrote:
> When a queued task has one of its scheduling properties changed
> (e.g. nice, affinity), it goes through dequeue() -> quiescent() ->
> (property change callback, e.g. ops.set_weight()) -> runnable() ->
> enqueue().
> 
> The existing documentation only mentions dequeue() and enqueue() on that
> path, so add the missing callbacks.
> 
> Fixes: a4f61f0a1afd ("sched_ext: Documentation: Add ops.dequeue() to task lifecycle")
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
> ---
>  Documentation/scheduler/sched-ext.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index ec594ae8086de..b5c70f4cfc352 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -429,6 +429,11 @@ by a sched_ext scheduler:

Looks good, but I noticed another issue, should we also change the condition up
above as following?

 Documentation/scheduler/sched-ext.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 29d36e248f58b..99df4cc982375 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -423,7 +423,7 @@ by a sched_ext scheduler:
         ops.runnable();         /* Task becomes ready to run */
 
         while (task_is_runnable(task)) {
-            if (task is not in a DSQ && task->scx.slice == 0) {
+            if (task is not in a DSQ || task->scx.slice == 0) {
                 ops.enqueue();  /* Task can be added to a DSQ */
 
                 /* Task property change (i.e., affinity, nice, etc.)? */

Because we trigger ops.enqueue() when the task expired its time slice or it
becomes runnable and has not been added to a DSQ.

This also represents correctly the sched_change() scenario: a task being
re-enqueued after sched_change() still has its time slice > 0, but we need to
call ops.enqueue() for it.

Thanks,
-Andrea

>                  /* Task property change (i.e., affinity, nice, etc.)? */
>                  if (sched_change(task)) {
>                      ops.dequeue(); /* Exiting BPF scheduler custody */
> +                    ops.quiescent();
> +
> +                    /* Property change callback, e.g. ops.set_weight() */
> +
> +                    ops.runnable();
>                      continue;
>                  }
>              }
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
