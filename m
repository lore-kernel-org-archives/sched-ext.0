Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2867B33CEBB
	for <sched-ext@lists.linux.dev>; Mon, 29 Jun 2026 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782763602; cv=fail; b=u7I8Sqkln+gCOqU5GgaxuFh0EjkBplcYWsEO1w2X/MakhThgvgTBkHMvsQPZAX/EzarBB7M1JqBWcqf3dSVPdz7KDzf+7l7xtD4g4dRKTqLh7JM3c7A4ha0FxUqDec52+H+sfl13R+MKnW3h0FlPnjDC4EcWqPit0tj/3/SwJKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782763602; c=relaxed/simple;
	bh=mqRPSYcE5W1rh7GTUePfxCMlbQ5FXH23JLTR5G4OO+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C3J0VOBUl/wJnwv0wEMJMm8DIPKz4xXKsheBOwAQVlqItrV5R0U0Y03h2h+HhJw3eC2lUAOd/+1Acu/uY1wknMN2dGvzZnOmJN8+IFxRczEwhT5eFdmXHey1wB5TIf5KIMP2TuKU3zVQ1qnkB/BJ0NOR1h2KNTsry4jYVBRn0Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EjxgyPVi; arc=fail smtp.client-ip=40.93.195.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EjxgyPVi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4ujf42XzGiEO1l1eaf/ZhNsQzhz4g8QDZc/5xRzj9eZfy6JaXMyHWBvhfr2njlDdAEM28rfEgEBjCtTXkF4WHbvFd2l69wJZOyGsnAUJzrLRw+ZmZ1ge+cMzKBjJhUhFRqXQrAs7e6X3XXYJVjhsUvM5UatTz0CedJL6SnIpjSI5gXZ4z9YvJlgCPmmRfDpH+A15qTE/ZiX8Ld2Xo2FA7GIBqcmknV6oHF5KaMiaCm25i9XjwvD81nuJvf/EiDOBwu1Jbpng9pyp0N0p7EmhU944PobduyVdu6xpVTXrnGBlBHxJ82FcLo30ByDQ9SkOO0GSlvjHfnSI5QZbG/1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxGikQogd7fkNoqIWbgs/iJohYHNIOX6dkbpt1eAbMA=;
 b=DC3AzydXCMEzWubRJbtXUrAo/UsuuShGBUx523Xwu3cmUEXUJZvrkNXOM+ieNOhOKn92JhyiLZCu3lOpUu0OMlQjYjxfE5grxEmV8IWh6gGhlcYSKfVBL+NatsU54s6oRMXd1SpE5N/zi9K9f8JMm4TxjQ4fsPvNo/kENqY/7fEzQr2OqeCEOFB0qnmuWH3F0jZNELvbyRaFKCtLUmInUMWM7zbefixOBnO9iRXK37FbAIV0edO4WSgrF5IVkGIDobLKvXG5UtAmyYwYC7l0ktVfAFfOE5pQDYnCsUujxd3s1t5hVX1HA+bwRtwpc25iBxToPTI8r8x0kxFjSRNNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxGikQogd7fkNoqIWbgs/iJohYHNIOX6dkbpt1eAbMA=;
 b=EjxgyPViL8SAUJ6RsyebRvx3osB12BbT2+LfWkTUmzDggd44RY3sZuyLcp9mWGDOgQiHUblQPb/rFwA/FEr72zlL0XJuikMKjoZ09N1PoJyQig7T19hDWRzFzzcJJaCyiHOBD+fa0fDUHd9wrtYTYLGhH9RHxmAjRZbExoz07ADM0fROJk7KQhLIh8VN23O/g77URNZA7Dw2JlMJIwHDVvjEBDEBAM9a0BwEHSXIlWlw7qIs4L5d2WEQJ1l7hDjtbmaf7EvQB7w1+pHfV9a3NlkMBPIWwBU9uiBHof+0VS0MJc3K0WAykwc+X4Q2QANEzVaxlRuyIn/MvvBao/q6Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 20:06:36 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 20:06:35 +0000
Date: Mon, 29 Jun 2026 22:06:20 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>
Subject: Re: [PATCH v2] sched_ext: Don't warn on core-sched forced idle in
 put_prev_task_scx()
