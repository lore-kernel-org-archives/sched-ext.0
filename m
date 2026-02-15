Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1123507C
	for <sched-ext@lists.linux.dev>; Sun, 15 Feb 2026 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771183201; cv=fail; b=pKU0L5f14eq1jdHIKMJaTKEWGpHrzr0Dcckk4F7EIgMI8qYqgOdd6UathJYhG9amyo3Ab9lKs7aBWUkgn8k3u0B/C0LwkrVznRPGPYhO0tO+2UZieX/LnXY6jIelZ/GEtVLFmi7C40Le8KJ8mzD8Z9sAd3wtZAKh7nQSkIJBa5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771183201; c=relaxed/simple;
	bh=A/27tOZI6zZx0GlOm9HUa3JgAtgm14mgXaILUA11IwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hNZzIeW8eV0dR1cQJH4kmCrCL6D8MeadjgdFErIpHoZxDne1LHX6FbpGm930RJ1pxyChl5pJi/aThsmgKpJJJfU5vK8BbJLl/IfGfqoCFuUC+sTGxqLUyJqWs/jmAmcjAKNJULJFbvuuoWKjPwCM8N4BnmwAIyVmGhHWKk+ZRko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ioekML/6; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ioekML/6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk2hHTTEA7odGQmiYeNTeLyLgNRBvuLo2h8KYw2YrBaAcEVTMJrtSVg9nQEm8I7DQ5Y3T6n4Dp5+imLjuaX4X+x/WG2QNz/xBWWUb/+nfNdoBnlndE6z2SmtcrThsGnGdtK4E7wth/9BKoJ9A2AgG7M/iKizw1p3xGe4xIuiZ1x01DiwP3+c6ZvGJFyv1STClFtojns1+dETOUTB04j8er1EgNhMeePHp1P51AHBzc+L8+B6+9y1/q4SOAhQS8HaRPZG+eCHYmYLu6+OXVzASFvA9791UrHy3BE1aQY9MH/JWByPW/QneeYs1ifkh93w6clk6PddUtW7bqEAJMi4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g85QWAu3l1Ssrhd65lW28rvSf/PnhPJ6pEglCCjpzEQ=;
 b=C6IJwbjP5dD3XMWSHwIX+N8Cuy5YQumQpgzpw6UF2t9KdmpDcdxoFyIH3Sm5KodK2PR/v5QZjHbQMaPigFf1ahzZyj2be0vwo8roFTgnqNOCc2GQV9XtI4//TC8s1+sT3L2Tq4hSLMEGsNWz0XrrwqWhfXXsXaZlOn0+Y/MR76R9cpgNGaGAQliPmUwgNtADcc9+tAPNtp5dt8Px7aRgI/A8yYwt/V/RIdIBZp4KoqXlgWndOWUTG9gakAjeHx1SQWTplFTVhlar831rq32J+HH6baCmS6ZmGAc1oA0kPYPkSgNbcbe+3GRlHULAMar2PmzwCqG3kUu/0+zWa9XfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g85QWAu3l1Ssrhd65lW28rvSf/PnhPJ6pEglCCjpzEQ=;
 b=ioekML/69nRbNv4xHWlVQzaz10HQg/54yIfjCxncmvugeBX9oIgLXNpOW3Qb1NqLB/UAmY28jqpbUbvYy/mh8qQ3V1lEwWfmP+tz+cWZB16PRjbpzB3j8HdC9DYUQ+ogGEuUit3/s26LItPJYzS3OxGs83V9dSYu/Ojzaz2FHEOLBRb7Y7FtlZqyRY7/YmPzqtPL6HYcosKTPSu9tjZSM1WSIh2nGdX/5UrqWOW0TOk4gb46GXbXgNxHFxMUe2xHRToSVEYi9pH0Z8BeRInzbeL0DDPiczvUgDFtDOog6thXjjiQXFwan5O1xVbyhp3vCCtP8KwcMEtSY+WiDTbL4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 19:19:54 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 19:19:54 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sched_ext: Fix ops.dequeue() semantics
