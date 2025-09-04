Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909F30CDAA
	for <sched-ext@lists.linux.dev>; Thu,  4 Sep 2025 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010238; cv=fail; b=LsP858jzhOjEvGf/tm1hzHISuYDf2VPTyC8oG1oaMV0g6tSlLcX1217Dk7vqdySppA2RvjUFhOIwAPskZ1aLaKA10hXZHY82WYTx9bUW23AY9tC9TD6QGKZOa2CyaBAESmfyPLtxRbPV3bbJQN9EdYJyYC9p9Vc3h8zGAlNllwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010238; c=relaxed/simple;
	bh=E3auvT9d6CCL0issofJ1/UsUylcm3asn3RI3RrMlgLM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C/ORxbzcj12uJeaPq+E6MVjkLdoYu45S0ye//UA2/WMjar+0bLmCofBtVhQmRobsIHmyEsrQkH+zn+CXlnEhGPCUfNaqo64dsx/0v8gv0GjSXeWairqEFA7uP2W+FIEXIhJ5renQEsbiG9YBOEsZDoi30E7vhBGI38XQSPe5E/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gOBQeyTB; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gOBQeyTB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLReoDKe9kMMvrgkM3qWDKmhH3ZtbI3zNwnkdjs2nMKgteYeHLYkZDE/KWzJnF/jupp10yInhlEEe3nWWiaY4IIebtZCmksO9PhclbjO7agPBfAgk+OAhGdluPgnCMN99FbbczJeDhMJweT96z/ck11XYw0MKtxTIIzZ0VlRrWGW72NNfGcEUSR4xqag4HUdC8Y1UMjIdbcrxrwlX2OA+CKlCDHJh3G77AKEvuxx/IKry+rXOKOON+yUczSZgs66fDPZ+1iaJZy5HbI6zPq0zpkSRyTtx1UNsHSCYI4CWM03LMI1aYlQD+TX8YoCxO2DAxakHN/PU1EEHBZOOyG9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N80vT8OnXYZz035xo1Z9kfnwiWhjJo4909Vr6slvN60=;
 b=GWKhv17JIcnJbiFMQ+UDqqTGMltdrdmYKSFOfOLwGezEuCDkPiXtxLjIuIEceQYQBdwxZNfBN93I7hgzoKbj8+A2VghfIZFa7DGFfOJrl2pZvTBAcRG8mihi9IJJP0yk6uC0uP9+jRA1niTvtsSiI6CWcHdEybjc+zAmtemk9fUzi8ekfHAquLkLGEnkWVvOJFYw2wtqZDSxlmoa06ba9JY1MI9SI0yw/NryCaM7pQMm9mEGumSD+ReA1JhsCd4sJ8CicZyHtyONk1S61oLI+d8zdFyvQbRq/czAA9WV+eLmSxij73uRqDVt6ClNx92Aox/3gD9/z9j/lNCtOo/RPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N80vT8OnXYZz035xo1Z9kfnwiWhjJo4909Vr6slvN60=;
 b=gOBQeyTBK2ePkxf57OjgoqjU0sEIlTAxqxB42OxSgdVIXCWhHRdpAkZDRCClFzcTMh85+gBGbNG8Bljkm01uMRA8G5Zq6jSn/z+fv7gvZoZNtXxaTiiUFDLy/sGTJuRCvjtwtvX+jmo6BNmIt/RKQT6Yebwz8P2wheCcsqV1D6xvazpvAQJGJD868re/qwKUtxUD1ZoIkTFX39QDr60lVHGXbateVqSPwSMI74fB0GUmMS/9epD2vnw0tfZ1bsN7sx117wbtqYPCzEiUEwMvo33WtYqxfAVsJXVHEyuj7trmOpy2CVoxdUq8KoYWlqUF3cXX2/toQK25oz47L62T8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 18:23:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 18:23:50 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Jake Hillion <jakehillion@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-6.18] sched_ext: Fix NULL dereference in scx_bpf_cpu_rq() warning
