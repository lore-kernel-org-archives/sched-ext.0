Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B09288510
	for <sched-ext@lists.linux.dev>; Wed, 22 Oct 2025 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125926; cv=fail; b=dq1IMGMgSKlHsVcnZNEkwB27OiPivevgwg3461UHf1/sdyPQdwSwFihK0BUe2OJfuCJC7rYip2LSAAe0Fc74n23zgBjEgRm28j6OR2tLZS5YkYC9ICj9DfpeKI8VrgtKnfT++c/ud8h78VKQh2N0CYKe9IvZjqZrftMhLZCJDUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125926; c=relaxed/simple;
	bh=cWiTUSlV7gBwiyA/fHlw1fwDRse9OLEgF+nS7djGsP4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LZWKBRWCmy5j603nVuuSXujZ3CFv7hQs76wC7Jc30+Oo4lCZ1kH3QZzXmFLhevsbgO8ILpLadpjXen0heOUWbT9izsS1VYRGdB0EoDeS/wU3o55qaF/LicvYo3AHU80oIQqOGdeAiVYjcdxrRASIhcfz9Fx8234I2BpOqKV1aC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J8UUUixv; arc=fail smtp.client-ip=52.101.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J8UUUixv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGkm6sLb7yG1xWWPRpPl5UwdIFWGX4LCpBdDDalDCNOPubJ76KZNLuNtunkaNyT/wbf7Cdav3S+zbydRIVFfp+pKd3epW91R9QEP3CFlIN6aaw5QB924JZ6i3/TzatF1F7+//G8qZoVE32LbwVIJEdaerkThioCK5er0gEMX/lfVkd7JKrFz68T2bNLUorcsJQSwCakjWO7+gMyIQmdAb5TxgqseC/e5PkA63+Vczn2UurQP4TFbgk2NOb6CxqAsNn1ENHFdaUR37xiwSreX+1lTPxSHMAHEwXbeOMGy3UJDeaN4mTktD1lwcFyg3dq/L8HblnmpyeOp586+yJI7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79l0pDXnC5JmTYWSEOdo+u3S+4U433Mbq+RP6zH1HrE=;
 b=Y37xHIxYhcV6IejRE7vJB6FMsqVkeMtuzXQjQsgVb8+Ic8Rjv79sYdK+rMLjbzDPC+8+ISXftd1CDQLoAhF/Bvc03lnnCDxxquqvDwVxm+iRsn1imGYMLlb2hbJHhH4IU138UUa1bm2opgg6x07vDtLub/SIO05DtpkfvrBql/ShOo1dNtxlunyGZXtXNYdE2ApY239x2SybxYAXdxsIBVTu1aE0rgUXzEznHkZJLFv+Q/hMq3/WJ6FHWu+pEPKz1x+RqTvXEBqFCaouz2bwODC1WVsuZVts4H17L9mVYZpHoj4dmDVBo0uEZ03q8aoZwrHutbqSw+rhNNlI1KxRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79l0pDXnC5JmTYWSEOdo+u3S+4U433Mbq+RP6zH1HrE=;
 b=J8UUUixvYchBlthd04riIMumSksHKoZtf+CucqbC2zRWyopzdZZu0K0Re6vCdDSvj9G36xiVbc0uNXaCphAYlzrQekQ6zo30khN2x4Q10096treOSv+sZoSmAhNkbe6kFYWzM0/r4xUgdBzR5me0XTaTFX8TpP/XK8LyyVCQNQlbBifKbmlENOgytlLZVlJ/QJbQST3P8X50GDDzYa4P8CtjRASgs3xnybivhDi85KOhYJA7Z/Nw/zO6By9B40wXaX76M8WKrlOmselr0RJuWJunzl/O0EKQY9xp08zvMm5rRxyqcss0Aq9LAElutiJfxQsJZpf9sATjMzPO7nvv/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 09:38:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 09:38:36 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19] sched_ext: Use ___v2 suffix for new kfuncs and fix scx build errors