Date: Sun, 15 Feb 2026 20:16:55 +0100
Message-ID: <20260215191933.2358161-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260215191933.2358161-1-arighi@nvidia.com>
References: <20260215191933.2358161-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 424077a7-f4a1-40d3-0ba9-08de6cc732dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uq25caj3q9FzkqFKKxySavY1h7WMZgPUljxUwLKh0Aa+OMYmhst8bjXd+FtK?=
 =?us-ascii?Q?VA7A/IFF3dKIs0bWNBjEONctJbZEUVh233qCLodW+u1jPrN8rZckByZrgO/Q?=
 =?us-ascii?Q?Y5PDt1nC+dmynp7sbB4vFqbsZKoEEIfBUgyBQ+TBCxo7nN0stOylxefxiWNj?=
 =?us-ascii?Q?RI99JNu/OHa2SIlwi2Xjsel7080pEHTkGczRaxQgAsMKrsogOCDN7PxtMT9p?=
 =?us-ascii?Q?No296Gl7+tNmLARj2+1KkBGvTWgjIz5u8YhjAFh0Da4tel0K068Qtdy3pshh?=
 =?us-ascii?Q?yp6yrFU12zH48+DHSNm1q0RA4fUC9fJgssMSSnvFnxNjIqOqeDLTFAk5+9vk?=
 =?us-ascii?Q?crthcddlzJHE4HgTTWZ5m62GxFlMkJiCyWLB5yz0Cv7AsLy4BtZYyQFY8xfb?=
 =?us-ascii?Q?na/PIHmhH1b3Z1+trsLUKzi2XgdhpND1b63PDHyBXcUPJObxxrFKOC+Da4Gf?=
 =?us-ascii?Q?8gyfX0sGyxcL/XJbGQTHhT73nZSs+Ag7/cG/cZYgK5QFQSQZiKr33NCENUtp?=
 =?us-ascii?Q?yqYUpR0HVNxHDkURNFo7lQqFiMaYidMoqHZndfyX4Sw1jC0CKVMpvSFf7cgy?=
 =?us-ascii?Q?GkAYWSee/048QxR/7lf3NoZZtnwprzQP7NEdC70O97rpzXroNghWAWa2GkhC?=
 =?us-ascii?Q?WEOu4R/h4oIJf5Z18HMYXT+ij++8vagY6togyQW8upeUmnTdW/AozYn6iPUP?=
 =?us-ascii?Q?7ARgYDhO4t+KUuGtQa/+jlBgsdWb80onKREyM6Vgr9GR9XKD65uiL9fQ0vVP?=
 =?us-ascii?Q?/d/PYkbS28+dlkK+x4DqHYDdJHCX3YijpCxBiC3B2WavUYw615Ifdkql+gRx?=
 =?us-ascii?Q?zz3y2QZY3bxVPRpo8WQTn8vOR69boG2jBgO/abIVXvWOIsvey4muNaAOGF4q?=
 =?us-ascii?Q?gnK7mGDOQWyb9ltAra7HyrJxvMiCfUu+rXk6xLv4LdEdqU1HoyIrLN6Ik0AP?=
 =?us-ascii?Q?BYpkYQQr8Kewb4l4madio7PN0VhVzGf7xLKcGEltWuJK2v+ZoejtBJ4y6pTC?=
 =?us-ascii?Q?o9bGSlOV/+uLl1zJGowEhBef9w/gCICRGYgeTKbkZkxKk2atDsKW4RROKHp6?=
 =?us-ascii?Q?uhUHHlrhKO4eFwmG5XsyLtdlZ3LITVkA169X/G9xLkyLqQphCtY726b5aSgY?=
 =?us-ascii?Q?5jM8x5iqsxVklV3uy5Eg2rYuaG1rX3suVdYFIc8Rif98o4ejELIb81uSCs7u?=
 =?us-ascii?Q?LoOpVbU7PKF3Umy+i2GTjzgAV1V4vWGO+NSttoj+eyAgkJguk2+8xafJW1QQ?=
 =?us-ascii?Q?g6D+xBmIIRLe11SJugL5Lq4KbYBvQ1rfOIJGqxkLemp133OU2SAvibCXNwzW?=
 =?us-ascii?Q?v5l27ciVntFITkWr93CJs+BVgxk0e8cwP2WEjiX9LOtdmReFvOA+VzrSiTKc?=
 =?us-ascii?Q?Odyd89dX38ihc6GPl3bP1TkX/In6DNSsIz/M+azt2MkVwjdMsvhVccIDw4L8?=
 =?us-ascii?Q?w05w9F6cSBKzSMcz0lbGazCFmWTfmKNgYXhF4H7/fdXrSJ2ZqbArF1z4IP+Z?=
 =?us-ascii?Q?xGWC8AA0eCxT62HiETlxDkPYrL7cQMto/9ZHrPQkqV7lxV3kaB5VTCF7QGfi?=
 =?us-ascii?Q?Uw3GVPy3jHfqJjrl4tM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XJMepd8EyE0bVx1rO4T9X90ZCy7iveTllIVrgQCszAelrhRXi/dWDdM5ObCx?=
 =?us-ascii?Q?Gy2VvvVoFFa9zijyFhzY9yu5Nm0iDPMshZZO02V87/EWYoI98gyoUMCyFyLp?=
 =?us-ascii?Q?8Zf4oFEt7LH6yr3q5lTL9SNJKfVdb4/8fINVRDCqO+hb5lFLG5j++IljGNi+?=
 =?us-ascii?Q?86YqDeD0fX4kKhd1tTnWA3NmnaLr4zwg/ZqYtdr68YbknBj/mAQ/a2PmVzKP?=
 =?us-ascii?Q?nESrFTUa4FtBvNslfWx4TAFSNt7Lot+y6MPXj3coChyB+eHkCmpmVYta7QsS?=
 =?us-ascii?Q?A0TZiLMDQg37MOvjGWK/8XmPBu4J41OM4dUotTtg4ym1gRNscU6EBGxI05Dm?=
 =?us-ascii?Q?SPcscDvI1C7BgVouHHq/zppB/pRlqWnVNN/k33tnpmFO3oxK27617z7NFEiE?=
 =?us-ascii?Q?uKrr4nHPU6+7iLIrhIO0TXHPzX6ypHZg1rh+++m5IEif8WD57p+x/E2IAEuq?=
 =?us-ascii?Q?VLkTjuLLIMWzBCpErFPdrFVAoYGoaF5s8xL7p+9abMkfn6GIIaAUIDcrSfhc?=
 =?us-ascii?Q?UvkeEqHUQhl9E5QxtHsu62VmEnIPvxXf1ArwEa7DuZ89SKd74Cbua08iaLMt?=
 =?us-ascii?Q?MJAwRaX1f0CMluTmpbM76l5g4++rZ0iQ8uN/H1q67n62Q3xcKEGY9vC7U57d?=
 =?us-ascii?Q?UGDU3NrOJ9t1JaaJsN6YcqO/eUGKFhcYJ4ZiA4XLLpRx7AlatJA9MZoCnlf1?=
 =?us-ascii?Q?EusWBkN/QLttvonuCyvxnkI+j1aqCsX8dCIsz30ITynWfxRw+J8PzE6lC8ox?=
 =?us-ascii?Q?3Yz4QUTs5wKk81YFsru8zYtxVW9YywEDEsjJ+D6+sbDaqO6L6SeGSaZr4F3y?=
 =?us-ascii?Q?g3SRV2MKUIj/c2IdJ0OtkL+44fz+JVbz3UIxYiKrACeqsHsIOOJsVBA17h30?=
 =?us-ascii?Q?eWLZGqXKwcVguDCoGMHhZTH2Pvw7zVO2lIQaiS5b6zW8oZHBDcucxRWn5/XR?=
 =?us-ascii?Q?y3nIP8iCcKIdNnxQLcsMIO6EQcl1etk4r1BbAqV3p3a6K+olh3K7tCCFKHqC?=
 =?us-ascii?Q?Pm7eqK/jot/qVaHfnFjWev0Uc27MF4ldPvJFIG/BBTOnsiSmFf0uKw9WSLeL?=
 =?us-ascii?Q?cDF6UlqHYLJhdr43kwlsp5ckOezdgErS8tVCpDvSbdEGR2iR2CMXR2aDsWWN?=
 =?us-ascii?Q?voLz1UH8m73QntQzMVZHQMguXG5FJlZsDmcZ5dqxf88yEN24xBJ20VkmJEw1?=
 =?us-ascii?Q?+rloPy527hMq421VZdLnDNMTQODmviM8R3rjUo9uOkc3TGpecS0MUbnsyJT4?=
 =?us-ascii?Q?+nJCesBXKHuT6rjKIpIBMTaVP6+FeiTB9n93P9LrniEjq7mdzRvpxFfP6+SY?=
 =?us-ascii?Q?wgIsjnW8Yio2wQNqI+feeTfVowN2nhHFdxVnPb0S5mo2Cy8gdpBtYiqNxtJg?=
 =?us-ascii?Q?ySrzqz6022E5P2xXinEDCjtcN88BcE5lQX+fTqcW8++7cyfxXd79Li5qkUkO?=
 =?us-ascii?Q?2x4jzneK3i+6GTJU2iEtFbDT3bkgt5NwDuiapeYiYLNAm7ghgh4Wr+YJxgYF?=
 =?us-ascii?Q?M8dcp6E1z4dU+GCPCIgANfz57Z9UbEQV0aIvxPo5i6QOf2WJy4v/Qs1ZVtal?=
 =?us-ascii?Q?ogX5PZVFzu9Nx/Nj86c1n81cvRQIMuSfYGAzvJgGa84qaxRUVi2bCiy3gS40?=
 =?us-ascii?Q?luT0uvupDRoAImtiNHLok8DlopRIFRryLSmgXPpRM988OgFZTROU9V1krGUO?=
 =?us-ascii?Q?6QX/4YFXMIectxgxE7SvV81LST+yQxZUh+VIy1w5GREWcSfd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424077a7-f4a1-40d3-0ba9-08de6cc732dd
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 19:19:54.7953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQwpDtUFwlqwl7o8nrh6zR7IqlOr7gLZ4lsOTfyFBUHyWZoG2PiWQwf/ostKu7uze5wHyckH34shddcy0+Jhtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