Message-ID: <akLQPAMBQBAu9RCK@gpd4>
References: <20260624235531.2979880-1-tj@kernel.org>
 <20260629194355.3143816-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629194355.3143816-1-tj@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B85.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d23f39-1127-4c54-5602-08ded619eb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|6133799003|11063799006|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ptIdhrHFrXhMZq6A580HjGFisZLmp0JN0v78vTQ5J84n5rcXhaYF6nnCS2gelB+xCsSdRgqvAam5+v+mZFPltMjbIPiAgs++8SlzO3Y7mSzn6+pZp9zCIjZOe77wy+jHQtq9Rr8o/FPcmipBbEmZQB6NV5ju3dpSrjszaPHlbHzWaixUYKUrFczWwQbT52Zx7NytWZjTPhvDY01EUW1NXSnU6tJo1yms9Kbgoq90kdQFEXzQv1ZgFZdnn6aRCxLWeGkZSQw1RxlFfPyNJIRN2S9zisSlxhsvAeFy8fOL0+Kscg+XlFqcaHgOLnitZWuVDzHQUAlPuhbK2Kq2es6Min1gUlmE4cyKL/iIqN0w2xp7o1RBCUSfdliHyUTzHPTBMW0Xa/VpQ2r3pJ6hTt6tlwagIeCEWzKkQb7V7VdBpoSTGSnW8s/yNrETMTfLbid8GETA4gRXNE5i5siStgqmoNvkX0xnXa/ql01D2Qe+P4710cFfzIqFxDA6iiPn7J4vdBE//PatHaQ5H0ENbtKAi2xl0Luvqzo0stbdrNhiOwrWbk1ltLTaouW3Mqllyf++1dV38VGUnIhyL58jAOY1CoNt0iJMh5NUhTa1JbLd5k9Nr4hF3sSDb2/990zUt1KhNIAzYc4spnwQSguCfZHI5b0nMUdfuPQy9vbIXoKIIs8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(11063799006)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6j44K+JwY9kVtFs93GE0moY3oKmz/BG/d07kBe0/+nvJdG+KGs14K4qYH1wf?=
 =?us-ascii?Q?fRmhnBV3yI1ScoVpFzwmPnc900IqeY7BqXgUUw3RRROtGFDr+48g9s2SS43I?=
 =?us-ascii?Q?5t8ZVI4CHgsgGBmugOSjew2mV9UMJzZcJ4QEyY9ogwRGfsXZAGbvFKIhT1Yn?=
 =?us-ascii?Q?jlueAXs/aEcxbt2Gc93Ev3uTExGCdMvK+8JrUyOzXRjkY3qUqqfyDjjjlsxY?=
 =?us-ascii?Q?FN5ocJNEvnPlm1VWVkwXXLd1b2D3Aq513LqZ0kwnXV4dt0/aKS0gkiEYI9Wf?=
 =?us-ascii?Q?QYUqfBKWMUgfGFVyQrVB9VmqE2VT21Sq5HxsjO9KpiVyP2eJD/KaE0Vezm4X?=
 =?us-ascii?Q?DJdRsqTF6FiBYpAc942ZkF7bgKkFlcUctFlpIqbWBZxLIjWupvuFoaiA5VSp?=
 =?us-ascii?Q?GzG9oAPRBkl1oHFy1dsI9wBzGyhykMkzivtFLL2SMr9cIu3LN3nWYwfcylQ3?=
 =?us-ascii?Q?G7mPlfDDRNW6I2oJslk0MgRYwgwbP+NA6u3ly6D00NDmhHIN1K19I/EG89Pb?=
 =?us-ascii?Q?6f6mhjK18p3i+H5mcfIFMwCIxS4DBIiuicOqlpr/7srMlnq9pA6nKjBMWKRZ?=
 =?us-ascii?Q?FrYN95+SAS5U9ZSZfvu0heYJ/BlaYueDZjeM0cJmIqOw8nnjGeNshh6u092f?=
 =?us-ascii?Q?ALsFq/D3fFinEP3tPRI2b9R7bTrFhuWyl4P3ZxZAE8TAqAGgChXBOfJzONnL?=
 =?us-ascii?Q?dN+enOpM5rNlHLxlprdjMlWy0VBa/X3xRK+LXeDvhd/gEHbGDfAaTY7aQuSU?=
 =?us-ascii?Q?01DR+iAceFUyAaUYjC8pZPbz0gXWw3nyYOlxJZK9CfFyIDGOeJDVE7Y4O7HO?=
 =?us-ascii?Q?FyNQx2ugW7kW8vRpV/VVfPDCy9MCKxZHE6VWwvGStisND2y4H2HRppJLtOz8?=
 =?us-ascii?Q?0qymZ+NCGoIevr0inYGRYNrFSHxRffGlSngx36zkqlG6FpM0anOuC+c43Iqk?=
 =?us-ascii?Q?Lni/CsRDYFqfBjNs7jSdxC6NW2BWW/DfDaWsCgG2Yt8nfSAlOxwmsQJztYoM?=
 =?us-ascii?Q?VkbxuvtRxI17OupbH+Ua1abvMimpWQbXbN2Z2VTGaSL+wSCsgGfDIbV2CRPy?=
 =?us-ascii?Q?jJyws9d9gsM9n1vOcdbgUBTGoWfSvKa0BRi6jU3V8OIF3X75EYiDDep1hkJW?=
 =?us-ascii?Q?DWmOlGnK5Izb8Uk3lmIDmk77VWnuI1N9LyYDeSLywVWHtXZhe6foO4Ov7nWi?=
 =?us-ascii?Q?tzoXpvpEZgf3vb7Rwgm9GDTj5Dlu735jiraiQKnWKWrEZw1Qgk4kgdW0ydEB?=
 =?us-ascii?Q?ht1pYJQ3jAEK64AX1PQ5esTfw2Tz8kWcTKDS+5oRr+IYJESnAFsmvTyu1P5E?=
 =?us-ascii?Q?JeMQOGzsPYnY1ycmb0scKVA6tE/LqfIrep50oKzLZLCm18/Zw+f0tXmC8YJJ?=
 =?us-ascii?Q?G3qtAfFjyQaw0D0H/bA5g5CxlJKbb5pmEoOmeAsdgCwB7ESF053v/+p/kxgP?=
 =?us-ascii?Q?7aI0wDTjA79aqHj3EHnZ0y9FF/RcKgOFkFGY4cSUzukmKULHEngHlvz67VKh?=
 =?us-ascii?Q?HfalyatvgGKeUEsS18t+TTW//iSUPg+pVcoAS0ag7T7GqB0us9YxDf2fhFLG?=
 =?us-ascii?Q?0fk27jbViS8kqV1Bz7z3l3/j/MSKJt4vpCrY5UBjwRaSy7HRoPpn69+3bpQs?=
 =?us-ascii?Q?4vpk2zZUZNpP+kCRya0wuL8Gzds/J6wuKRjQYaEFQxJ2ULWDF2Ghu89qFd9h?=
 =?us-ascii?Q?qKvRO8PfUQ9lsjQcnUDXUqBPFL17b87X43jyLQ+1LXtxmJhrq+PjqKeMLyXG?=
 =?us-ascii?Q?HyMp8jEevg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d23f39-1127-4c54-5602-08ded619eb98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 20:06:35.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XY2XVHiRtwN0sQdh0RBXirI7ASl6L042fyT9IY2xikwG6891b0HfyU+ksYBsZRB4I5EU3M3zPk9GjUCPYQwzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551

