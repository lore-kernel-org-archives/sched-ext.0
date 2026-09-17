Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F740A937
	for <sched-ext@lists.linux.dev>; Thu, 17 Sep 2026 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628888; cv=fail; b=W20ohVwyc3lJ6uVUziZDMTxDuU6uIhFmlOTljPu2bf7LJ3XOKVnvcFzI71R6rRurK1dXL2inI4edCODxZhcfGHNjNBwAUQiKBqsO6p8gB0iVM7olvKSAaOj1RNr4o+5nggGdGrW7cDZRz9lrlh7EW9vgFuj3LrfWO3mqNYzL+1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628888; c=relaxed/simple;
	bh=CuoLwoLTpQOtma0ugsJmQIsDYBxG2QfKiL9VDnHxh3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sbuIi5zmcn/GoKugWkDzO4xni/J+1W2B18bpO8QyngZxXXabfGLEAbaobrzAICT40K/dOmK5ZHjilmv2WWWePAcdqY04EEL26MtV3Gch44VkAKdHtoIQB4tD4oOd9hI9mbPWekhAz0OMkrcBF7t28gCegvKgakHCZloImeZ7ROw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O7FqqITX; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7FqqITX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlC5kZI3YQ3z0Fhvk2exZxEAxj2Fh3RINDpij2r5Q5k3ymlPdGdkzY0+ndp3LdJw38+0to0cln+Qgbr0jPLv7woZOmMqBZM3VOb8uRbo6CLNm4ntoJimgypGY6Iqhz9O+WCWShLYHUoWjICOK4eT37+M5XbVu+9GNH0cNnnOanpSSr1TYadaAvFaEzCDIDfw2RTN4fVUeXDFbd+/f6bxwH60zm/WCMqzq+Cm/iRh3LUoAc2X4SCupBF2HnowRMW+HZBvGJQPynzszyHxHVLSoE110LTk0I9gKBMHBw8xAolGCw9IdPL4hcvSlIgBG2MxFihpW4eUJGqDqa2QkEbUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBOGkVeyJPInxBnbxblSXI8MwWaO2vLdD6cq+Yp97tY=;
 b=SgMADEf8kwOegMpdJ08rNdPIFondG3mJ5Jw/o+qhz5JPzBBlhFbW8lTfMNFbbUlkNQ5FmxB9o4g6vDUjgKvCF3QSpczACqIhai+0f9EJ6JKI8iFi7zsQ3q2GP//ug0xe4eOKYY6bwH9A6StUDBA/ZimIZrdO+d3xrl0+geRiR5Y9LSaeS3baXJKNmsMR7mWH6p0Ca/NV4V5bmkqFYecG4fx75lT59lfxR0punbf+U74aNa4RA2XpnHHiCDlTDYOLDxFr83Z/YvjM4DsM2JR/HMbh4cvQI9IeiLiw3Id1jV2MP7tLD6tWs8ocSGIVjOpmjKMNZsXEqC2z1df9Bv8btg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBOGkVeyJPInxBnbxblSXI8MwWaO2vLdD6cq+Yp97tY=;
 b=O7FqqITX2vPaRgkaCX/mLpCmu5R+GbB4LySe1k/aUnXRwfd7FbxWrRfgZOUsFBkI4QmUbxTjN4VinXum5N7LQKg1UnZY4GqaS4GpzW/vtWzbhhKjoA3k41C/7efPE7PxDtWBzxIw2pxCjaqHYA95NcqH8t2zEqZQD5p2izFmM+jr9xHmd9qnAFwyi7L2kGtj5vefIPIcn3gJKqgOEVjwpTjy5d6IedWZdHshNVGappS7aVMeA0ULr/Uf+FW4wRA+JGCU5rsjJxCXthWFwCd3RuvCIAxIvcbHvl+0CYFYHgTD8LWkAv9xyInoyeMT5c8/JHs/V5nZC7wmk2ST2oTLUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 17 Sep
 2026 07:08:02 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 07:08:02 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v6 sched_ext/for-7.4] sched_ext: Add lazy preemption support