Date: Wed, 22 Oct 2025 11:38:26 +0200
Message-ID: <20251022093826.113508-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e3e060-21e1-4207-7546-08de114ec625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TjAZm68Uqv9GAOxbuGYZAltSyZ961aOR83r8XDCgHcnd/hSzcU3bNqnM2DTA?=
 =?us-ascii?Q?S8TjV/ctA+WlBjGsdPtTvJUF01pdvUfNFKXnroBBMo6/ow1vJWqWbbgAHyCS?=
 =?us-ascii?Q?W3YUofBqKwfjUNnI+N1J19WueSCDIRP24hIhDX/toq0CXPkVHtM5OBDwLe22?=
 =?us-ascii?Q?oqNP+phszU0atV85uPoHMrDN5B6DzJtL4onz5QUpKLtrb8FyCDPRPLRSfrvz?=
 =?us-ascii?Q?7IFvfw7GNEI3d+0mTDxJNeXogJGFhvotxvenMd7ILwZG6Mp4JZFmi7xq5Sbh?=
 =?us-ascii?Q?qj8jpaqy3ylWiDF0FHsU1Pxph+n4iJlmFlswx7rALw1TBcmdszwvrU0RRF9+?=
 =?us-ascii?Q?bAXDaZvbqe1vixAMk8odIF1RM1Iv9J0MBUGKdmqD1OzScelSbiKuy+kojWlM?=
 =?us-ascii?Q?WMhxhQCUKlDOF5yxVAfNtzT0eJ0IDCyFeyppZ53n3JXhi3qXd+4Hbj6UpgyY?=
 =?us-ascii?Q?3f1hVPpFWojSd2BFZaaAeQrltHVzII0xpAqBho6Zp3/RYMCs0QgiWbm4BLIM?=
 =?us-ascii?Q?fMpE6+0/GwNj1K3QI724M9R3Bg5Fk6M1TQ5VZqeHSnZrCoVmTNDWnXR77hPn?=
 =?us-ascii?Q?AZj4idT0xOzXHjjFvVK1UfDtwD1qcYo0ReI/p0x6p0KQUsvn9Y35UjW5zX34?=
 =?us-ascii?Q?re4MHboDGv0SJ5SNgUUYBHMrWXc8eq+xuDHMks7KGPUQ5GjO+EJUY6EYEWp3?=
 =?us-ascii?Q?O4X5tTxAenZQoJGyaOdyet3YVSRgI3H57g/hTfdJxevU7CVHxA5zQwLStxF4?=
 =?us-ascii?Q?1J0g9LxCQuIWdLiTklsxe+0m3vBnQ5/uL3v37jhr/izhOuHIUCiBGt8Uu9V5?=
 =?us-ascii?Q?3TGRU9lzpzGzXm6gm85aJBtlDREniysXDBjl9Coo4MPZdSq/X4EWmf/za2m8?=
 =?us-ascii?Q?9UwIt3QT+8I4LwbjXNuDjSNB330XOabvxleaQERSec/xsKJmxIytoWgLe/5H?=
 =?us-ascii?Q?zM+8s8CrPd/oHosn0jKK7jovOB33cCR0NBMXGfiPX73FYsWlyHX5ciavpQpf?=
 =?us-ascii?Q?mPZHoaHMz3NoZzP5VWe5sXeXhge4RIO9MForoEjYyO/SNIBcwlcUKEqjC47C?=
 =?us-ascii?Q?n/IU+aLWhpefycGhT4M5yKPiaKkxUjhA7u/BVzcu1jUvTWGpMduXIyGjhFwc?=
 =?us-ascii?Q?QjilcryQ1rvFHpmnFCiT4shFZePN0Tih9gYd50v6M3z7H5tuSs1A6bv4hUMA?=
 =?us-ascii?Q?teaEYxutGQm1TTAgODNfxd3l3B2vn5Hka7ooGMU1XRkA5tI9ICg/9RSE7hHF?=
 =?us-ascii?Q?YakPubKenwoK5e+t/35P1/rt+os+k+BY32HP1a9sGJrcOdAheyKIOiIFydZP?=
 =?us-ascii?Q?5FmkC6rhE9qUDk7lWegAeZ5GRPlDyoICYjMc/WtsEVMn5tB/6+owwYCfLOlt?=
 =?us-ascii?Q?Y/pwPJC8LlNMIi5uzsdb3kv99VCBxCQS4q3ZMSkhPRfyvUpLfdD8B5jS2mdI?=
 =?us-ascii?Q?tgrPeOi2w/f4Tna8cEEPfL7dTUMOsY4r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkOK75nQxNG7GQ6XOBtJwscBkXI8TymhiMMkTHOuPAcO9RX6Ef42XnBjM0i3?=
 =?us-ascii?Q?FMU5riHJaJl4kOzdGKM6yrhUpEnBf+5dqwOfzJgSazTNb8T1C6Y310SkVt3K?=
 =?us-ascii?Q?5aXQRh8P1+IyuAZdJNLHtVaszIG4QnG4Hvk8e4quGDyg7Kh0HQtBW0YZNwft?=
 =?us-ascii?Q?0wLhmhU1Sn9MsFlO0eOkogd7omZA89bUkNd2w6yXswG7wT9duOVBFXXbHjnJ?=
 =?us-ascii?Q?EOlOBEhwV1eXnrMYpOk52bzSqgkDJzkto0W32QKSVYEvo2Y5Ni84cVDIsmEb?=
 =?us-ascii?Q?MkzpvIr7u7skwv65NPDqhMKENgVQyfpc3ALroHTkGK+HbBtQY4SJMk2n7gSj?=
 =?us-ascii?Q?D+48B5XC/84PpMxC9OrsmzE2Fb5JNPkJPJ7cDxPP+pWwOCHNJxGoNouLyelm?=
 =?us-ascii?Q?8uK5qLn9IyM/Ta70IvGhZyfIHGtoT9rg8MoTmFpoRVJJjWiqBBLAMd1ZvcQV?=
 =?us-ascii?Q?epgRU5t4PVD4AkrjNOIpH/RFbKWlUhZfrfRSaGOEO+GR2cldvQgIb1ej4ZuQ?=
 =?us-ascii?Q?8wswuhD0vkdVxgtTV509T/HooeCdRfe6vY3xYRbr/auMPCR1IYlsn4r9PkH3?=
 =?us-ascii?Q?x5wm7/l8cFZnydPNk3O9UoL0QK8E8pmiT17fv8Z6q8KuqGk+vYDVLya7V2J6?=
 =?us-ascii?Q?baBoDwH16OTlHX0FDbCTtJXdMq7Jv0/aqsgne8BmR5ts+5SvZO6WifwrTbSy?=
 =?us-ascii?Q?/e3dONlP8JHDKb33b5P4fQQ/grJNUHwWVPlAVkj5ixdgfF7u62cMTPaHAFzO?=
 =?us-ascii?Q?sv6JsjEk1Yny6o2g62Y0AMfvoOOi7WWzmZ6cYDUruvFQzaYKwPGC1ZxoBhA6?=
 =?us-ascii?Q?nwTtfaUf7/4FO1wNJuD+31ggyrE8U52a+/OUhzmPf3ahJSsBTNZleQS0Y1AU?=
 =?us-ascii?Q?KjNX18xTlunHMh29SA/qfWeEB6ZQ3Yw2J1aro0j2xUirnxTcdvgd2QR4gy/e?=
 =?us-ascii?Q?oXMt8MrXVIj7X1vEKKPQ/tgJnwD1+H4JjISN/MjUqN5mmEz1BocCozkYBoyn?=
 =?us-ascii?Q?Fii+mvDC1Znq0XL2/eEhpVgaesAtTpHQPY6pYzNRfPDOyg1EroQj+BXK4/5r?=
 =?us-ascii?Q?xXWA+g1gwCUh6jiHDtMyyo9GGbxaoGfEU+MWB5hZljtOWoI9uzdK+t9nZy05?=
 =?us-ascii?Q?kk9k1mc5uHPkSSC9VG7MzEH3dzYRAIvkikuemIbE5zo1WUhPSVYtQ6rRtusK?=
 =?us-ascii?Q?MdAGvtnkghELX9AJnjYfIokT0W+H+lenT683du2ScMgmAVmBkVOPHV74BWus?=
 =?us-ascii?Q?Vu4WNTmP/GPMym10ZrOQJ0GA+aNlBGGjw+21Xc61XRwGZbXRPl+EbEi5h8Vb?=
 =?us-ascii?Q?092H/Z+pcXmFd0SQdXDP75ecIvE4izyF27aEKXJCu9VDrS5B1kawEmts/J3A?=
 =?us-ascii?Q?wSWPVxdg+m2rjWH3B5uGqX6PlSAG9o2y8KLeVZJ4CFmXmMW8sPufrtIa+4ur?=
 =?us-ascii?Q?wR1OM4IKTNh+HuSJOMp+ZDkYtZ9kX/IJdpg1AiiiH07aylifJxihuodJuZWT?=
 =?us-ascii?Q?36sciVluiR8fsqaQXXuPBaiYfFExCZrvy5QqxL6kT40/iyeVAsQcU6kAkgmY?=
 =?us-ascii?Q?f20S0pir76c+/irBKcvLknDpAOVMJoLbtfCs6BPH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e3e060-21e1-4207-7546-08de114ec625
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 09:38:36.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ul9CbvCFbUnBYl3rnd0GO6Ok8df8EzItPIkAZF2yKabkKdHP/IX9odywTs4DEvEoY05RPrsI11ZakA5fd39y6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765