Currently, ops.dequeue() is only invoked when the sched_ext core knows
that a task resides in BPF-managed data structures, which causes it to
miss scheduling property change events. In addition, ops.dequeue()
callbacks are completely skipped when tasks are dispatched to non-local
DSQs from ops.select_cpu(). As a result, BPF schedulers cannot reliably
track task state.

Fix this by guaranteeing that each task entering the BPF scheduler's
custody triggers exactly one ops.dequeue() call when it leaves that
custody, whether the exit is due to a dispatch (regular or via a core
scheduling pick) or to a scheduling property change (e.g.
sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
balancing, etc.).

BPF scheduler custody concept: a task is considered to be in the BPF
scheduler's custody when the scheduler is responsible for managing its
lifecycle. This includes tasks dispatched to user-created DSQs or stored
in the BPF scheduler's internal data structures from ops.enqueue().
Custody ends when the task is dispatched to a terminal DSQ (such as the
local DSQ or %SCX_DSQ_GLOBAL), selected by core scheduling, or removed
due to a property change.

Tasks directly dispatched to terminal DSQs bypass the BPF scheduler
entirely and are never in its custody. Terminal DSQs include:
 - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
   where tasks go directly to execution.
 - Global DSQ (%SCX_DSQ_GLOBAL): the built-in fallback queue where the
   BPF scheduler is considered "done" with the task.

