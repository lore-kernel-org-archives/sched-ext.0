Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2D23B627
	for <sched-ext@lists.linux.dev>; Thu,  4 Sep 2025 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965444; cv=fail; b=ERXe6Gdd97bN/XUxcH1Ca6E90TUKEWX9v/AcPkqrYqAJrci9NxdAbfbB515lqmyALQOG4CPahy7Jb90GHXZ2uAvOXFTZvVpddGjtKpKofaIiKY5jTDZDm9wXlR4eOAusntlqmOiZdrss1STbeQagOkalLtBSpK8ZL/ZKjiyg4ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965444; c=relaxed/simple;
	bh=tyUB6Ap2FBDssF3eu/KYwzVGgYEvhO80sG8Oszd2tF0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eS8q9Ob+xywJjc8w7mOwWB6cZZoyogGBFXBtDl2Qw1YT39rDJVOSpZKuEoxPp1CDZJ/vQHlaOsGPhui5yDlxiqUh7oHWIDupLm05oWr2FtfJwZmI5Fj9O2a9y4O0b5jIt6ksGo4WH8WpIuVE+jaXO9ZtXXAcMxRft7WWjWI3lxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4VFHhoW; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4VFHhoW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXCLE+jOZb70b7LRpq60081oh1nYAjEKGr+XAh6zYqJf5gqPcda0/dwhKSIq55/v/W+/GT8Fq81E88pBYd9vYRhpiE2hhHzkesvR7tFGJvBAtTsUm4Nhil6sz7Hbv08LJbSXuMDAHpDyBnSWg9mBwlsVVSfYQNeAmayqmOb/iWaZ5UKCMiLD7QEphLcl4B4i5URLSDOJHR8E0MJYu77VGb+BMIIsFh8ripfn2Xx3aueNk/L/cGSLi4mhKD7k1Z71TPHrmi8E98jmgZ2K2bjD6IB+keat/ww+p+0ZRG+jOF9hZNk1cw0F0veyuQ3ierBu9jx5Hg+6NcHHALsgrDxNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI2Qfs0L6Q7dPKx9pP06XwhTLngGzy7N254io145zKI=;
 b=Lr0yIlWNozVnMrM+GguGYjqSfVTcHL3jgss78gzBwsqmwnFkrahohJW2IawEZnW0ilYjGBnjvsbPXjpXDwJ0Cos4+X46tLwWs2PF3nKvnPvae40ZFH+eZOIRx93Lnwwh1pmpu+TkSJtFzrMyJ9Fs4ggulm9LzLWgrWbptEMC8+Y10zWwC/O1fAnFNyY02zaUyffMXoEiXcfJzEXPolivPG3N1y1Ui2ypO9wHKCeL4fWU0CwwMMth9hOl3s9XcQ0BqBM36CevuWUqJWWDhI/2k7KsAH6SrAxoldTxPCZdzX8nV1FoCfxYCsHXYo8h/ug9V0waeaYNP91X+wV6lHn3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI2Qfs0L6Q7dPKx9pP06XwhTLngGzy7N254io145zKI=;
 b=O4VFHhoWAls5M2dDt+VPfPs4+f6zVOkHOXmP9kDJTaVTut20KBoCyciiM/np6NFomC3awHyWDCnfc1BRIa7vCWH/2OsbmyglYBfKMtJZhtdRgxLbfBYTnCU+No7LXB8SDQuOZuElioCCWB6kkkG71t8ba1Wb/dNhKbMh9krAt96w5WPvIc/QBN234a8+Mun3hQisEobFLSFpL4KyBlSsz5lXfLbLKZ+43Nfl25CcLj2N+ociWWVSjYT4e0c7Mm2uBEdcP0NolL0lr8+qPkJ7SsokoRTg19dVZObunaeRTqTlcsQLWlHriLZPhJ5GknInZxgIrEtdBBTdI+o7iCjB0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 05:57:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 05:57:20 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.18] sched_ext: Exit early on hotplug events during attach