Date: Thu, 17 Sep 2026 09:02:51 +0200
Message-ID: <20260917070751.3617935-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: a22d8a96-2274-4d70-dfe4-08df148a69cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	a/5XjxayT6X/HRPrrTyD7J2qNURWmW7oQKCUVIkH34RMeOO6K3fqVY43afpFlfpEBOEBl/94+GaG9RH8+bFR9zx0L7KdwrM4Ev/5xXDEoTriA3EzDPxpKaNtpLSmCVLpxdDFX6LfpweysDrxP9DMlo/XLMaCq3dWOfVM0lfgNnEYN8EypuiBUndOh0COF4m6HPbZbjiNWRr5pjsEMvvyBrLQizW1Kosu4IiUA5bz7JE5x6T5qG1ikgbOZrArUGw/7kq3JOx8dosF/71aO1Matm/K+L0zmqWAGaZFe1q6OX3kmIVDCq7Z+com8g1hJvHUGuethNlamVu8qgxgPvFAZRqLSw/4DKAbzqpDswM5gEZcPTSkkAgGWFyejRdODvKsR4azWlIW3TMa7gVzJayl34UG41ote7SubYRrcVs60Q8Nv83kLrXbptO5ipEJvHOO9iBgdwg7zACl8x4eO45qzKzCEtpw+5FIHfjSBPkyxSHTQ93VMHovHW3/Ns1hyWWBkNBV1VIYf4eySbQDR9tammioQYl9fE+UrraLDC1zv042VNsGDIaMxM0J/mEbdrUJ5IWgQWIH+GleG/tcjsNsNvYnKGG6IZ7O+pgFLDiw+KnVR2WpfHJcAxk6ub4UTqXV5ZDt3pbl6Ys0717TaQwBaRKzOnMv8epPkOgTiRrh1vU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(11063799006)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kGkm8EjxocQDjDJwan3vzQHJ5B8ISlL5f/adLAT9ylmEDpm+d6E+jph/Vza4?=
 =?us-ascii?Q?KPdCyVQl54gC+Kt207YCDuY9xK34dBTB1AmdgEpH4KpUzzoZaaMSkaj7Sz95?=
 =?us-ascii?Q?SgBoKXQ2LRYjLg3xksYWLre7gf7Acovjzvst+cshSeIAseZ5rIEyiJzWwvha?=
 =?us-ascii?Q?jBhCCgs71JdmZgyvrbjdpWUDNfMIqGdZ1rUcyy1rsNTyKCv5KNgj3zHY0dTT?=
 =?us-ascii?Q?Un9/YJjpcsQYVskhcewmoisxgmL7aSzxh4g1noXps2+VVkhfd04bXRZN7jYO?=
 =?us-ascii?Q?YMPt1b2Ih/3zhcr4tMs6Fj9dzGlkjlgEmw8AlJOSRIoBFaWiOa7CqfFWifCD?=
 =?us-ascii?Q?1vQD1jK9H4VCGZH/kYBRAdIQn3y9n70uAVepAnYksHfKhlN1LJ2yiL2CIaCa?=
 =?us-ascii?Q?giE/3prwJ7Xr/8Sd7CsUgUy6MsWXu941YW2oTywo5CkoqqpRGpjA3/lE6OO6?=
 =?us-ascii?Q?HjB2505wd1NsbxBqQagL1pYNRWNrG0zGx2uv52sKyakP3N8Y057yxQ32m/C4?=
 =?us-ascii?Q?RQ1Z8dfs0Ju/UDmF3Th2acZZ2Wdxf6ItXnasqBKFZSDM3Z39A8cuYPK87I84?=
 =?us-ascii?Q?DTO3qdtFxem74PSTZbwRa4Y5Eej6cDvFoNQHEWcXxxJRmLfhHmk2PFUFZQSY?=
 =?us-ascii?Q?naOE2Bzbrx+cmGBMaEjRj5LRCWvBjs77RSLdqyRXyn/Qe/OGRC2xNECv/KTu?=
 =?us-ascii?Q?uzWAfbdiEw22aNQdtqy2DAHKHVlznn9w246k0lh9OEoNh7jr+X1r8z4ByfmZ?=
 =?us-ascii?Q?zDO2BBeQo9pjpmdrPSiz9+36pZam6LFHYa8Wfr94edAcsYxxKbWVfzLK3k9f?=
 =?us-ascii?Q?jsXAKOBBudHKFLxxx7U+1XfH64EDEewmtL70HgNVBeJGSitq17bkXJ4jtZH3?=
 =?us-ascii?Q?qMG73O7T02xxdbfSm+KAocad7ono5opDfr9ScGnnqQ69VpfCkBEbEsePTZy7?=
 =?us-ascii?Q?oaKDkbUJiIZB8mvBknLydmy57wknMXuQfAwFAGsY5acjf7u0sOHgpmlHxE4a?=
 =?us-ascii?Q?wKIiWiUXm1ZgvffwOXQm2yeqUvn/054lZqvcHLXkFvKdff4Yk/8gCJURxCqJ?=
 =?us-ascii?Q?ndZzNZChHdFeFbP1ZD6P1+5ZC5DHOsF2mGjFDA8ruQPO0xJWxjga4E4DNhpa?=
 =?us-ascii?Q?NCWQadJKJq7tTEUZLRYVhH72k6ySSwR85whV7sfaLPywuUDtEhZhD/udW3j3?=
 =?us-ascii?Q?qs983j05e2IK9Z/YjMaegqgP+/By8Zx4+8TT6WQQtU5ECxG28BGpCWBmQu6F?=
 =?us-ascii?Q?r2Os/GDdYiunqhETYlWTB/T38cN5rgrAeJrycPHPj1aRDcmiUIl/gjSsGXbR?=
 =?us-ascii?Q?wItUReYVYk83QFWb4XxTNsGWRmISqdCE7gWqkgTOG5fhM5iv7qJOcRnIzOkS?=
 =?us-ascii?Q?xT8Vn2gHkZ1exO8cIQuUnP4kQTSaEV9rUuH4WtWoglnTcFeI9NmGsycqSoVg?=
 =?us-ascii?Q?2Q3ODHqE/Kj7ehJVX+/f5RsC5rkqCtV20os/ySYRT9VxJtgsLIVuG7ezI1/B?=
 =?us-ascii?Q?PHgv85lE1Er4SXusii3mvgM4EguaiQ6qqhD+CI5U0X9erqaiHvZYYqXU3yLm?=
 =?us-ascii?Q?tOk2mcy0VPVG4NnEYNrgr/umvdGF7RrXmAj4ZaIIpJdInihuA1cl346sa++0?=
 =?us-ascii?Q?FmKe6TIabXk93a8fjIwIJcjnX/VYrqVcYrAH+Wkd5UICXAxV7TEcJBHIbaS1?=
 =?us-ascii?Q?Adp7k3BgrbWCnKNMt6KBuNIzTI5L/oQ7cK73yF8kw21d15ZyYtBYBZr63SAX?=
 =?us-ascii?Q?t8hsxn1GiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22d8a96-2274-4d70-dfe4-08df148a69cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:08:02.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/G9Hvk0ThmlGFCVXU4yOc2GvpNcPbmLF7tlEe9lqFYwy2KRRvdh/kQ1U6Qla6zjS95jOwYPrLagZGIlk1mKNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

