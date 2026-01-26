Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849AF32E724
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421673; cv=fail; b=j8IfKtvahFAJXdv79HqSW+AaPTcOlYuyGzciGeQas0aqyJ8EwxDP7HArdR4SAJYd58RZrumsakWj2GjGPPV3O+zvheeGqAQ4DChQjuUZqAS/8OUUlOJYxa85ewtSKEAbC8JnP/0Y2qFXSjXI6iAfQ4L4YY3P9GJ06cGW+1cyJLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421673; c=relaxed/simple;
	bh=6vEr4bzHlEuAwz+cLeabtpEu6Lzl3CdGEZYrw23GhgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PbuNTCFO35gSLvjdZMwAeZsA5mBw8kV8UcqaobBOtmvXRq7AH7LBKZwjXOIsgBNsaBQXrn5FWxS/dXt9FelY6SQBs9aBk9QFoUsCRK1dlvTqkd1QkE/E5N7XAVPNrKCkvUclaMXI01q6aYZI42zKwG/FNGuesuK7w234iE97vl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GSvVCKjX; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GSvVCKjX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGfO0OB5QbJDxeY3VVtUYHLfju18ZX9Nok5RFI9EaH+EGTILKaRfBHwiqm+g+5xpJAO4I7oxFgkdGuuiU/Px3uBwvJbGdBxJ2S96OP9jNnv6KAPyjQLLvrpR+T5/4pkrBZR9wl08tZ6CL+PGYdO006gWqz9hn/RJHvYHn4Qh26EaeFbCGOB813c4OMJ/nyabOWtrrxd/OIZ6fuOprG74O3VgqUZ7P5P2i/xP2hBoG99uuWp5GkVwbEPhw4dIkFCjYqYrn9j74pIx4j39GzptVvqWk7SvkSkeOmKPA0JIn/1rdSlegtJDV7EIG8cHUa8mKkK2FTV2mjZPFxnbr7hk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLvZQJrN9sti6NuWnv7l4mZawbEJKPCb+dPs/H22E9c=;
 b=qrK4SlADwvXaLqERYlM7RD+TJ4kjp4iJk/JwouBrskFkcd3c9KgQj4UQ2AOlvSVhaxmnpp8dGN6y2Fz7zZOptZ81Z9X8QPG1c7lqCailVwQYmWmyGmmygKtjNpxHigy76YNoYKiBkJYaD4R6tx9j/z9zWNBIDRVmLD28yMX3XKQAX6iSSbzeGF85k5wK+FFvcmd5wh4sbVnHDwOosMAHwlPXD+7D3Bznlc9ewrf80mpIImki7hyGGCd5zDIH99Em9yDCBLz7+cwWblZxftBX2w+ZEMIcRuw9CwghAihRYGhYDQaBbsf9ouWfEpjNmJVYqP30Z2nkMPe5Rebd2HEwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLvZQJrN9sti6NuWnv7l4mZawbEJKPCb+dPs/H22E9c=;
 b=GSvVCKjXF9c54xtdU6gNGckO7larpcgBhj33RrgghS7l82pO7WMDI3ejNUbohRTt2+mekOxCZGRCjUlA96pWgIsbXie72E1Mj26zbK3G7cLcQfAPbQC2MjA+fXCTzScsBtG4wIaEVOCZW7BkHPfFZKP5BxQUQjwEq7FI8nsjJI7vscvxb+lUT0kKSJEP9Yl/+H+OFPUK66oMZ0DT4Z23tOffa/RtrYQszrwPhz+VR2V02qGWAi8Xhtm3+ET1vIjeQaWybpfRzyXfNt/C057PT26jllgGbbqJDlGHOi0TAQddpzGwwx48NykXFnwTSC3hQwofH1h572vhajmwBW1+Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:01:05 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:01:05 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] sched/debug: Fix updating of ppos on server write ops