Following commit 2dbbdeda77a61 ("sched_ext: Fix scx_bpf_dsq_insert()
backward binary compatibility"), consistently use the ___v2 suffix also
to the new scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and()
kfuncs.

Introduce __COMPAT_scx_bpf_select_cpu_and() and
__COMPAT_scx_bpf_dsq_insert_vtime(), to ensure schedulers can transition
smoothly to the updated interfaces, and temporarily mirror the
definitions of struct scx_bpf_select_cpu_and_args and struct
scx_bpf_dsq_insert_vtime_args to prevent build failures on kernels where
these structs are not yet defined.

Both the compatibility helpers and mirrored structs will be removed in
v6.23.

With these changes in place, all schedulers in the scx repository build
and run correctly with the updated headers.

Fixes: c0d630ba347c7 ("sched_ext: Wrap kfunc args in struct to prepare for aux__prog")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       | 10 ++--
 kernel/sched/ext_idle.c                  | 10 ++--
 tools/sched_ext/include/scx/common.bpf.h |  3 --
 tools/sched_ext/include/scx/compat.bpf.h | 63 +++++++++++++++++-------
 4 files changed, 56 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index cb41365032ebc..8816d89426a6f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5490,7 +5490,7 @@ struct scx_bpf_dsq_insert_vtime_args {
 };
 
 /**
- * __scx_bpf_dsq_insert_vtime - Arg-wrapped vtime DSQ insertion
+ * scx_bpf_dsq_insert_vtime___v2 - Arg-wrapped vtime DSQ insertion
  * @p: task_struct to insert
  * @args: struct containing the rest of the arguments
  *       @args->dsq_id: DSQ to insert into
@@ -5520,8 +5520,8 @@ struct scx_bpf_dsq_insert_vtime_args {
  * to check the return value.
  */
 __bpf_kfunc bool
-__scx_bpf_dsq_insert_vtime(struct task_struct *p,
-			   struct scx_bpf_dsq_insert_vtime_args *args)
+scx_bpf_dsq_insert_vtime___v2(struct task_struct *p,
+			      struct scx_bpf_dsq_insert_vtime_args *args)
 {
 	struct scx_sched *sch;
 
@@ -5536,7 +5536,7 @@ __scx_bpf_dsq_insert_vtime(struct task_struct *p,
 }
 
 /*
- * COMPAT: Will be removed in v6.23.
+ * COMPAT: Will be removed in v6.23 along with the ___v2 suffix.
  */
 __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 					  u64 slice, u64 vtime, u64 enq_flags)
@@ -5557,7 +5557,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_RCU)
-BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime___v2, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 3d9d404d5cd20..d4b6b5a300345 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1003,7 +1003,7 @@ struct scx_bpf_select_cpu_and_args {
 };
 
 /**
- * __scx_bpf_select_cpu_and - Arg-wrapped CPU selection with cpumask
+ * scx_bpf_select_cpu_and___v2 - Arg-wrapped CPU selection with cpumask
  * @p: task_struct to select a CPU for
  * @cpus_allowed: cpumask of allowed CPUs
  * @args: struct containing the rest of the arguments
@@ -1027,8 +1027,8 @@ struct scx_bpf_select_cpu_and_args {
  * a negative value if no idle CPU is available.
  */
 __bpf_kfunc s32