As a result, ops.dequeue() is not invoked for tasks directly dispatched
to terminal DSQs.

To identify dequeues triggered by scheduling property changes, introduce
the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
the dequeue was caused by a scheduling property change.

New ops.dequeue() semantics:
 - ops.dequeue() is invoked exactly once when the task leaves the BPF
   scheduler's custody, in one of the following cases:
   a) regular dispatch: a task dispatched to a user DSQ or stored in
      internal BPF data structures is moved to a terminal DSQ
      (ops.dequeue() called without any special flags set),
   b) core scheduling dispatch: core-sched picks task before dispatch
      (ops.dequeue() called with %SCX_DEQ_CORE_SCHED_EXEC flag set),
   c) property change: task properties modified before dispatch,
      (ops.dequeue() called with %SCX_DEQ_SCHED_CHANGE flag set).

This allows BPF schedulers to:
 - reliably track task ownership and lifecycle,
 - maintain accurate accounting of managed tasks,
 - update internal state when tasks change properties.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         |  78 +++++++++-
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            | 142 +++++++++++++++++-
 kernel/sched/ext_internal.h                   |   7 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 7 files changed, 220 insertions(+), 12 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 9e2882d937b43..c3ca90af894d1 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -228,16 +228,23 @@ The following briefly shows how a waking task is scheduled and executed.
    scheduler can wake up any cpu using the ``scx_bpf_kick_cpu()`` helper,
    using ``ops.select_cpu()`` judiciously can be simpler and more efficient.
 