The fair scheduling class can defer a scheduling boundary through lazy
rescheduling, but sched_ext currently exposes only immediate preemption to BPF
schedulers.

This series adds lazy variants of the enqueue and kick preemption flags. They
expire the running sched_ext task's slice while allowing the scheduling boundary
to be deferred until a return to user space or the next scheduler tick.

SCX_OPS_LAZY_SLICE_EXPIRY selects lazy slice expiry by default. Schedulers can
override that default in either direction for individual tasks through
scx_bpf_task_set_slice_expiry(). The helper preserves sub-scheduler task
ownership boundaries. Bypass continues to force immediate rescheduling.

Lazy enqueue and kick requests also restore the scheduler tick when targeting an
infinite-slice task on a NO_HZ_FULL CPU. The reschedule request is set first so
that the dependency update's IPI can serve it on return to user space, while the
restored tick guarantees eventual promotion otherwise.

The selftests cover immediate and lazy preemption, coalescing and precedence
between kick modes, enqueue preemption, per-task slice-expiry overrides, invalid
flags, and lazy preemption of infinite-slice tasks on NO_HZ_FULL CPUs.  The
NO_HZ_FULL cases verify that the tick has stopped before issuing the lazy
request.

Tested in separate virtme-ng runs, covering preempt=lazy and nohz_full:

 $ vng -a "preempt=lazy" -- \
     tools/testing/selftests/sched_ext/runner -t kick

  kick:
    PASSED:  6
    SKIPPED: 0
    FAILED:  0

 $ vng --cpus 4 -a "nohz_full=1-3" -- \
     tools/testing/selftests/sched_ext/runner -t nohz_tick

  nohz_tick:
    CPU 1 received 6 finite-slice ticks
    PASSED:  1
    SKIPPED: 0
    FAILED:  0

The mode-sensitive kick_lazy and kick_tick cases also passed after switching
/sys/kernel/debug/sched/preempt between lazy and full.

