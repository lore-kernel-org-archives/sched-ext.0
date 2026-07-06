Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07590434E44
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355328; cv=fail; b=F4YkeKLSXqQaO8lkJCBWAAWti1Yq77rO7m78N1dn7aBDcY25z+K5dld6jUTGFM6OWfY/m4wh6MKlfwjal02geIFbAME1KhUO82r8PKs53Pckf3QYeAzoHxXoBOPEMJZxSufO7X1hY5yABiSDl2VR5Y1E6IP2o627j/PUhA6yEmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355328; c=relaxed/simple;
	bh=pz/iD6z279/4iV2kc6/pYEMRi07lvHCEgAgW+ltnghg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cf+WVwQJEzuYkyC4Dhbg1paf+fMn2Bz5iSc6Z8ppC0K8AZ0OKBne7YPB35QJTSipmCT0egWQrQ6DeKXHSBH2MjATiZsdGnz8Zgg6IvxbT97F4plr8vhEwjiLonPA1fuCmPVeS1obp3eLsmK/5gTPbIPb3WjdQupDHp4LrzbJSZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fYyvt8ap; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fYyvt8ap"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e48pckt835WuaLdHk2d8ZxCXsYs0fifb61GCig9WJwc2+qhwogYhgaX7NYR8kSA8NSphOV1S0A/b4KwujzT8XSz2K+gZRysmNsdS10Q/H+9+hOqgxWw0QSNqbnp23G7G9exL4WrkVN0Pq3LnMHjww/8SVXCHv3AkRXDM4y50LxLDKK5cDTQ8w8dlN6vkhLghmSj1m1PM8ILgjocVqmlEEJR6qxxrroy0IqRat4emrQkgso/RTjaktK3BITC6siDugTVFql4YjILbmf75MvcMZZWxJSa0/TqY00C8vsPf82OLX+mx7wD3IBXQlV0GGd1bUUrzpgdEN1TFmgySJm+zsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmMwIxiwAqmYtpowqYsgaui1oU0lbyqTkqNcQF42WQs=;
 b=E5UswE7y7pezxqbSseEAsQoGF/lhNmgdIrepJtqVadCPbppRKrFEK/ZX9mEnWzrhIxtpTjOviOCQA4CU6NoWSuIHIaaWGn/50ZlsiPNvTcD8hNHYvGlP9KDc6/flpiVy54oPx280o6zBGJCUirt8gyuJfVcD6DB0nwndfhMfoLjnms974EMyYSbRRkFAa1tJrHDIyK9wVliGicE7khSkoSn49gPVBJpbFV591yeIYE3+HXFz3V1H33mrgdEdBMCyY4ifPFCIQmsQC37ulpDS9fC11kuEERBEPfYsYAEMvkpaF//TA4OTNT0pcn0SBz8OhNCdk747y1R/9kiJY7FLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmMwIxiwAqmYtpowqYsgaui1oU0lbyqTkqNcQF42WQs=;
 b=fYyvt8ap/u+GYFofNpNnko7D79MeGCqdwCGRU1MYCdo/jwQLKdiHBq+a1NyimL5TKnl6rjYcCFaRfRm2wUQsgtaGnA0U7GafKN7zVYZvyZc7HhlrHmLKFTlQ+Kbvgxcea4s6SHCEPNi15R7RhnmpS6FvEEh4yRKZTCShF53L7pmVhyypEUwQelmDPJ4XMHsppdkpHZ85MSsmKl9TiTBrARcekYYP8N4ik5lAKKiC/RGIL3uz9oSZbfPfhAo3k21czZrCGjQz7R0clnjB3LKOoNkbbRjBYlA2kxeCNyUmPTOID0C7EzAP4+gMkCyWY9qhT5qsLzKdA7jx+r2D8OVjNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 16:28:38 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 16:28:38 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Enable tick for finite slices on nohz_full
