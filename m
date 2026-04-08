Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1EE3D667D
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669006; cv=fail; b=frVNpUUTlVqzM+7s1nJzbuPTefcEQpPUw+QIlF8Wg6d3aSAcPt5tur/73cV/OSUxegGcT3VMxb2wKyBiF0HSggta1PGLv3zPC+GPEkqYnoroABzXm17ReTkMLvZ4WCFczUi/+Fb8P2kESYXHk3zafiWr4HK8c6uDc03MTs9uyVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669006; c=relaxed/simple;
	bh=aQPfRU6iFy6b2lRUbvtVFOu0UJ88cjYmwlTUKiycv/o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C8KAiIka47nA0iwvgLGZSQWb3gd9ETJBbM98b7FVYDlkaL189Nnm08jB08NM8XPPjKxLU3zdFKYLrPVhwoC7I/+7+7vJRB/zs2UYKdV0RFh69pIuabTZ3QwcRjc8Lm/wEScU/eWATImlmmrNIXKSzWWz6XDgbrqsL6vciXDXCkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJRYm0gh; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJRYm0gh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dzq6LfEmEuP7nClokdKW5NmOHflihFiC9e3fVeVdUNzFHH/3lGWaezHKU+pOVj2kv/g6oGMNrmIzkdMpmhiAHIwt+WtO2c4CM+g5zB6Izvdacr3YtCZzbtxZ1LqFABV/jDZ2xXvsb7iYw+7X94Hl9cF2WG+CQ+0JrmvDiA0mk2Zi3RmiCIyfOdv+VLznPhil/wVZ9rotzDFVy9euqdC9b5exO21Q0O7tjkZi2VGPmNMgfwwhS/Ib03imXgR9jIoteHZLdV/Xx8MDUcRl7QW/BQOQllBpUed2HM/t/a5uv7DQp9+uNnWF4+TDy2g3wY5yp+gf3yEGiTH19FmP+WNysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GipI4nhoeUNG4UupoJNqWH7Y5Y5oUtprVP6PUZzytBA=;
 b=wARfgM/ssRKpoolWXmwaihPBUfuMF3nTeIEbReHv8EBLks1pIHNV03Q97hd12ZQTwIf0PLiIVYGJiMq2bAwdWuvRp7MsYHC2DGy0AlFFgAsxsd1m3peoTjcDUYFIWdKETvqI9OjStYWlbhvhlia1hwtPos03E+a/I789PZ/2jJUrx7M5Bpa12xVPDoi3tZcokrZFjSy3AHN/dpCRQqnKLwWf2UntQZxdbZPx39jlsC4y2I9punRBTV5wjhT2KzEnw6h//aDY4vQu7wI4sdNrjW6X2D4UVTKzzIpFn9B0N81ztXvrQmfbqeclvetmZXu57tc0vdYmUA+DSGw+ebfiiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GipI4nhoeUNG4UupoJNqWH7Y5Y5oUtprVP6PUZzytBA=;
 b=JJRYm0gh/9CHw0ezZuaZkSqcHQZQbYjzZ4Agso92ScCCct30QOKR85Lhiax/LN/o6htEo/ufr5ynxlL/W0dg4yHMcNhr08aQclhE+vbXUZOb5kOwkoKTc+LEaFnZWYJBpdYf/uS8TFt5cNtVHHCRYxJczFC3/v1aODKa1bKqx/tI7C6OaCo4PPt8RC2sXYJ2H0CRF+/3Cwef5jvjGsU4Eyvq80IwkRaWy5cnXIvLlFMqWzVPQ26N6ppz8ZBUJuOzDvlKdhoef6oCi25QJk1WIhhLsRgDj7DOMugl9Jve2PguQC9+ETxXRdYr49Wq8on1b2AYRMmKaxX/mKn+dGebEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17) by DM6PR12MB4091.namprd12.prod.outlook.com
 (2603:10b6:5:222::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 17:23:18 +0000
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688]) by CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688%5]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 17:23:18 +0000
From: KobaK <kobak@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
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
	Valentin Schneider <vschneid@redhat.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Koba Ko <kobak@nvidia.com>
