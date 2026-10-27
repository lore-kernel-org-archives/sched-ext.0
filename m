Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793074581;
	b=IQHIlmR3D0RXPz1KkF+OcbPwE/qwkBHTNyZWTLG6hJK8n+Lqd3wbCVsoLk6sBzULCRLt
	 qS5Xe2WznMfuXEY8QmMEEHxoCsGvF5SlcxI0Ik/x+ERwd3aZnsfGzc+KOYuTHumDD1T34
	 xGoD/D7kIf1Q0epdJ7cY+/lWwg1rhz0YgZjSE0eIXeG0OQIq4HOwB0R5Xq6UEvYBOGOeu
	 qwwvcmZMNw7vT67VBSGrllHIUddThA4I/9TTc/KDC8SM1zRWF+VCOtJJtlYEbnQxikl7M
	 d+ERxyhNcXY8Vf81Y7VPdmon0RXHRSP9gaPInASmKb2xd3e4L3aGuU6fkXURqUGyMjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074581;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=itof7wfZAYob52Z0+7HkXZnimQA+WRggSG5k4EbxK3E=;
	b=polnqOXUIQ2XQWKMkCGWFiuMd9RJvU0wDlIbm/4niGwnvlXLPP54hUSCykraBbAXJp+R
	 ENER0PGlOxlX2RHQIBIyqJdYKuqkXrcI+cWPHEpNUvHkWO9x3y+CJi+pthivRMPTw+DON
	 YFF639IIyiJcp8M1c5A4hBi7fmPSwFkcUFyCbVhNZQQh8alWkZecT834U3Qi7IVwcl2+P
	 G/JuXINNlzI8K31MdQLUFmUpT3GJ3i7zuVv4FEN8RPbMJyZn8ysY8Qu8C7gNSDXceh8rd
	 m/9NkRZE/OnkzaXtqn/t4fj13D8olRz0Ww/kQcjgKL5Dtco6zIS5g9aJUy8nhnnQ+Hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fYgvQmL3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.5
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0246606A32C
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 04:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0246606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fYgvQmL3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxsT2ZHavdNQ8CS7Xlt5MBVRMufQSgB+ECTGNyGeYzPnWp0VTh6PpxCHM9gjq/RmPlVAQQb3b9OGHCVpzSvMYOcyrZkcY1GZC0ftY3xwlZhkbxdBQcbF9k/ZIO4II3ViHAtV9Zj6lfvSsgyBFDo46yo0gHF43APXmuwOup88IbeX41zSSQqvjlAbVeyQNonrz5A/8W881dz7m1QdAwZYEXrDyJJ9hpYfNFwrqsAxulddLxAUiIGH8jbn5aVkMe+DXbyamfVNPm0wzetovGLiQ/iU2Xq+5tHGj0x6RktavseIPKGJesNfiSxRg7VU8afUhOlMN89XfF10DyyUOQAw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itof7wfZAYob52Z0+7HkXZnimQA+WRggSG5k4EbxK3E=;
 b=jyvdiw9Cj40iMFz1NbJhPV+h/WJQKqkVcGWYM+zHvrrCEbxsJKCEqDb8Fvj4qYmz8vc+1/lWX6dbJULGO4fCLSB5OEO1LwOrekzZeKd9BmlHkbYBOWukGpJW0yAl0oMOznuFIgnk/SElNraZJiW2l1wMpJ81+n6lAa4bvL32Jmgkp6p7wOEIHSKqesuupgXRFXiq4SanMrckmVNfGwad2EweROPmP0CV/YbuNGfg3r+Ywirg4/5wRBdN962OdbN9ZysfyUHfpyPLaQeBH7xD0WIc1P82W1H4ag5ikdYKL+6fF9b5yZjJU+neKHT3MziFq/QuhRc8RwPXMzkbv0Gjgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itof7wfZAYob52Z0+7HkXZnimQA+WRggSG5k4EbxK3E=;
 b=fYgvQmL3TtvLwSYgiiWdwIenbamPMnMZfu+prpfCzF0UPMjRIms7c1t054x7PPa21MQJ3uBs4FRGMt1Gq5Yx3Bp/dhK6gQR9gA6iY9iy3AL8j/VjHD71v0hEsIa/hmn/jiC0Jo9vC+bcC/0zBhOh10icJTFQP29SF9sEMF/SvvWlWsko+hwtKKa5Ls5cSRZ6qAP6Ac2Lx/gnEhC/H5qUR/SSxbH8wqT1LqspspsKPELFb5JBd7XiYB2mftfRZO9nc508X6c1qd3ruWHBuL2QReRNZzhjFgA8hTkeqId3rc4FOPHeWhM5HrIWA/C1fJq17xRiotE9s30Zmzon1vlm3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY0PR12MB825472.namprd12.prod.outlook.com (2603:10b6:930:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:16:06 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:16:06 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>,
	David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] sched/numa: Notify the scheduling class of preferred node changes