Date: Mon,  6 Jul 2026 18:18:21 +0200
Message-ID: <20260706162819.650155-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706162819.650155-1-arighi@nvidia.com>
References: <20260706162819.650155-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EAC.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::453) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e888332-a21b-4e21-1acb-08dedb7ba258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ax7dKzrvalexA9wWY8ByKro4VwvF6WdNrHt3udDBo69U6mVi+rJXQwqHCEQ7mkT4Uxptg4zrxPLc48EzK3ONDAxUjdRF9WU+qZnwRN84E9o6Z9Zq4H0v1/csrI01VkW0hRBK98sQupRNwpAJ1nhKTF13ZFjxYA6xbWzVaa91jG8BNFrWPvLV1w817MmLfVwV0Wv6rrZZeZ8dMbFSf7njkB4pQb8p7VNXZxBWR7GfOWA9JseKm+ePY2vzf2eRk+Hv03uihLnjpf2BWKmeViUJAN+t6jmTv4Cg/4zuDfmt3PqHXtVIfGNkH6g+UPJ4//9UGK7wu4iwymvEfmBS5OzyU5MBJOfrdQmul4mgKZwwBpMnv+M23zIEf5TQb/Y20OibTcdRnP3aslJQNrncNZOJVwbZG8Wsn8RoQA3EamprkBtFtsdNidXPO07VZ147/gUrdtOzCTiR9OGXHjcEziGhghsiQ3xlHrcZ6ZLCBobX+4zzwn2gF8Cf8Uso314HxfmfJuGo2R9Ts8a+oRZ32J0uIhoGzqjpEExg3o9t9ZrsYDai3evd1T1sVIo0iIbHca361/b47lhgMVRpdygcVENJ59COywP1kdOTutb6PDI+MO3h8eOSkc000zvT16Rg5CiDNUkSPVMGWEcqnjQMR0EmAx9kKmJTN01VlTU+U/kk7K4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qqZWwn4uWgdSYl0kJkPKXbYNwU/fT2BcvKjWhVi+FgcJ6APDarHcg0envUgz?=
 =?us-ascii?Q?SKreqktHA+R3g2gKM8x1yrD09lpKfJt4Y1QiDE9WsAT2JVU9VE2q63SbxB+t?=
 =?us-ascii?Q?8gt3gN5pxu7E0l/aFXXk0LD8E+m1mATt2PSeAi3RbPWms7tIxM2icgQajfvc?=
 =?us-ascii?Q?DDPC5Ni+wBD8k2T4iVEia1JtkHv2O11M7Zlzfmv9KNVNAEhI7isgd7qjobMa?=
 =?us-ascii?Q?vvsSPkgOMwYBqhHJUh5QZaQrE4gg0KYnTk8uvI7iHx4YUDKPTG0ftBL3VAXS?=
 =?us-ascii?Q?fFkxsHjOqlLnTN0DJKuWafQGLbWiXXgTnO4mOEhvU/HWfEqjq/NdQuuVR+eK?=
 =?us-ascii?Q?Y3tzIekYh3w3YKQ6hk5NIcuxF5zJH2kxpGMWXuKj7NqL9r+fGyV2inVphf7U?=
 =?us-ascii?Q?hNorjyB9fyC56nH6SH/LPsMwvOX4x9QZY+sJFXGwvnFwCLVpX4UyiKOgjNbi?=
 =?us-ascii?Q?BGS1mwsFrs13E0jzKEdz84+o072pkiIZFxq35SrtvmXtOAIQW8kAgxz/tijM?=
 =?us-ascii?Q?NRAxLO4QCzfy+6k8wsB8WVU7KXreOFtWAoZc0NdiLEfUsGBalqzbOos4fM5b?=
 =?us-ascii?Q?DgearVNCN1pB86o4O2NH6/EYboAjjS1yU/tXwvMPmqd5mbslF/kWsMqoq6S3?=
 =?us-ascii?Q?tyiVrX35dKK+0Tbp4vUbAHakS8IKa8ifOIw9grSZVlsLQfnsRh18Wof0ZKJm?=
 =?us-ascii?Q?AK8bi4q0m2DP6uWf/VxfAV/Oe7KO0DMGc9oDUXPqEaVqaGZZxuHwelk+mB21?=
 =?us-ascii?Q?IszEZM1Mp5QAFEGmpLkb2NE/DEFCgkQIeQijT+DmfmLOaHmn3Srwaf+VzMAu?=
 =?us-ascii?Q?OU6qI4hpMPyvHxT/eoAXK4Xr+gjb8HDo0Ty4VGqGO0PLyBl1d2faSQ8c30A/?=
 =?us-ascii?Q?OliMD46EcI2NO4uSFgMwazDdtCk6k05U30M64eGLOEjaMRjxJk5QLEKmq9JO?=
 =?us-ascii?Q?ZwSzVW6nJkrzuZjaIljhlhunSBZqr14NhzYeWsAe8lqtJwevWozek7FqMjRA?=
 =?us-ascii?Q?nKuNzAdledLLLWA/DuKL7xy077oaRF1SOcDooK40FgubBm9AAJ9vGEeFgEe2?=
 =?us-ascii?Q?ODjtYNhnSshkLJ0gbVem8wyX0E8RsUVLfLgV16HRVrpuPdwNgcWyBGaNuAEZ?=
 =?us-ascii?Q?h4nCU18rpnTPhmmN7a7hp9sblvbexSJOlB5GZ1o+zLy310Xm2rB856BdUXFV?=
 =?us-ascii?Q?DpvVwa240Bdfba6EQR94UA0HB4rsytn7vSkfkqrdn6ghoT/6L9yKCTHbp2u2?=
 =?us-ascii?Q?rKjCqXN86RYGwiWkSn9t452htxBVo+t9bgflcgG4VUmNRie21ldWcemeEoNk?=
 =?us-ascii?Q?DLVx+gwql47XId1HHXnZHjarphZIyBOTxaJAsoEXwnRYo+Bag20PgwZcNe05?=
 =?us-ascii?Q?NqfqaG+8ClYNxgifpIK3brF9+LGXd+FMep2JQP+UnBIPEAw+N62a3HQwLCd3?=
 =?us-ascii?Q?R153MHYg4doahH5Inr2+4QjTz7Afu+af2hapbj5DuPu5VQdOdn5cTOCgsTRw?=
 =?us-ascii?Q?TyliUNFn56p/gJ/ZPcph9SV05bPcVEFfeVGTgt9oO8WUtgfvFjXvg4ZTr0Sw?=
 =?us-ascii?Q?LCQhYuB7wF6DsT3LZO7MFO7BSg8mV9YdhWDXNUax6nmB/hu+m8VlKa0lFST+?=
 =?us-ascii?Q?EMUHMeHNHXZvqZHXuT2V0t/WuRORXLlpGE77gg0i7OI8c1s79s0QhSM6eZ6B?=
 =?us-ascii?Q?/VID6PV1QtASp/O+zTVTH6yc4E/RmwcQ8XNJ+EKOyg57N5qZouays6SXGglx?=
 =?us-ascii?Q?gtsWZ2WTaQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e888332-a21b-4e21-1acb-08dedb7ba258
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:28:38.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aR0Oow8VudfbMsdtJ6IIuSZI37RtqnfRWfBX4wie/bWzbklon1bUlPuPhl/4luXUvlw7RCIO5Eh0YOFxHtGvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