-__scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
-			 struct scx_bpf_select_cpu_and_args *args)
+scx_bpf_select_cpu_and___v2(struct task_struct *p, const struct cpumask *cpus_allowed,
+			    struct scx_bpf_select_cpu_and_args *args)
 {
 	struct scx_sched *sch;
 
@@ -1043,7 +1043,7 @@ __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allow
 }
 
 /*
- * COMPAT: Will be removed in v6.22.
+ * COMPAT: Will be removed in v6.22 along with the ___v2 suffix.
  */
 __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 				       const struct cpumask *cpus_allowed, u64 flags)
@@ -1413,7 +1413,7 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
-BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and___v2, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_idle)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index e65b1eb668ea5..64e5411d04c04 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -60,9 +60,6 @@ static inline void ___vmlinux_h_sanity_check___(void)
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
-s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
-			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
-bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index a023b71991a6a..963ff3263c20b 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -161,6 +161,25 @@ static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
 	return rq ? rq->curr : NULL;
 }
 
+/*
+ * v6.19: Mirror the following _args structs, to prevent build errors in
+ * kernels that don't have these structs defined yet.
+ *
+ * The kernel will carry these mirrored structs until v6.23 (see below).
+ */
+struct scx_bpf_select_cpu_and_args {
+	s32			prev_cpu;
+	u64			wake_flags;
+	u64			flags;
+};
+
+struct scx_bpf_dsq_insert_vtime_args {
+	u64			dsq_id;
+	u64			slice;
+	u64			vtime;
+	u64			enq_flags;
+};
+
 /*
  * v6.19: To work around BPF maximum parameter limit, the following kfuncs are
  * replaced with variants that pack scalar arguments in a struct. Wrappers are
@@ -170,12 +189,20 @@ static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
  * compatibility. After v6.23 release, remove the compat handling and move the
  * wrappers to common.bpf.h.
  */