Date: Tue, 27 Oct 2026 05:13:32 +0100
Message-ID: <20261027041536.3317971-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027041536.3317971-1-arighi@nvidia.com>
References: <20261027041536.3317971-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY0PR12MB825472:EE_
X-MS-Office365-Filtering-Correlation-Id: acc49aa3-ef22-4302-cf9c-08df33e10543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261021123027099003|261021121427099003|261022075727099003|3023799007|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	uAw9LBL1ZYERJSpvbQ8KpukGf064tWJJNE30RkGOfNvSBvw4x6I38/1rM+nZK8iv24BhviRpj2q99Nymn/9/ywmBIjGT9/IuiLt5+xNitCvraTNM1EEy/mkDETbIYuhD8zCC2reySA9L9Bdvy0nXSQjc8cHDOh169ukh8Obh2FTa3eQXxucyzAQ7cCO21woQE9htgh02dMROI7iXIRbOo+kAhIsLMa3AmCR1/NE7ZRu7Hld7kpx7KOJb/sZVKGxd5n7kxKgZFJiQzI1fA/qHMsGzf+7wAFE+ftwHhC8rZLcm0sxiqFGtI6M95H2VhNzRUwLTC2jdUr72pQo6FgwD/dMWXE0yVtXdNSm54yJPa+axsJK1WRlhrHCe65y6rgE+L+Qgen3NBSis0qdyatIrWTgP4YvtPbgBTxLWQJvYoogW337hRBB7KkpSHMzFGPagZUjIhMskAORdoFJhULkAjWSj9udJzWxA6yWpwmA2Du3CP//Hu2sT3bdsuqXlfsVOqPdneCuYjl8OTA6tIexP3jKs1YiqcCWv9azbgTOFHq31eWR8fEGjovgIXmUjJA7eDxs/O+ktwNMzqlwKL9PDAnQLjRQf/7TNbXsFMeIsvcceKmpERhbl9Um3pf/9JmOobcLuu/NZmeyEAdiVmpv3D6cJ2Ha3mUJC7sn5SHqZGgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261021123027099003)(261021121427099003)(261022075727099003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfp7QxaBYaN0j6/VNZjwouLdlAzleYOKHuijxTsTdrN8aZUgzdgXYVdSaFCH?=
 =?us-ascii?Q?Th8Nmasvvb7BVKBhOw2WGFKO6pFPjcfrWiYfhOqld5SOILZB2FPTBi23nohQ?=
 =?us-ascii?Q?x3WErGm4p+G6CBzqQb00IyPvox2Ey0+wSHCKKQdc41EdjEYlLWAGt5Jfg6Fa?=
 =?us-ascii?Q?ekYgyES1VEU7w2LeGvRRCWAmwL+U/cooR4MNzgFvIEToA9UT1Y+PkhksLiFq?=
 =?us-ascii?Q?WkUh2+ji7uAqqXktir/s3OtWcNDot/MmOiWtUQ5+Fx5IyEehGIgoPB5kE7Eq?=
 =?us-ascii?Q?mNcXBKGM3Lg1jlT1temRsDzeO5Zb37p91Hne0CP7LsvvnNlBytN1lD6YnM02?=
 =?us-ascii?Q?YNYQs8ZRqlaOdRdquAEUTI91KXzGf2LzhWM18m3U2PylAh+5WB3Se233setu?=
 =?us-ascii?Q?qUf+rwNcv0mQaLJ8AbxOn2kx/LwMHYynCMxwssntIzkjt9EQCGms/Bk07gNR?=
 =?us-ascii?Q?bfbcnM8DS0TTW/mOtNGVGmnPDBO/OZ0Fbcit2CAGTO2j7Bds7jSPTAc4+7Z9?=
 =?us-ascii?Q?UgbB092VaBjhkY2LET6CIYhyNWI4TXJDFPDQBVz7fyaIhuC8png0lbIO6+Gx?=
 =?us-ascii?Q?EsbEOm8ut1OHU4wkd5C5Xb+rQU4oLTV7Y6iKZOGUzkveqSUJmJfJi4kybFhr?=
 =?us-ascii?Q?rbAMrGJQJWW7WbcT5q/4l68akjeoK0kHV9F8dTIPK7LGhyV+7SJv3SEYsOW4?=
 =?us-ascii?Q?3mh0m0Bk8FzjKukakYMLdUcuIpSFHf6svbmoikYYtoOin71L97tlodwmHuzj?=
 =?us-ascii?Q?CZiM4wF7efP9n4ac6dYPI+bu8u/QlnrByXg3euJ30eHEUkBM9GlF5K2+2cxC?=
 =?us-ascii?Q?ekDEAnSg7CK7fuOlVSWPDbvh39tuTqXBh6YK+rqhx47Gze+sBPSH9nhWzyTP?=
 =?us-ascii?Q?+pC0mHN6I23jTpOZxKyZVBD7jw5nrURGXJNTKD7CxjlzXaUaLeNReOUfdT31?=
 =?us-ascii?Q?vNHbd4tfhc8s3IlfVr0MXRG+PXih8400oXcx5TB55ncRDZdl0w8LFwROJCOM?=
 =?us-ascii?Q?yjUGqIV2UZ9plagObe7JWY7uIajHFt1BaUXOQ+NgqzT+F7LD5nj9R3LvRrQZ?=
 =?us-ascii?Q?XXRgbvSVsX+nTxK+kQD6oGcPvs2KN+nDqmGRyrpBIB8dkuTVQW17g+NMfCFB?=
 =?us-ascii?Q?XuWR6fMj4zyRzk2PXehbO1gVZ6hfbkN8eVbGTrbT1BQo1H6VtTHdic79Lw2u?=
 =?us-ascii?Q?0fppB0scxEr/DrSs5tczqKSIyBn6o1FdBfpQrnIcozs9/dctYIv0MO9iCjbo?=
 =?us-ascii?Q?o//jkBsULB6EFj8XaiPMXSVR6SDHk3wRYyR7xIhZji2MG48tuAZ/zXv8jf6X?=
 =?us-ascii?Q?zcw67CJM8Nk/EsC22v6mk1Qj0sBFZdmpG3Ft9/0spv3jvShFZDeLDjKzKnpA?=
 =?us-ascii?Q?ye3p6lVaorePWv3Lxo+Ws3Jg8iuU0eGPaSVXtC0aQcZAh8LJpCiFdptFA7Xt?=
 =?us-ascii?Q?T/SdI6q6iMl+iSsLxRtpu8SX/zGjW0WwEQsgwI6B1wJ+8H656ssFZDgTBBbH?=
 =?us-ascii?Q?RcDsj+DjmNzimWUABCrwCCQTAlhEzzvNEXUL6MkQE0yGvAtl2fkJT1dwS1SR?=
 =?us-ascii?Q?SslpmDhbw2/A0owp9SLWXkLilkDhfDQxnvLg1m3I0iyadry//6QpkQka4k7Y?=
 =?us-ascii?Q?d5TUDycmDHwI3Lb7RsCtSgcy21Iaa7zeb9CxjRsril0IyCTS+mfht5OnpU06?=
 =?us-ascii?Q?qfjde8Av7lbQLPNwJdpEJ/JBiH5VFc1NZSALnNRm1C3+eTy6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc49aa3-ef22-4302-cf9c-08df33e10543
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:16:06.0352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5zfQH5jrnNdPd9SgjXX6m9drV7dzmVO2tvlR+titZYw0y9qMmxFe7Y73F9URjqj0ZLweKvc327d81nAYKcrSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB825472