Subject: [PATCH] sched/ext: fix cpumask leak in scx_init() error path
Date: Thu,  9 Apr 2026 01:23:12 +0800
Message-ID: <20260408172312.2178104-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:d10:24::17) To CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHXPR12MB999244:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 491c7ce8-d8b3-4ac4-2c60-08de95938667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JGf9aHXluQt8m+F19RRXQGFjNmGvX862EXpK7gT6btpWzX9KZbmgnqo0mCzmPN2OCTZMxmWr67nZBD8rReqD1ZDwa2xduerVKSaF8apnvwjeHXUld35Z8Nrc1XiT9RPgCaeEMfJJcABv4bQZNwx/MA/5qBBJqXO+OiiQvulSjTe2mQMxY9T2wHfqZixKOVL+RuGrYSYJh/Yn3lqZttKfD7UE8X5ARNsRCQDXy4kc1GMpG4AYEJ8445rrr4J/rJgMEoHvLnfc3rND/5ZSEmLOI4DV/pKL/gdL2ZVVlfpGu2Uyy4IyDl6vEve3TpKX23v45VYXwR+LvUJ12ANcyTDnWto0K0LkM3DSzCRMq+1TxREVjWrrsLeP71Jg0F4cmVh4mUMuIQSpPvr9mcKdHXZFu1//5ZMcNBVF67Ehs20exy26dZow1c5UlrcbxUHF1ywoOmZXJvMOG8FLi8aEcSHp7hwj+1RuDSnfUQk9ir1pvRatd8SI2xKBLZNvnL/vDKBtbBgeQW0vNTrdBrfmHWPAW1Lks5pM57y6jYAewW2RhNOZnrHSWLOk7lCLsDtIslvBQ14wSodlsj938LB79RlN3c0JYUK5vP9qn/W4ihoDcZdW4mhUAj3S6mVGrvBxXUogGZRHyBA5MGqs4NkhSALva4FCjOzQyhRlaNObg7xtwiRc8t7zxbPwQlHDAefIJccE9OJdnZsl96/syfKhSkdkURPpzUk/zynVGYhITIImRpg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHXPR12MB999244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eWAdW+F0re8SNImuapW9Wxni1lp7Iop9t8eezGNu7MHJLUB4CVuEqbuvQ6l+?=
 =?us-ascii?Q?tMPH3WSzkappaZdyXGeiI2wBO2zeWJH1T+d16dvaokGXMMX80zzQluBUrLxO?=
 =?us-ascii?Q?EGdpOhsWmB1kFtY/6L5GNS3mM189Bp11bxLNtpsMPs7dI1q5xd0I/rD3RrfC?=
 =?us-ascii?Q?SHauwvY3a4PkVCWqVKAe6bzPF4IDcPSaXDZKY5Mc33Ty1HagdK3Kob+LoCuP?=
 =?us-ascii?Q?JlpqW3UpoG1rLxLb3F6Qaw5T9tkIgQJZemkJUhCWYiYOtbe/rNPxF13AnUMd?=
 =?us-ascii?Q?3ts90TuvL42qS3LnX5QmQase9Una00LnkiPa1vT3f733d/EdBBlXNKAwdkU9?=
 =?us-ascii?Q?5n9+qdfsXm9d5JFP9y5XsZ9ZGYTggUcMPPmkoxa4i5NvxlvtCgOuQ1Z2s5ON?=
 =?us-ascii?Q?1Iui8fpmQ+Vndkm6hiJixa33DFHiGnMs1cocgOfM89zZsnsJxci3COkedQgb?=
 =?us-ascii?Q?15VYAZzCRf0nZhcP4yVJEtUebbDwpFOJpWdnvLvd7VKahzVQ4O24Agadq0jt?=
 =?us-ascii?Q?0tReoO+XAgbaDNdlPkZ+36tzKsGfwGriabPEdBrgE8558u3uMfUfrqC9H3cp?=
 =?us-ascii?Q?O4CQuZ7b4M4L1IZKqFhvE2b89IkQNaC4VCnXPjUVXBpwmofUYKY0OOxcOooz?=
 =?us-ascii?Q?nmJmlJr5EtVxKViLVWEA0/sVOJab5YnnDhAMTAo2DWZWgL6HNwINBuupGW5j?=
 =?us-ascii?Q?DHCH+3ZxOIuz2s91VuUA/OBL6nabf1nl1LN7NgNT35icCh4lLVK1nlGCtCbn?=
 =?us-ascii?Q?S/oGdBukFxxLyVgXvgtbaPocqmbvo4liKm6CgLwo9otGcGf8Py0RX6Rdad0a?=
 =?us-ascii?Q?ejONT+xKCQCKw0lZSPEunhLEeI3JGzGxn0iY5l1d3H3RGaiV1z89scs+sHGQ?=
 =?us-ascii?Q?/awhqYIux5PC0tgE9MdNQA9tDah2sH5Rw5j4N/jUTA8S2Zugu+tY6dFVxEUF?=
 =?us-ascii?Q?GfA1Rkp2ONK3jnCLoR6klrND9XBk3gnrwFsUyCZxtBAxjB8mwAIj6JEdbp4+?=
 =?us-ascii?Q?nExv/zCPpyimD9qhK2KDu9g59B/pUc9NIjTBVuXR96FnxJn8mkvPPOz9TckO?=
 =?us-ascii?Q?YB0o2/1+WD20KPTMRJheqzItih38NnTTASK6bPZmZ6uU+3lcMls1iQEDcXhH?=
 =?us-ascii?Q?o/3CouvsYcJ+0UMyFQO2TROSLvykWzupzXqlB1XR7fk+BoKhGnFYzkoTZ4MY?=
 =?us-ascii?Q?lUSVo9vSc0TtPKFubGHkx7l9gTh7mGEVkh7X4Rl05bKTS993GyRYtFG4t3Sq?=
 =?us-ascii?Q?KInmhn1S/TtMDy22r968pJHMWi+KmZOGFta8FFPo6Ttq/+5pm/RrwvVkt9in?=
 =?us-ascii?Q?kPINbzyV9fMWxTnJ/JbWtYYOlJSlKsxfD4O7NhfEaHbGFwdobhNeCCPwszt3?=
 =?us-ascii?Q?8PU/l/NHXz54pOSaT+t3iOYYnRWDqZ/3YtGTlCzTNoKpSva7g7eLmjtpZ/0u?=
 =?us-ascii?Q?jNL0y2OGIOqE1zne+uMBAO9IzO+LlBekpboMVIbVfh48zfw5Hz/r3DkLqAVi?=
 =?us-ascii?Q?72NrS+m08hE8CyKV4ScIRDAO1bzTovjbI+xmXVOKwntLrBMBYqBcRVuxaY6V?=
 =?us-ascii?Q?saAXYC07TfolNYQHmibeFiJU5BRDtQ2gbUdCyI19vbHCHFFVANDmhI0aFd7G?=
 =?us-ascii?Q?L5uMwYrNeujicFCC7/nVxYC2LOc2WcBI4A+LmFgnfBIxQCPS0qKMSw7Fe42y?=
 =?us-ascii?Q?jvlQIYOjsCxF7L4lmev5xcKXM9hoSkRSVLGLzjas8yE1Kao5Td/0UY2xbime?=
 =?us-ascii?Q?kfoBc6rIOA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491c7ce8-d8b3-4ac4-2c60-08de95938667
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 17:23:18.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+YQPHnp3/EsEyJFRjnNHaCxHN1V+iE3Pf5OjdzbMQ8bTLawtm/N3glMwHg1P1DJJzOhOuQAfaEmrqKrvE1eIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091