Date: Thu,  4 Sep 2025 07:57:16 +0200
Message-ID: <20250904055716.87268-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eaa74c3-ae8b-4ffd-642e-08ddeb77e8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iHxTzXJtzp5OZxIfIX8VC74vv+BiN04q8P/MbzV91HVAO8hkeirYeTcjq64t?=
 =?us-ascii?Q?0QFPBKgiUCBdBaaiOEksmZKlUJwHYGrXIyCSstgrekLSC5c9Opdp+9gImXTU?=
 =?us-ascii?Q?r/WlWnOudJ7/rBkG7BSzs6Rj69KcgernsHQeMZ9YjAzSWzjLT2qpYe7Nrw/5?=
 =?us-ascii?Q?M8uXIQCc35agqYD8k15y4MtSdYqDeGZoRKIR97r9d5G6WHyekkd6Th0uMksX?=
 =?us-ascii?Q?nhr/25InIScdLnaaAssBPvaWWfvEhCf5FFsE8o4VCfWRuEVrJMtvFYb5aJ26?=
 =?us-ascii?Q?GF2lNHPOThhDvO5uXBIAvT8XOj8F4PgFGW4m++1DSb3v46mJ3ngpK/nFwMgA?=
 =?us-ascii?Q?IF1ciZmX92q6Pq54d5upJVjNRQyguls/fB9cTjOZrzwGWttFpNF6gnT6aARh?=
 =?us-ascii?Q?hiuFhZ6agK2Hkp6M9+MRVY/ohQ/vW6xauKdjdeJMn1EoXqgwsVLZGSjshnTp?=
 =?us-ascii?Q?wGCYZbzU/h0dYjz7zwet2V60r8/z8/Wwl5p4BJYCv9ivsXQkiTSo/nIUhDCY?=
 =?us-ascii?Q?kgXNRyCWVG90qxRJpQ2Qx36yQJSHC8YntuaPe11IPbRKfy0IoFnvF4A56yt6?=
 =?us-ascii?Q?kK2oPLS2knnbwuX8AukWnGbfadBYyhhQyznZJ6TjvYftcLaDNdiSqgGWI/K9?=
 =?us-ascii?Q?3PPeKTspbC9uowCGt3hh53eprRgd7JQEduY06pG3Ht70QgXK/P3gAMJpND6T?=
 =?us-ascii?Q?N2PdOfat25QQHudAjiROzl3ezd8cyKcImX/sPjlRX+B59Ty5Dz5pkAMtUHap?=
 =?us-ascii?Q?1R4j3/xVrMyHC4WpNo4Bvrz4AePK+7j+Bg9H9FLre71wmPcJHx/98fDwpC1s?=
 =?us-ascii?Q?KAhR/n2Yl+mbakZM1BxtITL57a+dtWxDJVc4NaxRqX0mMpZmLpaHe0uO6ssL?=
 =?us-ascii?Q?zC5nCqVXn5L6jjrQN7PZm3Q6JHWygxtgVnxDt1CJKcqLp4CGg8mLGjg4+U9P?=
 =?us-ascii?Q?vX9F51UEkzUxz0qfXomS1w4MX8IHP+ah1lFCsyahFEEzGwQSMh9kBWz5cdvi?=
 =?us-ascii?Q?YHQtC/qDbp9Eh/UWAAIiRYt4LUzM+D/qniRxqWsKztezB6vMZs5DThjAkc25?=
 =?us-ascii?Q?tXvXWqI9v6LM49Ti11e8EigqxyR908G+Bk6MoWsviJw6IsBAvN3QEHp2b9Gc?=
 =?us-ascii?Q?JRmIhDuQHphzdI/OfGut5fJM7v/iAX599FY5dtbcJBkV8V1hWLoLm9xVIPxd?=
 =?us-ascii?Q?2NieeQLWITl61PYBKeKZZI6LhITfMQIyS42LQXoeYMmJYx2qkhpZ5PotLc90?=
 =?us-ascii?Q?HiAKGbpc7gUbx07I+8nwJfWUeb5mlMYQbdX6HmPRQGj/UmgaYVcWJP3+gkVK?=
 =?us-ascii?Q?J3BYH1kFhNZI0wRP0rjtlGa+UAKZREdbk44iWYUS6Ow/5JdiDgUiP5b9LubJ?=
 =?us-ascii?Q?Q5cbeK2s+qDRMjGkxlPUKBfJ8Rn2+VEhR8pZx1FgSej2oYg1kRtr+xf2FB1I?=
 =?us-ascii?Q?2R1QVb9+pCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jgBsHA44yExqPqVU9Gd5rNN6Bj142jHTZvokwkVVQATxBz0QuTSbwL+fD3mi?=
 =?us-ascii?Q?QUJjeGt8dgrFi2VZk7V9tpStTzlBPQ7lG9fvnhKlw1HvoK3Mgdq1PsgomA3j?=
 =?us-ascii?Q?slJ48VFNlVoZp21rOQ4ujYXrKSEYG/ZJCWwhFzcNm9WrRypx99eoq7MSGtY9?=
 =?us-ascii?Q?KH37STzlGvYLwxkIlSqyt1Fqi+t2TBZUBwzMuBqUZiXtobNmGwrBD+h7iMXA?=
 =?us-ascii?Q?IE3FkvWIrfpmlwiNSvz5IjOZAfp+BYyg/lVGbHdpxpO54hFy9gU+Sb3YUEne?=
 =?us-ascii?Q?3ri9YiTtMzXv2DAE97BaXql1DUwNivSk3pCiqdIiAcEVEkjPHZhyUCUGoipa?=
 =?us-ascii?Q?+ZQklhj8BIrmCXH1+TEJlhJ0QCqFL4cWwH6m8DhADZYc+oazIX+5d1EwCRAV?=
 =?us-ascii?Q?gQAGt2SV4haqYMsTpaj7IffPzLvSwPeEb0nbDSHsmkETdhn4DMIj1bgZvxHD?=
 =?us-ascii?Q?LR9MV0ecmJps20MPpfNq7jK3y0h/vMzqOwcFvJza5DfSppoy76AFo6iSQ+aD?=
 =?us-ascii?Q?0WYRcQUoKjfYk+C4WmvBgiaqw9yHjWK7UCU1A3yH0TvIMm0X3KTnefrCbjaI?=
 =?us-ascii?Q?z86oIAsvdQFsD3CQzUnQKjKTtHJhEQgpv+fKfwjHYeg67uBeelWLoEkOVqHx?=
 =?us-ascii?Q?9WOe53W1++QQBbiWBQOinvA/dtRm+DEDp11bEtOzavc7vaynIDXSoZJE/Ear?=
 =?us-ascii?Q?IzkszZFIDhAweFyrkvWalz5WL3EGGn6ueVjUUwcIEICz0ehFBQGCPtFyrrFS?=
 =?us-ascii?Q?BTxQXx/QImDWbeUJpKj4rHw0vN3dsajOWC7j66E5X7Woj1co+I1v2+oMHgX/?=
 =?us-ascii?Q?DMDTRdWwXNUKtAYKno+CeX7YK2Rve2vNLtUsDFVaxwhNF1U9Xi1m3Edxtw5m?=
 =?us-ascii?Q?mclmuQB+HtgxabYiHPBA92NxwLJCQuMF+qccV2JSeXOkkQUV8txtVHhTazt7?=
 =?us-ascii?Q?gWN7UctWq3yddVIAJEulDxv/Q0FdXTjL7gnZo/l94ghw404/OAOScl5CqVIL?=
 =?us-ascii?Q?yuNEud/7JtfyVQHwgBe7y+N0bsDWvOr3dsRO88i6vmxphIHTzjUf8rNBtAUE?=
 =?us-ascii?Q?S6pGTPUXA1QQR+hFib4h8AyHO6avBO5QbAWODnF57QbvKwF7K3V7uVmYu7br?=
 =?us-ascii?Q?P2MxpQZyFXSGKI1wm0WZ7QeRkp8DkiimhNbVzj7YaUebVi720Q4SDn7LWYok?=
 =?us-ascii?Q?HFNeVynX1Qc0/IveetzmAStWv1tnRA3LJKwn6xTIw8HQGzpmc33ikmw4r+Ya?=
 =?us-ascii?Q?kYthoifPxTL/a35jmB4jKbbBu95r5F5qZP1hxVt2LF+rci1w/rnzK/X+MiHC?=
 =?us-ascii?Q?krxPn4KKqsIwdIigrvQFqJGhMIEx464Meo36TvRQN6vo8Wnp++4OHDwfJk2p?=
 =?us-ascii?Q?YXqwa6ruwGzTlx6lX0BP+tyoX8byPGc0I1jXtjsr4HOivTyzViv6ASzBU7V0?=
 =?us-ascii?Q?AQEHpAkpHomRiiKY2I2ypwVneanNjZThb/1DYwjzlC24q5sYr4ajJAWxKw9A?=
 =?us-ascii?Q?eZXy5CBLZxR99CVNm6J6v3sKRla3urPFWZm4oxifcChs29ZoWLOrUh8Zu54C?=
 =?us-ascii?Q?hnITwE9oTZyNCbdwyi3xGzBJBgCKRkwrf34RlI1q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eaa74c3-ae8b-4ffd-642e-08ddeb77e8e7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 05:57:19.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVTQ//AkWAh8ulOPWIeHvWcf2OYhFA5/alpNnm03mpsUyWqQZ9Gd51J3b1IQUZgzsERalBayLA/cEpcRpYdlhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043