Date: Thu,  4 Sep 2025 20:23:48 +0200
Message-ID: <20250904182348.107835-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df5ee58-b06e-47cd-e085-08ddebe03269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nAU2WkIQCOLYU9SylwRI6O34grZKs8brAIOcGRlQXwv3bd2opSyzhFEUN9FY?=
 =?us-ascii?Q?fdI639YJU73ohE1UHBuBXJs+Y006IxqxUeA9fHavxIIrtxwAaAL/HhDcjYVT?=
 =?us-ascii?Q?Ujwl0bw1Niyzg6eOtOaZ+DorMscBH/2XlXnNvfhjPvyCM7J3dKoaYYXditS4?=
 =?us-ascii?Q?K/L3rIt7C/FreGpaD2u6yuVnXEkDTKqYiuRfbymc4/qhJORUkm+Rzca+vqA8?=
 =?us-ascii?Q?vq4V/3M7ZftkFH5rDDlkkRSdlC0pEc/lvAhCAgP2P/cbzE0ZkIfEnpxRGCig?=
 =?us-ascii?Q?yvT1+kKNjEvnNo5YM5d4l2dFM7nsqTixmPHxAhFsgGrHj1n7G+3+dIrBdmAH?=
 =?us-ascii?Q?2ovILMUWHbySi1/J16Nmr8XyAJC+79f24Jqbo6Ty+OvZ3wTF1HIsWw1lb8Ef?=
 =?us-ascii?Q?ntKlU+oAyzi4NwrfqN7KyznqEaAWMe7jrO7zu/Q0tAW59d74U7EH8UkYIecR?=
 =?us-ascii?Q?L7+XFUh7bfIS3ZEI3Eu4vqUcy1fZdGJUHAnQgdzWStq283ZyvSO+wzIOlCEY?=
 =?us-ascii?Q?lCAy3DHqup3LBve/Uz024k8XrTher09VAoGrt9eBGDzbzpiSrVKARYw95Srx?=
 =?us-ascii?Q?AAs6ZX7Wh84HEbV44g3g4eraXjV3VxVeMLYxuYjvas6qPKi7PtQ0MpQIGa9H?=
 =?us-ascii?Q?P2ag0z2hGV/lTaA9Gw8DCGCrfNYp/MOQbrHtqurkZMp1WuZMqTBi7xqkV7h7?=
 =?us-ascii?Q?pUYv/VHEef9S1NJURX7HqHoLAlUVCOlgt9VG5w0OdLabWBF6vbg7reOrLMtB?=
 =?us-ascii?Q?FQiIPviUtcPRCGNrGVFjJFpe8K8o/pwpSd3MGsv1JCeCZ0PAkhQ/UMyNUF5n?=
 =?us-ascii?Q?qLtMIfFSXe/euqN+Zxda1909NWtwZA1lzdBbZs6Anw33WDow+CVsmxhmA48X?=
 =?us-ascii?Q?JlMN4LZF2AZxyvfhuAE5ZhWEEVyLJ5jAWRBD3NQW4JfHn0RkEEpjkLW88TwL?=
 =?us-ascii?Q?3HS6/+GPemk6rJQSaiJpDMoXRDIQYxz5f6D4ZW/2kKVr5ZUX1MfMQXlpZXLA?=
 =?us-ascii?Q?gyLnWyJVmnALIDi15djNf+prgDd/0FRa4QeqndIH8kpnJzGzUjvHx66tSAc3?=
 =?us-ascii?Q?gvBkzC/PHa1qWczLirdiJaQwHI0ulreTwnCWVkrOgqjjSNp0zVN0U9O9nnTx?=
 =?us-ascii?Q?h7evNi9CM9sDk4DwJxMrRgdVFtFVWLYx9IgvPEnaRIObd5HT8CKoc5SIzKd4?=
 =?us-ascii?Q?C9rcy3cRO/yrDjl+fiKmMPgvqGTgUKdllgow/Z9wgzW5K68GjMmyFRT54yJY?=
 =?us-ascii?Q?OMId4uu1kUh8G2rpBnacwYFOCx8i8wvdmpgEXKRIv+MdISrF2Cq2mRoZ2YzJ?=
 =?us-ascii?Q?XTkZpEAXZyLQmh6NyGux8PNgdaBbc6gBRZ0mQ7L4oiWK49S/bAoVDuyuFlhl?=
 =?us-ascii?Q?nhzRXYg6sHcyAi+Cfq2YYbZHBFiC/okKTYQP/HQ6OMgjr/QqJIHGu0mesvJE?=
 =?us-ascii?Q?b09GOxHceXE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BM7RQQ545KCmatc22fLmUWX5j+ZP0IdE0Q5BZjuAQi1nQTR29NGQLewWJlYU?=
 =?us-ascii?Q?NPL6GQn+0Ez7wnb0W8ncS2PXEJSYcIr+Au6PwM1j//lVmxiEkywoCld4mb9r?=
 =?us-ascii?Q?/T7dQ9KEyH7sWowFZmQVDKjcj2aW1XpMzXVfOZKV71cjNV7/dg4qgbNBPT0u?=
 =?us-ascii?Q?L994DnEfN/rRfqXzPnQig5MQVrxyfBVLQdkgag2Yrfwjq7je0zlqKqnb+lum?=
 =?us-ascii?Q?6HQP9xjqvsDk8ryoTWG0eFkTaaWjC7ILkP9utJt6ylA2+TOCcoc9n1X5RINE?=
 =?us-ascii?Q?iQ/rriFEpQCj9Xu8uLTnIl27Sur5ZSN9fa2oC/6KeLA80O47EDUD9oi/VOGC?=
 =?us-ascii?Q?6Iq1rfBi46u9SNZZWVgCLzWaNntj9OPs7kNMsVw+R9IbO5VNbexKb6KLRJKO?=
 =?us-ascii?Q?5yKtUCT+lpArYndTwGHxqDvQHlpE2+eeDLSxzstCGTaD1fM1tK9X70fWnzbx?=
 =?us-ascii?Q?nIkS7RJQGQME9YNYdSlXoJYvPhkWiPKXRibKPuZAp2G+TOzynvr2+GsAFb3+?=
 =?us-ascii?Q?S13tgWneOIwHaW0qcZk/Gbh05vmGnzI1wY0I1GQ4t6a9JUIuhM+ahToNZ8EF?=
 =?us-ascii?Q?njQ6AVWeDXPdKovJ6abRaTnJbeNrHNNXSvNOeRxt2RymxZoyCD5qhjQBo7e8?=
 =?us-ascii?Q?5pR4ww/5MXhgQkPbeFcp5ov6hTmQmbCeQqELoQdYvo22eAlb1nyEVCpIWgyM?=
 =?us-ascii?Q?IAz7k2cc7rCglu31wo0J23cCj0BQqwHcSFi0IWVGL1lAyIHS0m7B5nXeqnI0?=
 =?us-ascii?Q?D/2Ncat1z1iuQ7uX+wGEeIrbi1KxnQ9/V11dlwEcGmBjnWys/jT+JX6w2L4c?=
 =?us-ascii?Q?b21Kiza8ZCuAovP2wzc5PVFhHDsXUgsnb78mAVXCK7znuoyrFXy+IG3tnHjX?=
 =?us-ascii?Q?tQGV5SbZGudO9T4hakgbw5Y80ys/IKeqNwztfOAEGWRMN0ntvXEVHpmcBlhO?=
 =?us-ascii?Q?RSU1/JgwUZLFwYJ4liRZxYg7DMKgfuvoualz0PnoTatEjApsYdgE0dEOiqMO?=
 =?us-ascii?Q?1Z5Tlp6p/rxNrXHMljZKHQvNljqbBJaK/b4GCyEydCXcGCIhF4hj2b0h4SgE?=
 =?us-ascii?Q?Bpr7Dd5ze8pRmKnjJDILaG5NiEjm96KgHjLg2y1AX4c18i0O3uoxZ6SjrPTy?=
 =?us-ascii?Q?4b4vTjl0UM+Mhdx6+MyFGUjLPGu1BPVynY7vC9jasXvV5wZaV3EGozrdZtK4?=
 =?us-ascii?Q?ZupSnOVK+pgnz0hTf+bKaG7B+SMVAIM5CzDey4SkutJFoPaugrCEbTzibVft?=
 =?us-ascii?Q?hkIdpBCnuerfKDjd1zYgQoSBU+TJf61QVDqekEUAdyJL70K4bLo4YRgDsZ8O?=
 =?us-ascii?Q?sSco34n50dYOcVCjY1JOIsUmT7o6hehKJWw/yzm1qepFQ3Gu67QUItDCDvQ+?=
 =?us-ascii?Q?4vw09u2+fI0bYaacJbk/31BN93Q77jfXO4ks1fbe9D8LCqfxKFBGcppcH10F?=
 =?us-ascii?Q?2yXg0wWd+Y/mIwvJGc0seFmBKXgUyQzwrs2uPeSXKvhxQZj4wbS8VaakA57Y?=
 =?us-ascii?Q?ZD8NafgPkG37KDBxoUS6DRCZYbqcRos7n6MOvGsNp/ho5cyD1lrjyR9a8ycl?=
 =?us-ascii?Q?YumHl2DxamMYVYfhtGKDvKZ0hjxA2TfEV+RoF9wC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df5ee58-b06e-47cd-e085-08ddebe03269
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 18:23:50.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIpXYp/OswgujSdjM5BouqTCoqqX5M2CDK8r8SKtX3P4YRYRh35AIYpnP+h1NJN0PttpCFi/bhWHmoeTzqbfsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954