-   A task can be immediately inserted into a DSQ from ``ops.select_cpu()``
-   by calling ``scx_bpf_dsq_insert()``. If the task is inserted into
-   ``SCX_DSQ_LOCAL`` from ``ops.select_cpu()``, it will be inserted into the
-   local DSQ of whichever CPU is returned from ``ops.select_cpu()``.
-   Additionally, inserting directly from ``ops.select_cpu()`` will cause the
-   ``ops.enqueue()`` callback to be skipped.
-
    Note that the scheduler core will ignore an invalid CPU selection, for
    example, if it's outside the allowed cpumask of the task.
 
+   A task can be immediately inserted into a DSQ from ``ops.select_cpu()``
+   by calling ``scx_bpf_dsq_insert()`` or ``scx_bpf_dsq_insert_vtime()``.
+
+   If the task is inserted into ``SCX_DSQ_LOCAL`` from
+   ``ops.select_cpu()``, it will be added to the local DSQ of whichever CPU
+   is returned from ``ops.select_cpu()``. Additionally, inserting directly
+   from ``ops.select_cpu()`` will cause the ``ops.enqueue()`` callback to
+   be skipped.
+
+   Any other attempt to store a task in BPF-internal data structures from
+   ``ops.select_cpu()`` does not prevent ``ops.enqueue()`` from being
+   invoked. This is discouraged, as it can introduce racy behavior or
+   inconsistent state.
+
 2. Once the target CPU is selected, ``ops.enqueue()`` is invoked (unless the
    task was inserted directly from ``ops.select_cpu()``). ``ops.enqueue()``
    can make one of the following decisions:
@@ -251,6 +258,61 @@ The following briefly shows how a waking task is scheduled and executed.
 
    * Queue the task on the BPF side.
 