-s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-				    const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
-void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
+s32 scx_bpf_select_cpu_and___v2(struct task_struct *p, const struct cpumask *cpus_allowed,
+			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
+
+s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
+
+bool scx_bpf_dsq_insert_vtime___v2(struct task_struct *p,
+				   struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
+
+void scx_bpf_dsq_insert_vtime(struct task_struct *p,
+			      u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 
 /**
- * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
+ * __COMPAT_scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
  * @p: task_struct to select a CPU for
  * @prev_cpu: CPU @p was on previously
  * @wake_flags: %SCX_WAKE_* flags
@@ -183,11 +210,12 @@ void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id, u64 sl
  * @flags: %SCX_PICK_IDLE* flags
  *
  * Inline wrapper that packs scalar arguments into a struct and calls
- * __scx_bpf_select_cpu_and(). See __scx_bpf_select_cpu_and() for details.
+ * scx_bpf_select_cpu_and___v2(). See scx_bpf_select_cpu_and___v2() for
+ * details.
  */
 static inline s32
-scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-		       const struct cpumask *cpus_allowed, u64 flags)
+__COMPAT_scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+				const struct cpumask *cpus_allowed, u64 flags)
 {
 	if (bpf_core_type_exists(struct scx_bpf_select_cpu_and_args)) {
 		struct scx_bpf_select_cpu_and_args args = {
@@ -196,15 +224,16 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 			.flags = flags,
 		};
 
-		return __scx_bpf_select_cpu_and(p, cpus_allowed, &args);
+		return scx_bpf_select_cpu_and___v2(p, cpus_allowed, &args);
 	} else {
-		return scx_bpf_select_cpu_and___compat(p, prev_cpu, wake_flags,
-						       cpus_allowed, flags);
+		return scx_bpf_select_cpu_and(p, prev_cpu, wake_flags,
+					      cpus_allowed, flags);
 	}
 }
 
 /**
- * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queue of a DSQ
+ * __COMPAT_scx_bpf_dsq_insert_vtime - Insert a task into the vtime
+ *				       priority queue of a DSQ
  * @p: task_struct to insert
  * @dsq_id: DSQ to insert into
  * @slice: duration @p can run for in nsecs, 0 to keep the current value
@@ -212,11 +241,12 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
  * @enq_flags: SCX_ENQ_*
  *
  * Inline wrapper that packs scalar arguments into a struct and calls
- * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for details.
+ * scx_bpf_dsq_insert_vtime___v2(). See scx_bpf_dsq_insert_vtime___v2() for
+ * details.
  */
 static inline bool
-scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime,
-			 u64 enq_flags)
+__COMPAT_scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime,
+				  u64 enq_flags)
 {
 	if (bpf_core_type_exists(struct scx_bpf_dsq_insert_vtime_args)) {
 		struct scx_bpf_dsq_insert_vtime_args args = {
@@ -226,10 +256,9 @@ scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime
 			.enq_flags = enq_flags,
 		};
 
-		return __scx_bpf_dsq_insert_vtime(p, &args);
+		return scx_bpf_dsq_insert_vtime___v2(p, &args);
 	} else {
-		scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime,
-						  enq_flags);
+		scx_bpf_dsq_insert_vtime(p, dsq_id, slice, vtime, enq_flags);
 		return true;
 	}
 }
-- 
2.51.1

