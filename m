Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB332E750
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421675; cv=fail; b=PWssZLDlSsUu7obEG8rh3KdF2aL8RcEhR5Sosyxy3MXfEfwU0r9dGV9qAU+B/3uTnpQfD5EEoRXIOhdGkfUToRkpqi4FP9/5V5lqY1Od9K8bqYGkZLi3HE4HqpqScyOR4so/DLerbX2ReB8pMyhg2s0TzNEKPxGysblse/VTk5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421675; c=relaxed/simple;
	bh=uPvmnv3CSMA2VM3AS9d00fPpNWN8aPr5EwVJbpvzbwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0CYGdaxGn0pvjyWGkaCony1OvYxdxoJQSbPkdgz/idDykMctzn+M7RiItqr/11R/TfGUsQh7K+xylXyJQPUPxdSv4LkIPOjBWExp1RTqUtW+PDTi1WuxN9FAC0yJJ13Vnqtq2+wMcrP8j4kXjVg75nyeVVOIX03E8EdIj1DWj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tBukOtIH; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tBukOtIH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyojRv4PAsAHASRvQ09Jj8trl3DdU9XJ7yrs//7Px1qyDWtgFXBxxTJc7MtEcky/3iU0091Uv0q1cY1fEjnKlxv8D5HvdhmIqG3aMq2tEm9XMEVVsfbDBTp/ETbXJoTRebIja8l43huaWd4/RQcx6NmyC8hkZOgIfPdtJ5docfLkP/vgaVVEhBoVyutPyCMmmWyIpYpH3CF1OqVjUec6IrPCSNzBeA4ZMEp7lSkt+RVdI34HMS/0Nw9ZyFSxfFCmOsZP3TZbymdAjde34SGefB6J2PeCdA11qQQXOkUVKfwPChY8SP3z5EjAXQOq1D6PiMG0Wk7VPGXll6Mlzq9EfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ls8Jlhjodt7qsVjWdErBz31u5mSyml2pMIt56EuJKc=;
 b=wU1u291q4UFOedxUMMZ0H4eibshU0ReLjcFNX0+5Bbki5eosxMn/vdO19ASAvfehMiza2QF3a1Y5snTpM5C2O8Z5NEDfNnuCf5mfQLbHfzRN0WlM3UvZtSpRWSN7pb/t76V4NlKE6L2yaRJueopLue8jhZNUI0ZWSTVmTuyw6gQvfO2n7R07pwLJPjhW1zch6ZaDoJtN1gu/8Hv0KQTwKHAe/NW4KZPWBUqvwkVg2m+L2BkvFO0AOb24N2e4srL4BRxASmNbDVc0Koh0ztXErNSLufDOM8zgbsTq7oQfjeUdWaU/ZwFTFLy5HMI05z4cJAuNUYS2OwJwTJ8eW2veFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ls8Jlhjodt7qsVjWdErBz31u5mSyml2pMIt56EuJKc=;
 b=tBukOtIHh+4mfy5trp3ZktBZQRxxzNfAioFvpG1WXklJr/S4Y8CvULM2NmbLX5Kr3yYygss82jH7KWxHbyGn5RBlcGwhq0y3AmNjqeH+hDhj1+OLea7TIRc5e8rPAhnVBDAPN3h+6CnRUP1T8Nj8ZevetJUab6QODoJiC+ehTCJ+FGrt2xrbXHLhK1FFqlxMWXzDSLEJoaFbDXh4uXRu1fQxQg/Z6WGx7hh+txHwDj6mIoWof4rLxwGT/1VB7uyYPSQORWaxw6FVoLelg0cQhghGgkWNq7K4V10FG7N3hmz8lMHkwU7e2SKT+E+vtuk8JEL3EV+mQ6+jbNNXnaENCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:01:09 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:01:09 +0000
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
Subject: [PATCH 3/7] sched/debug: Stop and start server based on if it was active
Date: Mon, 26 Jan 2026 10:59:01 +0100
Message-ID: <20260126100050.3854740-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126100050.3854740-1-arighi@nvidia.com>
References: <20260126100050.3854740-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a9ebb2-722d-46fd-96fd-08de5cc1d43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JrrM/bgDdvDe5jjcM98O4wFf9IlnsGhcZrGvPsS4YLMYo8ciQ4rzDqz/M6s?=
 =?us-ascii?Q?4YXoGFpfQEO+NF/I3RvLkhbBXsLx8KCRRnne8tYRP3S2kTSFTkHOkyaqbGUl?=
 =?us-ascii?Q?YryOm0keNx9CObgTejDPn8qrLKknPc0Uiem/jqf1Vs0AIVwdfGyoqS16Iuak?=
 =?us-ascii?Q?pMOnkCqMscm33BqrJLSb4SOtdDQQ7mhb7vp2Qk3mXzC6dWjw4vG8lZnsyhBZ?=
 =?us-ascii?Q?GnHHV3wbYxaqTjoUX3uyTHpuU/l2Kr2L/fLQVqQkKjsIiODojGShIfJPSXT/?=
 =?us-ascii?Q?DfCxnbrfiKvm0HgWk0UnMQoKLnMldAV/VAfZJNk0as4dnlaSUpd80w2zlQSd?=
 =?us-ascii?Q?jvjQAj5GD5ckCZq6jJKm1ulj+Sce6ubIuz6Hm5ydhSD3FV0dk6aCLX1rWuBA?=
 =?us-ascii?Q?lltLKCrZ3OrcCRdmVEYj9S6s+CGDMGDcFDyO1nuSman3EpkN/4e9Upx7kDmH?=
 =?us-ascii?Q?GBGtmh0h/NDsoHFA3JvFFqYLbBlX84t4WsMCcSCGt+WSCOht+LRB2mfxJWU4?=
 =?us-ascii?Q?3XrvFw/ThwQjbStdzs/wmCQy9QVslrdlJOD96bsS5L5qeplcidoZT3wA9ho5?=
 =?us-ascii?Q?09mJ7AjCXnntcD23DrbHkyZkOj44+j7pal4ewjyutj8vBR4DcuqkeguX4iNc?=
 =?us-ascii?Q?1gnDWN8c7sAHztXdpnT84YiJJgg70tL7COXfq/gM9OmfbTjfwl23GWWcW84j?=
 =?us-ascii?Q?LA8EIyDrfJnyw8WzTLigvBDpVEiqYBEouNjpfx1B96Rh9/q7vtaC3tQ270i1?=
 =?us-ascii?Q?HpiHAmYbAbREXsfiEx3LPPLtGvqNSRIxdpVV57HzuPEnpvAbwx4235Q6VdAJ?=
 =?us-ascii?Q?cuVwqRueb6EPj/6sdj5TobRmaoKF84ztTJOacVeKAudo7KgAsqHLTx/D2hjf?=
 =?us-ascii?Q?3GqF+fHJnRVl9NvJQK/Oz61cr70TaJC3n98N4yE8SwRxRBNbgUuge3eiKhnl?=
 =?us-ascii?Q?wl7QwILp4aoxbHSkSTUnkj77h5cq6HA2XOYKx9lERWHaTd/KvUZ0rLYMzMUM?=
 =?us-ascii?Q?x+zaRhuwiipAtY95lcMiX2TiNMm5UVrAevLLiDXyfZE7qvuRsi5gx6zDYv6H?=
 =?us-ascii?Q?qqd0c7e5KV8P+j+URhMal6Sqn1H6TBrofKKNFAR10jXqFKtPoN4GZl0dh0j+?=
 =?us-ascii?Q?4UUm5JnQjju4S1cN6bDuLWw+ByT3EyRymHpFvADl/wVsNeId+3pxIk+ZGKnC?=
 =?us-ascii?Q?YHX7qPF3EszHxSUsy2FCc6XzWdDwrxYVPSyKlmDepBTveYVAz5YIIaYJsVaN?=
 =?us-ascii?Q?3DgTwYecpMch/0UqlJ8ldDKh4xYe1K7hWJ48rXWV7ocsg9iqCyQ/DbQLTfAK?=
 =?us-ascii?Q?hzV4BriockBRdsaqr2zFZ6Yxv1GqqmizIJYRxoFGAflolnzG8/tYFt6Rttkm?=
 =?us-ascii?Q?bnrLwpQHwPi/v8bQGjFOIXGVltzM64+oymudG3UqgXegzrOwO5QOIAALfgYQ?=
 =?us-ascii?Q?NoeNW5K9pCzA1CxPWsqPywjRaWDAamG2LeH6o7EpF2gOfEP4m1Ig3Dp03+Xx?=
 =?us-ascii?Q?e0n6cxS9CSECFQMgGMNWegiFIbg841lK3Bw/ddUviZdgFO2XlN4lS51PKSeY?=
 =?us-ascii?Q?N5ABHBJE/lq43K5Rw7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YcZQwKHMMFCrDEGNgTgOHNJasrLosHndRdMlGHH8ZhmxG/3wCY4dqQub8WhL?=
 =?us-ascii?Q?MKvdkRP884TjeoTQmzAskG/DezX37JKa10ruxgTv5bhCkmDYWwJqwEYZ6B0i?=
 =?us-ascii?Q?VnvmKlvo2tGEMYJs1frqGlY12NGcGdmDG53P5GqSmVtX+fZKzjDzVH0EwDsY?=
 =?us-ascii?Q?pkUimRjxNfYe+U7JaawrnT0Ti+QBl6f48ZqjIblxZGV92TT+qBtfYym/Syk/?=
 =?us-ascii?Q?jg5YMkKgpB9bpsfmXsOAPfIjhXkJomhgLoCZUs2MfoRtrppmKQqRPQkKuPZm?=
 =?us-ascii?Q?6jXyng0pnI2MSKMIoRNZ7yFl1zTiaga7YIuZ+ejVwAE6siDkN/69iTfCtbtG?=
 =?us-ascii?Q?gnP0kU7pfwV+I9LTj3objMsL16PnBxGJYWrpEk1t7SEOfs0LWybaIJW2nkNw?=
 =?us-ascii?Q?lbmCjdImuXwBwjX14//K/p8V3fs5tO+YbL7ST0EiEOnA9X0C3dBhO+/mJzXU?=
 =?us-ascii?Q?5gHzwBfDzSbcESsWWAFNIKjTbpKjhJL1rd7qooyOZ/ntdyxM9kYNuLRrFqlD?=
 =?us-ascii?Q?YU1kBDlxMRQ+fCGJPWDH+GWh3fTK15AapzZI2jovFvInloHkznR5r0kTXSwi?=
 =?us-ascii?Q?2CRUSLj3iUztaNTJ1g12ufdvexHPfCHWrEBrTjbb6iWSz1CN+5eo61FxVm+s?=
 =?us-ascii?Q?eZk9ziwzBpRHGkWfdRIOGbb0dUvXLY4TFXfoIc5UURtyZj8VnJtE0+aJ9OI3?=
 =?us-ascii?Q?yk94lOYZku/idCcSinaK4zYIT1dZSAbD+cMEj5iRPIf5ftg7hypxuEzspC5l?=
 =?us-ascii?Q?JhNCoSxmAfFraVV9jXaMa9n7xKhlwqCuxqHSOGs5yBEIcjltHqHVkwnoLj5Q?=
 =?us-ascii?Q?n+rTtv9HTCJwiaIMayGL7fF0kS/NFuObqMOVW1N9eHLdM3/KH+XxftP08FC+?=
 =?us-ascii?Q?cAWK4wlVlJIo+UNlTxLPeQ7ioaJtZ/7Wj45z2HzolTAbt6IBdWwqloCOECmp?=
 =?us-ascii?Q?zdBvxEGqSFu3AITKjaDSs2m8066YyyuxQpLyozZLsD64ydBrZ1729C1yzMND?=
 =?us-ascii?Q?SEsfmj1LPuibh+ugDMFjCLkY6LbR5P3xDJF3mP5L5/5wNJb8FaIcxfMxlMhT?=
 =?us-ascii?Q?2u8EEcSFPNzNYwKc2pfTG6e+GCAiqWN9mJAczCAOILf99PRLrOwDOKOf1BEe?=
 =?us-ascii?Q?tXW0YYfM4nrVpCRixWJUL1a+UR7sZvDTZ8ajSUqIeiVhLnXVzfRLt9NLCHmu?=
 =?us-ascii?Q?ier5w7GXgFeCUUvTMCFR0eKZQIDKerdZ7JXHNJq5p82TYPQGQ9x6cdNqGAFL?=
 =?us-ascii?Q?HF+JnLrTpGLeuyEqsW2/9/1mm/2JNS8lAcxwMvYE6VLuyxq5V3v2KYj1autx?=
 =?us-ascii?Q?Eq/+TwdCSROwHiRsXe7hOKp1gU76GRTwC3WFTMAwHIt61W4f1JywdS7CFJa3?=
 =?us-ascii?Q?W45LyxBsnHMQ81kevWxnZ8yIkfoo6/iKHsi+VPeB7u1cJUhJfY1doi+j5IUK?=
 =?us-ascii?Q?zILQ8+nkAiII9GBIZ6WFTpaILqOLcV0bV/3+WNGVv5Cwg2hS4Q3dXdrtldBG?=
 =?us-ascii?Q?qX8vCXUmIYxSEaG5LFgmczJnaxuJlHw6U6Tcn5OYQZw+VAyVraWPjd9Z2nf/?=
 =?us-ascii?Q?Vdoc09vykkBTDEM/7FFfZ+0LWeV4USOg2iE/lnWc2IXc1PwEP49Wwvkmo2OA?=
 =?us-ascii?Q?DMIQ6WtGFsQZVmVf6o2poWtw591bHwXtpY6JfA3ZZ6TRyXvuzLtfByjBm4iI?=
 =?us-ascii?Q?8mOfivza4+Fl43auGJU9PzDsKWROCVi9Ard6d7GzDGI7KIQq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a9ebb2-722d-46fd-96fd-08de5cc1d43e
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:01:09.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNENz+tyGg0ZZcj7Ry8MRSt61PcGG1HomFeYXQ/oNEmijn6T6oHIVvV3LfP+LxAhbhakw5Iwc2Dtgb/ds0KJ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

From: Joel Fernandes <joelagnelf@nvidia.com>

Currently the DL server interface for applying parameters checks
CFS-internals to identify if the server is active. This is error-prone
and makes it difficult when adding new servers in the future.

Fix it, by using dl_server_active() which is also used by the DL server
code to determine if the DL server was started.

Tested-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 93f009e1076d8..dd793f8f3858a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		return err;
 
 	scoped_guard (rq_lock_irqsave, rq) {
+		bool is_active;
+
 		runtime  = rq->fair_server.dl_runtime;
 		period = rq->fair_server.dl_period;
 
@@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		update_rq_clock(rq);
-		dl_server_stop(&rq->fair_server);
+		is_active = dl_server_active(&rq->fair_server);
+		if (is_active) {
+			update_rq_clock(rq);
+			dl_server_stop(&rq->fair_server);
+		}
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
 
@@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_queued)
+		if (is_active && runtime)
 			dl_server_start(&rq->fair_server);
 
 		if (retval < 0)
-- 
2.52.0