set_next_task_scx() updates the tick dependency before __schedule()
updates rq->curr. When switching from a non-EXT task, such as idle, to
an EXT task with a finite slice, sched_update_tick_dependency() checks
the outgoing task and can allow the tick to remain stopped. The incoming
task can then fail to receive the ticks needed to expire its slice.

A finite slice is sufficient by itself to require the tick, so set
TICK_DEP_BIT_SCHED directly when transitioning to a finite slice. Keep
using sched_update_tick_dependency() when transitioning to an infinite
slice so that the scheduler evaluates all runqueue requirements before
clearing the dependency.

Fixes: 22a920209ab6 ("sched_ext: Implement tickless support")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e75e2fd5ab7e3..dc20a8eed8f6c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2982,12 +2982,20 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 */
 	if ((p->scx.slice == SCX_SLICE_INF) !=
 	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
-		if (p->scx.slice == SCX_SLICE_INF)
+		if (p->scx.slice == SCX_SLICE_INF) {
 			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
-		else
+			sched_update_tick_dependency(rq);
+		} else {
 			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
 
-		sched_update_tick_dependency(rq);
+			/*
+			 * The rq still references the outgoing scheduling context.
+			 * A finite slice is sufficient by itself to require the tick.
+			 */
+			if (tick_nohz_full_cpu(cpu_of(rq)))
+				tick_nohz_dep_set_cpu(cpu_of(rq),
+							TICK_DEP_BIT_SCHED);
+		}
 
 		/*
 		 * For now, let's refresh the load_avgs just when transitioning
-- 
2.55.0