When printing the deprecation warning for scx_bpf_cpu_rq(), we may hit a
NULL pointer dereference if the kfunc is called before a BPF scheduler
is fully attached, for example, when invoked from a BPF timer or during
ops.init():

 [   50.752775] BUG: kernel NULL pointer dereference, address: 0000000000000331
 ...
 [   50.764205] RIP: 0010:scx_bpf_cpu_rq+0x30/0xa0
 ...
 [   50.787661] Call Trace:
 [   50.788398]  <TASK>
 [   50.789061]  bpf_prog_08f7fd2dcb187aaf_wakeup_timerfn+0x75/0x1a8
 [   50.792477]  bpf_timer_cb+0x7e/0x140
 [   50.796003]  hrtimer_run_softirq+0x91/0xe0
 [   50.796952]  handle_softirqs+0xce/0x3c0
 [   50.799087]  run_ksoftirqd+0x3e/0x70
 [   50.800197]  smpboot_thread_fn+0x133/0x290
 [   50.802320]  kthread+0x115/0x220
 [   50.804984]  ret_from_fork+0x17a/0x1d0
 [   50.806920]  ret_from_fork_asm+0x1a/0x30
 [   50.807799]  </TASK>

Fix this by only printing the warning once the scheduler is fully
registered.

Fixes: 5c48d88fe0049 ("sched_ext: deprecation warn for scx_bpf_cpu_rq()")
Cc: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Do not incorrectly flip the logic (thanks Tejun)
 - Add likely() around sch (suggested by Christian)
 - Link to v1: https://lore.kernel.org/all/20250904125522.561737-1-arighi@nvidia.com/

 kernel/sched/ext.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 489462290142a..3eb6be889da6d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6362,17 +6362,20 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
  */
 __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	if (!kf_cpu_valid(cpu, NULL))
 		return NULL;
 
-	if (!sch->warned_deprecated_rq) {
+	rcu_read_lock();
+	sch = rcu_dereference(scx_root);
+	if (likely(sch) && !sch->warned_deprecated_rq) {
 		printk_deferred(KERN_WARNING "sched_ext: %s() is deprecated; "
 				"use scx_bpf_locked_rq() when holding rq lock "
 				"or scx_bpf_cpu_curr() to read remote curr safely.\n", __func__);
 		sch->warned_deprecated_rq = true;
 	}
+	rcu_read_unlock();
 
 	return cpu_rq(cpu);
 }
-- 
2.51.0