There is no need to complete the entire scx initialization if a
scheduler is failing to be attached due to a hotplug event.

Exit early to avoid unnecessary work and simplify the attach flow.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9ddf7a145db6b..489462290142a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4445,7 +4445,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 	return ERR_PTR(ret);
 }
 
-static void check_hotplug_seq(struct scx_sched *sch,
+static int check_hotplug_seq(struct scx_sched *sch,
 			      const struct sched_ext_ops *ops)
 {
 	unsigned long long global_hotplug_seq;
@@ -4462,8 +4462,11 @@ static void check_hotplug_seq(struct scx_sched *sch,
 				 SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
 				 "expected hotplug seq %llu did not match actual %llu",
 				 ops->hotplug_seq, global_hotplug_seq);
+			return -EBUSY;
 		}
 	}
+
+	return 0;
 }
 
 static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
@@ -4560,7 +4563,11 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		if (((void (**)(void))ops)[i])
 			set_bit(i, sch->has_op);
 
-	check_hotplug_seq(sch, ops);
+	ret = check_hotplug_seq(sch, ops);
+	if (ret) {
+		cpus_read_unlock();
+		goto err_disable;
+	}
 	scx_idle_update_selcpu_topology(ops);
 
 	cpus_read_unlock();
-- 
2.51.0