+   **Task State Tracking and ops.dequeue() Semantics**
+
+   A task is in the "BPF scheduler's custody" when the BPF scheduler is
+   responsible for managing its lifecycle. A task enters custody when it is
+   dispatched to a user DSQ or stored in the BPF scheduler's internal data
+   structures. Custody is entered only from ``ops.enqueue()`` for those
+   operations. The only exception is dispatching to a user DSQ from
+   ``ops.select_cpu()``: although the task is not yet technically in BPF
+   scheduler custody at that point, the dispatch has the same semantic
+   effect as dispatching from ``ops.enqueue()`` for custody-related
+   purposes.
+
+   Once ``ops.enqueue()`` is called, the task may or may not enter custody
+   depending on what the scheduler does:
+
+   * **Directly dispatched to terminal DSQs** (``SCX_DSQ_LOCAL``,
+     ``SCX_DSQ_LOCAL_ON | cpu``, or ``SCX_DSQ_GLOBAL``): the BPF scheduler
+     is done with the task - it either goes straight to a CPU's local run
+     queue or to the global DSQ as a fallback. The task never enters (or
+     exits) BPF custody, and ``ops.dequeue()`` will not be called.
+
+   * **Dispatch to user-created DSQs** (custom DSQs): the task enters the
+     BPF scheduler's custody. When the task later leaves BPF custody
+     (dispatched to a terminal DSQ, picked by core-sched, or dequeued for
+     sleep/property changes), ``ops.dequeue()`` will be called exactly
+     once.
+
+   * **Stored in BPF data structures** (e.g., internal BPF queues): the
+     task is in BPF custody. ``ops.dequeue()`` will be called when it
+     leaves (e.g., when ``ops.dispatch()`` moves it to a terminal DSQ, or
+     on property change / sleep).
+
+   When a task leaves BPF scheduler custody, ``ops.dequeue()`` is invoked.
+   The dequeue can happen for different reasons, distinguished by flags:
+
+   1. **Regular dispatch**: when a task in BPF custody is dispatched to a
+      terminal DSQ from ``ops.dispatch()`` (leaving BPF custody for
+      execution), ``ops.dequeue()`` is triggered without any special flags.
+
+   2. **Core scheduling pick**: when ``CONFIG_SCHED_CORE`` is enabled and
+      core scheduling picks a task for execution while it's still in BPF
+      custody, ``ops.dequeue()`` is called with the
+      ``SCX_DEQ_CORE_SCHED_EXEC`` flag.
+
+   3. **Scheduling property change**: when a task property changes (via
+      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
+      priority changes, CPU migrations, etc.) while the task is still in
+      BPF custody, ``ops.dequeue()`` is called with the
+      ``SCX_DEQ_SCHED_CHANGE`` flag set in ``deq_flags``.
+
+   **Important**: Once a task has left BPF custody (e.g. after being
+   dispatched to a terminal DSQ), property changes will not trigger
+   ``ops.dequeue()``, since the task is no longer managed by the BPF
+   scheduler.
+
 3. When a CPU is ready to schedule, it first looks at its local DSQ. If
    empty, it then looks at the global DSQ. If there still isn't a task to
    run, ``ops.dispatch()`` is invoked which can use the following two
@@ -318,6 +380,8 @@ by a sched_ext scheduler:
                 /* Any usable CPU becomes available */
 
                 ops.dispatch(); /* Task is moved to a local DSQ */
+
+                ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
             while (task->scx.slice > 0 && task is runnable)
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d8..4601e5ecb43c0 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -84,6 +84,7 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	SCX_TASK_IN_CUSTODY	= 1 << 1, /* in custody, needs ops.dequeue() when leaving */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9820026b74557..42e1c3f081041 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -925,6 +925,22 @@ static void touch_core_sched(struct rq *rq, struct task_struct *p)
 #endif
 }
 