Changes in v6:
 - Pack slice_expires_lazy next to scx.disallow instead of growing task_struct
   by eight bytes (Tejun Heo).
 - Correct the SCX_OPS_LAZY_SLICE_EXPIRY documentation for PREEMPT_DYNAMIC and
   bypass (Tejun Heo).
 - Set the lazy reschedule request before restoring the tick dependency, so the
   dependency update's IPI can serve it on return to user space (Tejun Heo).
 - Explain the pinned rq locking and the newly rejected unknown kick flags in
   the patch description (Tejun Heo).
 - Regenerate the enum headers in definition order (Tejun Heo).
 - kselftest: use SCX_OPS_ENQ_LAST to drive kick-test victims through
   ops.stopping() (Tejun Heo).
 - kselftest: poll for the SCX_KICK_WAIT callback after ops.stopping()
   (Tejun Heo).
 - kselftest: skip trace-based tests when their BTF targets are unavailable
   (Tejun Heo).
 - kselftest: verify that the NO_HZ_FULL tick has stopped before testing lazy
   enqueue and kick requests (Tejun Heo).
 - Link to v5: https://lore.kernel.org/r/20260915194611.2674127-1-arighi@nvidia.com

Changes in v5:
 - kselftest: detect static lazy preemption when CONFIG_PREEMPT_DYNAMIC is
   disabled and the sched/preempt debugfs file is unavailable (Cheng-Yang Chou).
 - Link to v4: https://lore.kernel.org/r/20260915090127.2321020-1-arighi@nvidia.com

Changes in v4:
 - Preserve SCX_KICK_WAIT synchronization when it is combined with
   SCX_KICK_PREEMPT_LAZY (Sashiko).
 - Restore the scheduler tick dependency when ops.tick() lazily expires an
   infinite slice, ensuring the request is promoted by a later tick (Sashiko).
 - kselftest: verify that the deferred SCX_KICK_WAIT callback runs (Sashiko).
 - kselftest: keep the kick test controller off the victim CPU and skip cleanly
   when a second allowed CPU is unavailable (Sashiko).
 - kselftest: select the nohz_tick controller from allowed housekeeping CPUs
   outside the NOHZ_FULL mask and skip when the required topology is
   unavailable.
 - Link to v3: https://lore.kernel.org/r/20260914144620.2032614-1-arighi@nvidia.com

Changes in v3:
 - Avoid redundant rq clock updates when restoring the tick dependency and use
   the pinned rq lock helpers for lazy kick delivery (Sashiko).
 - Set PR_SET_PDEATHSIG for the indefinitely spinning kick test workers so they
   don't survive unexpected test-runner exit (Sashiko).
 - Wait for a delta in nr_lazy_victim_running instead of an absolute count that
   may include reschedules from the previous phase (Sashiko).
 - Increase the nohz_tick scheduler watchdog and phase timeouts to tolerate
   scheduling delays in oversubscribed test VMs.
 - Link to v2: https://lore.kernel.org/r/20260914084955.1798562-1-arighi@nvidia.com

Changes in v2:
 - Make lazy slice expiry a per-task property (Tejun Heo).
 - Add scx_bpf_task_set_slice_expiry() for per-task overrides from any sched_ext
   callback (preserving sub-scheduler task ownership).
 - Restore the scheduler tick dependency for lazy enqueue and kick preemption of
   infinite-slice tasks on NO_HZ_FULL CPUs (Tejun Heo).
 - Accumulate immediate and lazy kick requests independently and resolve their
   precedence in kick_one_cpu() (Tejun Heo).
 - Allow PREEMPT|PREEMPT_LAZY and WAIT|PREEMPT_LAZY, immediate preemption, WAIT
   and plain kicks take precedence over lazy preemption (Tejun Heo).
 - Clear both preemption masks together when processing or skipping a preemption
   request (Tejun Heo).
 - Extend the kselftests with combined and ordered kick requests, per-task
   expiry overrides and NO_HZ_FULL coverage.
 - Link to v1: https://lore.kernel.org/r/20260911195800.974364-1-arighi@nvidia.com

Andrea Righi (2):
  sched_ext: Add lazy preemption support
  selftests/sched_ext: Add lazy preemption tests

 include/linux/sched/ext.h                         |   8 +
 kernel/sched/ext/ext.c                            | 152 ++++-
 kernel/sched/ext/internal.h                       |  40 +-
 kernel/sched/ext/sub.c                            |  15 +-
 tools/sched_ext/include/scx/compat.bpf.h          |  17 +
 tools/sched_ext/include/scx/enum_defs.autogen.h   |   3 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h   |   6 +
 tools/sched_ext/include/scx/enums.autogen.h       |   2 +
 tools/sched_ext/include/scx/enums_abi.autogen.h   |   5 +-
 tools/testing/selftests/sched_ext/Makefile        |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c      | 191 +++++++
 tools/testing/selftests/sched_ext/kick.c          | 655 ++++++++++++++++++++++
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c |  62 +-
 tools/testing/selftests/sched_ext/nohz_tick.c     | 280 ++++++++-
 14 files changed, 1372 insertions(+), 65 deletions(-)