Hi Tejun,

On Mon, Jun 29, 2026 at 09:43:55AM -1000, Tejun Heo wrote:
> put_prev_task_scx() warns when a runnable task drops to a lower
> sched_class without SCX_OPS_ENQ_LAST, assuming balance_one() would
> otherwise keep it running.
> 
> Under core scheduling that assumption is wrong: a forced-idle SMT sibling
> reschedules through the core_pick fast path in pick_next_task(), which skips
> pick_task_scx() for the CPU, so balance_one() never runs and a runnable task
> can drop to idle with ENQ_LAST unset. Skip the warning when core scheduling
> is enabled.
> 
> v2: Reworded the description per Kuba Piecuch's review. No code change.
> 
> Fixes: 7c65ae81ea86 ("sched_ext: Don't call put_prev_task_scx() before picking the next task")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/ext.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 9c9cb9d08bca..503c4d2105ee 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3092,7 +3092,9 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  		 * which should trigger an explicit follow-up scheduling event.
>  		 */
>  		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
> -			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
> +			/* core-sched can force cpu idle while @p is runnable */
> +			if (!sched_core_enabled(rq))
> +				WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));

I was wondering if this could be a better check:

 WARN_ON_ONCE(sched_cpu_cookie_match(rq, p) &&
               !(sch->ops.flags & SCX_OPS_ENQ_LAST));

With this:
 - the surrounding branch establishes that runnable p is being replaced by
   idle (class below sched_ext),
 - the core picker has already stored the selected cookie,
 - if p does not match that cookie, this CPU is being forced idle by core
   scheduling,
 - when core scheduling is disabled, sched_cpu_cookie_match() returns true, so
   we preserve the warning
 - when core scheduling is enabled and the cookies match the warning is also
   preserved.

In theory it should work, unless I'm missing some other edge cases.

Thanks,
-Andrea

>  			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
>  		} else {
>  			do_enqueue_task(rq, p, 0, -1);