sched_setnuma() updates p->numa_preferred_nid under the task's rq lock
and within a sched_change section, but the task's scheduling class has
no way to learn about the new preference other than polling the field.

Add an optional sched_class->numa_node_changed() method, called from
sched_setnuma() when the preferred node actually changes, after the new
value is stored and before the task is re-enqueued. This lets a class
that keeps its own placement state (e.g., sched_ext) react to the change
without sched core having to know about any specific class.

No functional change: no class implements the method yet.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 7 ++++++-
 kernel/sched/sched.h | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2f46922982f32..542f28fd95603 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8331,8 +8331,13 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 void sched_setnuma(struct task_struct *p, int nid)
 {
 	guard(task_rq_lock)(p);
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, DEQUEUE_SAVE) {
+		bool changed = p->numa_preferred_nid != nid;
+
 		p->numa_preferred_nid = nid;
+		if (changed && p->sched_class->numa_node_changed)
+			p->sched_class->numa_node_changed(task_rq(p), p, nid);
+	}
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2b05c41e66e29..974f5df919aec 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2814,6 +2814,13 @@ struct sched_class {
 	void (*task_change_group)(struct task_struct *p);
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+	/*
+	 * sched_setnuma: task_rq_lock + sched_change
+	 */
+	void (*numa_node_changed)(struct rq *rq, struct task_struct *p, int nid);
+#endif
+
 #ifdef CONFIG_SCHED_CORE
 	/*
 	 * pick_next_task: rq->lock
-- 
2.56.0