+/**
+ * Returns true if @dsq is a terminal DSQ, where the BPF scheduler is
+ * considered "done" with the task.
+ */
+static inline bool is_terminal_dsq(struct scx_dispatch_q *dsq)
+{
+	switch (dsq->id) {
+	case SCX_DSQ_LOCAL:
+	case SCX_DSQ_GLOBAL:
+	case SCX_DSQ_BYPASS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
  * @rq: rq to read clock from, must be locked
@@ -986,12 +1002,43 @@ static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
+/*
+ * Call ops.dequeue() for a task leaving BPF custody.
+ */
+static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
+			      struct task_struct *p, u64 deq_flags)
+{
+	if (SCX_HAS_OP(sch, dequeue))
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, deq_flags);
+}
+
+/*
+ * Return true if @p is moving due to an internal SCX migration, false
+ * otherwise.
+ */
+static inline bool task_scx_migrating(struct task_struct *p)
+{
+	return task_on_rq_migrating(p) && p->scx.sticky_cpu >= 0;
+}
+
 static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p,
 			       u64 enq_flags)
 {
 	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
 	bool preempt = false;
 
+	/*
+	 * Task is on a local (terminal) DSQ. Call ops.dequeue() if the
+	 * task was in BPF custody and this is not an internal SCX
+	 * migration.
+	 */
+	if ((p->scx.flags & SCX_TASK_IN_CUSTODY) && !task_scx_migrating(p)) {
+		struct scx_sched *sch = scx_root;
+
+		call_task_dequeue(sch, rq, p, 0);
+		p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+	}
+
 	/*
 	 * If @rq is in balance, the CPU is already vacant and looking for the
 	 * next task to run. No need to preempt or trigger resched after moving
@@ -1106,6 +1153,12 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
+	/*
+	 * Non-terminal DSQs: task enters BPF scheduler's custody.
+	 */
+	if (!is_terminal_dsq(dsq))
+		p->scx.flags |= SCX_TASK_IN_CUSTODY;
+
 	/*
 	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
 	 * direct dispatch path, but we clear them here because the direct
@@ -1122,10 +1175,23 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
 		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
 
-	if (is_local)
+	if (is_local) {
 		local_dsq_post_enq(dsq, p, enq_flags);
-	else
+	} else {
+		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS) {
+			/*
+			 * Task is on the global or bypass DSQ: call
+			 * ops.dequeue() if the task was in BPF custody and
+			 * it's not an internal SCX migration.
+			 */
+			if ((p->scx.flags & SCX_TASK_IN_CUSTODY) &&
+			    !task_scx_migrating(p)) {
+				call_task_dequeue(sch, rq, p, 0);
+				p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+			}
+		}
 		raw_spin_unlock(&dsq->lock);