From: Koba Ko <kobak@nvidia.com>

In scx_init(), two cpumask allocations are combined with || short-circuit
evaluation. If the first alloc_cpumask_var (scx_bypass_lb_donee_cpumask)
succeeds but the second (scx_bypass_lb_resched_cpumask) fails, the first
cpumask is leaked.

Split the allocations into separate checks with per-allocation error
messages and free the first cpumask when the second allocation fails.

Fixes: 95d1df610cdc7 ("sched_ext: Implement load balancer for bypass mode")
Signed-off-by: Koba Ko <kobak@nvidia.com>
---
 kernel/sched/ext.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b757b853b42bb..0648088a76f09 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9662,9 +9662,14 @@ static int __init scx_init(void)
 		return ret;
 	}
 
-	if (!alloc_cpumask_var(&scx_bypass_lb_donee_cpumask, GFP_KERNEL) ||
-	    !alloc_cpumask_var(&scx_bypass_lb_resched_cpumask, GFP_KERNEL)) {
-		pr_err("sched_ext: Failed to allocate cpumasks\n");
+	if (!alloc_cpumask_var(&scx_bypass_lb_donee_cpumask, GFP_KERNEL)) {
+		pr_err("sched_ext: Failed to allocate donee cpumask\n");
+		return -ENOMEM;
+	}
+
+	if (!alloc_cpumask_var(&scx_bypass_lb_resched_cpumask, GFP_KERNEL)) {
+		pr_err("sched_ext: Failed to allocate resched cpumask\n");
+		free_cpumask_var(scx_bypass_lb_donee_cpumask);
 		return -ENOMEM;
 	}
 
-- 
2.43.0