Date: Mon, 26 Jan 2026 10:59:00 +0100
Message-ID: <20260126100050.3854740-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126100050.3854740-1-arighi@nvidia.com>
References: <20260126100050.3854740-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0155.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::16) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f46c334-9ed4-472f-fb58-08de5cc1d1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aE244ILRIaDMNXNPwVFs4/VrLJscI/iYraRm5VL4HGgkbLpKLvnNce3W2GDM?=
 =?us-ascii?Q?o+N03a0cM+KLVo5Tv/xLWe6VhtfXcutOj/HLGdW1Lv2KUotLllCEjUJHFOOM?=
 =?us-ascii?Q?6KdSBYQBWgBh1tRSvgLSA2+sevSnrOf4C3OOnjv/kxdnb6FFGs0mxP7aq1/K?=
 =?us-ascii?Q?t96wMzrxWUBllXGNT5jBafodBnKY8xKExsVIX7Ljuhn7qVPxyTH/+vSVWjEC?=
 =?us-ascii?Q?6oxTENeU4HKh7cREdG8AqF7qw6OPF2G28xh6uFjXdJ4qqpcQXJRQBVU0W0aQ?=
 =?us-ascii?Q?FPislTV6GvNAML6T1yWj3YVM96ZGt5TYR2cOJkZTe7baooVNUt5wxph6f+5J?=
 =?us-ascii?Q?qNcvqhiJgljxAOepQqKvTlus7/29240MqX0g/KU5yjhCSZgj1WoaBJCcFTz1?=
 =?us-ascii?Q?kVQoLW+PFrN5CWDjaqXzu5qOA06hrAcpSzMbgO0iFXll/yopfeNZXoVJTtWF?=
 =?us-ascii?Q?cIY74gtgT9PAwllY++PXFmO50/x6Qk3fTFVhEAR125NQTNoioX7OEhfLy/jd?=
 =?us-ascii?Q?PyZjRhyoKw0zcPB+AM/0bHFnRBQHDdebGwMVIS0fivIcaa4LrQmgtVXpKsN8?=
 =?us-ascii?Q?hLtrfqE0Cw1HhOnIincSDm/ksHadjrv2394DB/J0CYx1ZEGUUkI2SIKDUEMQ?=
 =?us-ascii?Q?Nts4w01G3qKd7J1QfIKk2LatWFGPjJljlfB8wDGMWi0Alf5ymb5e7uLEatX+?=
 =?us-ascii?Q?6dkAmwEUT6W2q4LCymmX2qwHuONPLkAYdo2JLAz10+AOTOx3npyKshOxbs1m?=
 =?us-ascii?Q?zorNWDIMPLRM9EfLT3hVCfrKEZjBTNcPYAKO8HV6Ar0YWdAe2pfj5fzv4gRS?=
 =?us-ascii?Q?Zu7CtQmDPM6PpehhiC145Z+EwafIlbgmL9ShURSQUEMyDgS0B+nB1w9pKvCv?=
 =?us-ascii?Q?2Gd+wO1LPm5YTZrczMUEKgeEv/gr+OUqPTnUA7BUR2FE1u+AA6blZ0ysv7uK?=
 =?us-ascii?Q?P5qy+ahxOe5santd/dvMDSlO3wC6Ln2yQBIDRbmK57zmf46rXdw8V3mns4nN?=
 =?us-ascii?Q?sMEUtdaVo5Sc0cnrk8igey3Jh4ZGGtlvOXdyq9MGlz18gKIJ8WyoQOK9Qu/n?=
 =?us-ascii?Q?MaE+Ocd0nVLii7lmkAXrqQjpPCsmBFMwzzoEzKikkJbDe60WpXjbIAk7/6sq?=
 =?us-ascii?Q?DVEGekOTPgKIb+HDLC+qBLbr6VuO8YEl73nvTYXVu4wEUMgw8hOh4OGWmbV4?=
 =?us-ascii?Q?fgWdUln4dwoFQYY+H2bHUbmMRZVCWnJ62Uo17PkZrvixEUzwIzF+ePWkkn2K?=
 =?us-ascii?Q?WoVPy+KIfVlEiIfm0ppL/BqL4ClpRw5Wqhjer/EmEWEyLPlheFYM96izAc0b?=
 =?us-ascii?Q?Buf2L/H86ZAfAxVR59QGrYVRl4Ech7KM21j4FAo0qxf3t6NJMMCKeQG1rO+M?=
 =?us-ascii?Q?bXCjKjGzuV8qu47nGWVH1zzUDMrPrtEVMpjR6v+eqq7LgvOHHPxfec6NUsg4?=
 =?us-ascii?Q?hKQWRa5CKUxLzv3EJMY2wP9ZHzew1bbtmliygUaFUzoHEuyypCzjYozbDQ6X?=
 =?us-ascii?Q?Zx+7ATWlMlwyh+RDzDSJp+GYb9EUKq5ng9AirHi+qysTRqdDGfpqwaNH41PA?=
 =?us-ascii?Q?yH9ti5rwMIrxusnX18k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hDF8EklBhdoPp2DFhlN/V8vc9ejTAfOCacGx7qq9on/QWPDZ5UNO8W0NnwRC?=
 =?us-ascii?Q?2r9L6L5OeMhraq0HWRhWrWi/KCrAtiHKfXJFhcZnctWaMwwVKvYmUbjKHFce?=
 =?us-ascii?Q?mozfoAh1dvdPIYPtTjC7iPkn1ewuFiV4Ow+27FQhdColedH99u2l8RIuHXeb?=
 =?us-ascii?Q?NyXLRmByGxqHoF9ZALW0U+RcS+VVwsmP78wQkqSZgqOgY2An16ydeJH5W80i?=
 =?us-ascii?Q?LM5zWMs0DirEltmTptBjV8157LJTxlZw3U/nLNLTcuyO4RtuMsG4xCfqhKTt?=
 =?us-ascii?Q?sDU4IeQtiyGjB3yyP6ritc3a+R/nJGjRlIt+dL/ldEqO1MoyPb1/5XZpv4yK?=
 =?us-ascii?Q?T2YaBbpRmYi0/Tq+1ITqx6aF7z6Fw1Kz6Ji82epBzhpCkcfXVoEuK8EpNZug?=
 =?us-ascii?Q?ALXWBXdp/ynVpEWXd8v5pWH1ryOAjVxiZl0coNzs3o2Yt+5iPQOTS9OMj2sn?=
 =?us-ascii?Q?iEsrfZZFH77mUrBhzym/UNGgsXLLYOlFvIkKebddH3BhOJ+HbD2DatubTgQT?=
 =?us-ascii?Q?oF4VPily2NAG9K/7X1cmEILzQ1U7eBen45GVx/uYeGZHXPmgOS85IxXfUUJ8?=
 =?us-ascii?Q?b6qaXPa1SkR68I5oQ1d3ISo/XIg/rP5X6QdSIdI3N9A9Iscizrmoeq4W31SS?=
 =?us-ascii?Q?s2A/8nuG3AAtccoiLFLNMtd4QHhg2bx4Ne3wn10EQYRDMTleutKbg/s+r9Vw?=
 =?us-ascii?Q?SodMoivNVPTjiR19QgJpWxYA2WF4NMSr2Zi4IQ/1vi6/IOaHwZ9D95bmV/12?=
 =?us-ascii?Q?qfAtT+skpcxpz1zF0GodKUNSkjDt1W+HgoJbgIiMQ878E4QRsPqm/E+Y7d6L?=
 =?us-ascii?Q?EPon7/GE5vxMgi3Az/Y1ONh7qYdBJ1aVArFVwBkAoRykIX1lbLXBkG22FlpZ?=
 =?us-ascii?Q?T8SaiocjCWRpA2E8089VTk7NM06RRGTusiksPqqcS9A9IcHJmkZgRLp22dqv?=
 =?us-ascii?Q?JxUMWXK+DZrMClhY7wVfsarZeLCRIqyjDYEXf+jMfWmEvZzwO/V1/bQFZo53?=
 =?us-ascii?Q?A7pIVO1UltXhyOKNQIbWGftdrPZOsCQ6d82sW0BgiHetdemETSGL2j2vQluA?=
 =?us-ascii?Q?oRKGBXNOMLfTn7ujWnnuppnQmPW2BMyRVWeFZyZicN7KZAz29OdA1Ia3mCAC?=
 =?us-ascii?Q?qVYteLDdHG9np0XyfKxTqlkL2O9XN68QOCuO4k8gkXRStOGgxWPPm9e1lsF2?=
 =?us-ascii?Q?6NnMgTmhelbGr2PrHCqU4iJUOGjZl1mLZQyqEfKrK54vQnn42Z8PCnJAGWoe?=
 =?us-ascii?Q?dKWfw2GW5ms0KcAID+zP3Ij20y9zotjrxp9xGeRc9eaOXZPLhfNJHeKxxj3T?=
 =?us-ascii?Q?G2cxm2xo9yBd/Ade1ute/PYnN4Xs7RssSdyv3FhrWhlEvCJKRU8v35to+Lja?=
 =?us-ascii?Q?cIN5o+OR17nZ6TXBVgiApbxttApDBSS5dW+0Q+4R27sN65DJi1qYYjgAvjoj?=
 =?us-ascii?Q?pAny3HbH33Pdjl6/IH60FuqruIiGL94RbSRQGo2tbfEoPBc15H+JJblhYrbO?=
 =?us-ascii?Q?GPL5b+LheG4+kzJ3gov2zh4Cr7sVelWUactLO1aH9w5mFo3EqPMZ/T+dI/fF?=
 =?us-ascii?Q?SwUwur0IF8oYvCfqE/QYabMKL1zEuO2JxdOX1PumuY69VMZF6Kpgsu6YbQ7K?=
 =?us-ascii?Q?qwTKeDoiAlixJbBdx4cRBPW6VY4qYUV8foBFvIPNVPt3iKmiuBaBGx4oQNSI?=
 =?us-ascii?Q?PxaiF76VngLITAXJ6LHwW6HiV8Z0xUt5ctoEqDY8jXB9vVdX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f46c334-9ed4-472f-fb58-08de5cc1d1f3
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:01:05.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPw51nCK3gACAxViLvAfcbm3ovujphewN50nRDvGDKrq/BA+iD9paTKvyTyvs3wGj4kG3Ie3NbHhhrmjo6nDNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

From: Joel Fernandes <joelagnelf@nvidia.com>

Updating "ppos" on error conditions does not make much sense. The pattern
is to return the error code directly without modifying the position, or
modify the position on success and return the number of bytes written.

Since on success, the return value of apply is 0, there is no point in
modifying ppos either. Fix it by removing all this and just returning
error code or number of bytes written on success.

Tested-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 41caa22e0680a..93f009e1076d8 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -345,8 +345,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 	u64 runtime, period;
+	int retval = 0;
 	size_t err;
-	int retval;
 	u64 value;
 
 	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
@@ -380,8 +380,6 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		dl_server_stop(&rq->fair_server);
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
-		if (retval)
-			cnt = retval;
 
 		if (!runtime)
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
@@ -389,6 +387,9 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 
 		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
+
+		if (retval < 0)
+			return retval;
 	}
 
 	*ppos += cnt;
-- 
2.52.0