+	}
 }
 
 static void task_unlink_from_dsq(struct task_struct *p,
@@ -1405,6 +1471,12 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
+	/*
+	 * Task is now in BPF scheduler's custody. Set %SCX_TASK_IN_CUSTODY
+	 * so ops.dequeue() is called when it leaves custody.
+	 */
+	p->scx.flags |= SCX_TASK_IN_CUSTODY;
+
 	/*
 	 * If not directly dispatched, QUEUEING isn't clear yet and dispatch or
 	 * dequeue may be waiting. The store_release matches their load_acquire.
@@ -1522,6 +1594,14 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 {
 	struct scx_sched *sch = scx_root;
 	unsigned long opss;
+	u64 op_deq_flags = deq_flags;
+
+	/*
+	 * Set %SCX_DEQ_SCHED_CHANGE when the dequeue is due to a property
+	 * change (not sleep or core-sched pick).
+	 */
+	if (!(op_deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+		op_deq_flags |= SCX_DEQ_SCHED_CHANGE;
 
 	/* dequeue is always temporary, don't reset runnable_at */
 	clr_task_runnable(p, false);
@@ -1531,6 +1611,25 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 	switch (opss & SCX_OPSS_STATE_MASK) {
 	case SCX_OPSS_NONE:
+		/*
+		 * If the task is still in BPF scheduler's custody
+		 * (%SCX_TASK_IN_CUSTODY is set) call ops.dequeue().
+		 *
+		 * The code that clears ops_state to %SCX_OPSS_NONE does
+		 * not always clear %SCX_TASK_IN_CUSTODY: in
+		 * dispatch_to_local_dsq(), when we're moving a task that
+		 * was in %SCX_OPSS_DISPATCHING to a remote CPU's local
+		 * DSQ, we only set ops_state to %SCX_OPSS_NONE so that a
+		 * concurrent dequeue can proceed, but we clear
+		 * %SCX_TASK_IN_CUSTODY only when we later enqueue or move
+		 * the task. So we can see NONE + IN_CUSTODY here and we
+		 * must handle it.
+		 */
+		if ((p->scx.flags & SCX_TASK_IN_CUSTODY) &&
+		    !task_scx_migrating(p)) {
+			call_task_dequeue(sch, rq, p, op_deq_flags);
+			p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+		}
 		break;
 	case SCX_OPSS_QUEUEING:
 		/*
@@ -1539,9 +1638,18 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		if (SCX_HAS_OP(sch, dequeue))
-			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
-					 p, deq_flags);
+		/*
+		 * Task is in BPF scheduler's custody (not dispatched yet).
+		 * Call ops.dequeue() unless this is an SCX-initiated
+		 * migration.
+		 *
+		 * A queued task must be always in BPF scheduler's custody.
+		 */
+		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
+		if (!task_scx_migrating(p)) {
+			call_task_dequeue(sch, rq, p, op_deq_flags);
+			p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+		}
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -1563,6 +1671,16 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		wait_ops_state(p, SCX_OPSS_DISPATCHING);
 		BUG_ON(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
+
+		 /*
+		  * After DISPATCHING completes, task may still be
+		  * IN_CUSTODY (see the NONE case).
+		  */
+		if ((p->scx.flags & SCX_TASK_IN_CUSTODY) &&
+		    !task_scx_migrating(p)) {
+			call_task_dequeue(sch, rq, p, op_deq_flags);
+			p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+		}
 		break;
 	}
 }
@@ -2935,6 +3053,13 @@ static void scx_enable_task(struct task_struct *p)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Verify the task is not in BPF scheduler's custody. If flag
+	 * transitions are consistent, the flag should always be clear
+	 * here.
+	 */
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
+
 	/*
 	 * Set the weight before calling ops.enable() so that the scheduler
 	 * doesn't see a stale value if they inspect the task struct.
@@ -2966,6 +3091,13 @@ static void scx_disable_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
+
+	/*
+	 * Verify the task is not in BPF scheduler's custody. If flag
+	 * transitions are consistent, the flag should always be clear
+	 * here.
+	 */
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
 }
 
 static void scx_exit_task(struct task_struct *p)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 386c677e4c9a0..befa9a5d6e53f 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -982,6 +982,13 @@ enum scx_deq_flags {
 	 * it hasn't been dispatched yet. Dequeue from the BPF side.
 	 */
 	SCX_DEQ_CORE_SCHED_EXEC	= 1LLU << 32,
+
+	/*
+	 * The task is being dequeued due to a property change (e.g.,
+	 * sched_setaffinity(), sched_setscheduler(), set_user_nice(),
+	 * etc.).
+	 */
+	SCX_DEQ_SCHED_CHANGE	= 1LLU << 33,
 };
 
 enum scx_pick_idle_cpu_flags {
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index c2c33df9292c2..dcc945304760f 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -21,6 +21,7 @@
 #define HAVE_SCX_CPU_PREEMPT_UNKNOWN
 #define HAVE_SCX_DEQ_SLEEP
 #define HAVE_SCX_DEQ_CORE_SCHED_EXEC
+#define HAVE_SCX_DEQ_SCHED_CHANGE
 #define HAVE_SCX_DSQ_FLAG_BUILTIN
 #define HAVE_SCX_DSQ_FLAG_LOCAL_ON
 #define HAVE_SCX_DSQ_INVALID
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 2f8002bcc19ad..5da50f9376844 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -127,3 +127,5 @@ const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 const volatile u64 __SCX_ENQ_DSQ_PRIQ __weak;
 #define SCX_ENQ_DSQ_PRIQ __SCX_ENQ_DSQ_PRIQ
 
+const volatile u64 __SCX_DEQ_SCHED_CHANGE __weak;
+#define SCX_DEQ_SCHED_CHANGE __SCX_DEQ_SCHED_CHANGE
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index fedec938584be..fc9a7a4d9dea5 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -46,4 +46,5 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
+	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
 } while (0)
-- 
2.53.0

