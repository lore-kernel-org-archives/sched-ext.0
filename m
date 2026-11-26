Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795691828;
	b=ouGHXQ++wIKA2YqzWULIXr9SOhcWziF3fadqeCO9Ddn8Dym/7Lzv8bzp84AOJojFDQ8X
	 mQskaCh/t98NHnYcxXxIrMTSizRik1OaHUXglO8RspNqI0N21/c9BJU29BFJhV89DICfA
	 C4aOF2xRiDsIiMGlI52sZCkk5UzYpVSO0YV+sVbWdNfJqfyAbF4wE8CziSHIwfNB5fgmW
	 vP0aXntUeryBFeEFwypKPENSMpEgFW6sNLyhfjWhwqToneqxU2rEvdlm0zbk0bx/AazUO
	 LEvo+DQ2NZnoJ1+Z5xUCOd+8skDzkeCyCOISG9WfN4QgPtKTFEKxQvE8qoDLXPuk6gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691828;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9lzNDRFKL5xvSybXYCpbk835W6d4IneOo87Mio94fSE=;
	b=2u82yzi7lS45rsUKDyf39qhHNxCKaZnx3yrlASD5dOwoYS+ytEqAG2n3nRIUirbwt1YZ
	 bqV6n7b8uxAb7UaYCcDbfldY8d6Oworowstl74Ls8FHsudci2/VZRXMhCImXAJQ5v8//o
	 xk2p2j25qSxqv0zmTmnXVb5hkg5QCTTULZSRm2+l+Qz4ZfwUBHzSjA++UfsjpGvx5y0M4
	 ZlNMaGlZxGRn+NqiKg5CxclTWTv0uwIpuPdZGb8qN1RGsQKV/RW/gfTrA8kOUw4ovjiLP
	 Pbdn9LBCgJaJhBh257U6PowMWelmPl7KFXQ3/4CGhvuMis404MCgT4pfVSUYffY6cvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Up0Kt7aF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.59
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A540606A333
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 11:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A540606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Up0Kt7aF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIjqFqm/kBQgm9knNFruuMdVDvoMeXL7Uzpt0HQqQ21w77ezxziJQ7huOx45gU+RR+Kt9sdqCCZBx5tc0hJx4uGtBh+FAFHaWvZptHUJTrlzIziu49jgEkGG3atPJCcAjYVTqoJ3DW1mmJE/954V1e9Ur0jD0ra7L18g/h0rJfnZPCWO9Rm/VKPnQbbA/lhWZ6ztKubDokY3IxHBK58fWLFu7XudrufKBnjQn+/Pn+1JiXM//u9rTFLfiTorAGaW2En1NsNsHZtESIn69azcxcyfxmmsMszSo8cbMB3WJrNlzmeRTzXq9AhWV3bLHVtL78b/5t5iREmn1taqBSzkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lzNDRFKL5xvSybXYCpbk835W6d4IneOo87Mio94fSE=;
 b=fimUJ9VrlNnd1aU987SELRKGQ+ZFuwO1H5kvhTsEIwaiATxLcNI8U7CweQq75H1j3osPIbLDSi662/Eo0pKlAkqZEivXiMYSVyD2IZLSsWozDdt3eohXsCpwNsgbPvItvf4EsYMtWZQs7hmWYMforUDIJwfjL3bcLJaEXNCEkHNmYc5waCFtfWXcKksBzSzb3QWMbzPBrh+O/wTGdQ5puFHmJnlXe1bto+LFtqG+godm8Xi07XfSLm4G9BICbbgHsFSrPvxjBo/kbFh2ejxlIXH+3PbyNdVM1dmR1/37otQspvigVQeysg1OMBvo3RWhSafnXq6F+5B9ATMIFSB5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lzNDRFKL5xvSybXYCpbk835W6d4IneOo87Mio94fSE=;
 b=Up0Kt7aFrq0TW0y6teUYj8DEAFWzTp6XKcIopNaJG4p2zYeL3c3SwQi1jYFJVJY7bpj1sw8XVbFpgoVo5h2eOe8RCCtI41Vt/YW8vAslY1Iat6JGy58kne1l3WTNMJ+mq71gA7h+OdowbzPtl/0/mZtcrmxeMcFkQTrGKjXZ+fKOzWpRJ6dR2clZ1dVXdSh84+l7I09NZQMNGCqFzQjUmPLSfT4ree6NFf+xlEfZurSP7QpImL9yaSY3Xtk0mF4Hllh6J+qfAz0Bkfub+oR8i8soQEpPBCBOZXB2cIz1qNAfSN04Vz/ijWBfZWG/f0W11X1OfEvQHOrS/Lm3xZlDgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Thu, 26 Nov
 2026 11:17:01 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 11:17:00 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Tao Cui <cuitao@kylinos.cn>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.5] sched/proxy: Handle retained donors on scheduling class transitions
Date: Thu, 26 Nov 2026 12:13:56 +0100
Message-ID: <20261126111649.208476-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF0000753A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cc) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 58190766-c41a-4a0a-6a34-08df4baeca97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|261022105027099003|11063799006|261026140227099003|56012099006|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261026121527099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wJMKL3WYJiFJDRwpAv7zbV/sBbGyIUbEju6PtojYUfVD6X/nDJSto9mL34+ENxBqc+npQKZwKZuQiY3GQJL6F6dRKyhaG+q+cV83GMKxg2NKu3XFcrZBebJqQXtEBehBRpdWZ8XZ0yOkDhUIPpY/5FrIwAWiQUHS6k821IL4sVIHXyybf3s1ODFnYpPwYQAqVPbVOHp0QYEMwBJQmoSi6+wvih/g/mmWiwJyi5eh1CxnhOWjCWIwXo8O8BE7Zp67Ojsj8QryqpZbQfNbwkOMqhDlW/qdG+aY+7SsN2XwPh+/eXGU9mxQeCc48TKVOJckehzTWarMAvYpmwgM5pwG/gkgKtz7UMWQBb0/P4i65RwTYgkxxCS0IpTulYrlp9qDNcyVOu2/DwMuwRfv/W4CxZqoYFdIo8maymY7XFoESCvOqq2dXlKDUTExWELFE2SUZ9+mJVt1cRId6MPi+rF2ZF7KU1ZUaQTBzf3MEHZiXB736LPhDQB0tvgCnHOAQQau2hjdg8ZLFMifol4CXHAgyTbJtPfllPTWPdmpP5MJmHRiBuWNboQdDq5IsI3TcVPaGq/18Ax916geB1TwX9f3I2KZ0QduI6B1XxZlpvvtsxSbdV7otz6uSELeVnzD2HbDQg6s65u2LvFMBK+m20WyE8Po1+VnOYQsZ3YjUTybEd8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(261022105027099003)(11063799006)(261026140227099003)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?shJciOGK2mSb79FhhbQyOx1ZvOyKQeaTZyHErPa9ghbOyeWrwMAsYGpGt5PM?=
 =?us-ascii?Q?nRQdoLEoZHwsjzSiTStMusZuBMUlGNGejGSj2UJ4F3jgXsTCoxOqCowZOM4z?=
 =?us-ascii?Q?6Qg5z49Dh0s6Kiy3Zbx4YwhQrHGJdaV7DUULW9sJCR6VbgEl6mCVFtV0CW6K?=
 =?us-ascii?Q?QF/ZlQmE76TG0g/ePrKLruZXzmVGN84WDPGXcMG+0ad53+fYVHjOKGiR2yF3?=
 =?us-ascii?Q?rnV9DjdQ3T16x4eqK+I5DuOfRpC8XZ/05wEcb0CZvdyn78+aLkIuNhKJY39i?=
 =?us-ascii?Q?nvz63HYnr06zwRuxbjaPjUiWDvUnlLtClxz3HgeHkO21SWJ7Mj5T9khSwif2?=
 =?us-ascii?Q?dPjEj/KhbSIIKJb+XfIV3Pstv5X37+L/Bq3wcFITmwGkhgNMyM/lJogkufeK?=
 =?us-ascii?Q?m6JUGDehN8hkoWB5hKXBxKPzuNaJV+9qj82FViMGXIyHxeee1noShqQRKwGt?=
 =?us-ascii?Q?KnnhvDzxH+Zvc7OqqhEQrvioWrANo+jmx13GJGd7+vhe/sn4S3WJbx473tL7?=
 =?us-ascii?Q?kWF+zPXx/iO1yhhjU2JZb+UKCzahNiWNC1K/LYaFZ6wut78a9Myw0A6zMOg9?=
 =?us-ascii?Q?tIzhFHBU3ap42xHuPhLAb78mffMEaDV5zuh6yk6dwYWSIatxpRrJSL+UWKTj?=
 =?us-ascii?Q?twxRzAHZTd/MuWd5Ow+1FjkgrixjRgZnHFIZneSzuLCta8dU3PaaCwd/DgAY?=
 =?us-ascii?Q?4Dky6743WRG2fOXgj/6ORV294bu1TbbuzzxQ7HtljnO7UfMnCllDEYWqufXX?=
 =?us-ascii?Q?9+LgA1/a4UtMXF1sH+KcEzR5Uy8Vom+NJT5Nr2OjP4CLUFji7QYcmliAqmgB?=
 =?us-ascii?Q?qN2eImylCYD0jt+Bt0pENZsG+DKYPwoBgmJ0p5EzRPdQfX2ntG5mq05wqsWh?=
 =?us-ascii?Q?z9kXsZpqodGD1ITslvZ02uyHV8Z8wnenDRAb0syKgml0Fn6aSXxQXegAmhE1?=
 =?us-ascii?Q?vLM6S5F2tvPqYBZo0d+b/LKYDzLKY0PlvERc+BeuA6q593esyWX8PNexmGl3?=
 =?us-ascii?Q?Wj0AWlUU4/IpcmqaeIzov7Qrs72sU6kmo1ea0goS84bzFOCNwpdsJ4a9xxWX?=
 =?us-ascii?Q?O5POJLfzf2EiTfOx9qxl/n7h2Nt7jnTMwMcNyZjX7BA7NpScLe1JJNTDioMo?=
 =?us-ascii?Q?lSgaPKi6yTGbE3bjZmYO9pt8AWSIZCM1ZDvkgt44tnSq+u72xF4AVpRM4pFs?=
 =?us-ascii?Q?lilAE0cAfyTAjom2TGSxt/yHFZuf+g8/bblqCg0YPFVpbz7dxgbfDvmC2K1b?=
 =?us-ascii?Q?8wuJI8U1zt2k1tStmHJnrF1Ej+EKa/h0i5mU+jvcH7+7fvUO0tq1SXt1QFoG?=
 =?us-ascii?Q?CeoV/xCnQiloUGR1i15o79HcOyhV5M+pzrVmNtMpGPcQ0j7iCSwYMLjAQb56?=
 =?us-ascii?Q?etQfVGTkX4MTFwGQZBUjHAKLr8o4b+CBpWf0FJIMoh0Ao3mopNRN5TUM+dWx?=
 =?us-ascii?Q?0u36ETDy/2VEJeUwpoH3hhvGnh97nrSdsvM6nev20hnM8VIRl+e3zOOo7keV?=
 =?us-ascii?Q?nAuxeaqHg8C9hEwRf3SmpudDLNMFsCuzuoS+9Jk0JZpClpHLrbLeJRRaft6H?=
 =?us-ascii?Q?tyfiOqr7wQ7Vl6ELX7h8QbNiuJJ6VPPV1XAq0amGSTJOOPP6NyIbQJDV6FCn?=
 =?us-ascii?Q?OosQKgBcR5QOG8KWI8fLmybS1mrNMFrz0diEKjJ4ZI7tapt/6+BKTFYjC9e4?=
 =?us-ascii?Q?wbSgkruhKphpGcMb7pbX+ek0LzekiLe+Rf8QbP8q2FF4/WO4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58190766-c41a-4a0a-6a34-08df4baeca97
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 11:17:00.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgwM3jnmXygUHSALx+a9mpZqEpbYTnVEWJscdFUwlFYrSbSU1aXZWnJvjrUGcqXLXCsijDS/25wptiRFGN7A5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

Proxy execution keeps mutex-blocked donors on the runqueue. A BPF
scheduler with SCX_OPS_ENQ_BLOCKED admits donors that block while it
owns them, but sched_ext is not currently designed to pass it donors
retained elsewhere, regardless of SCX_OPS_ENQ_BLOCKED. To enforce this,
explicit hooks at the entry points into sched_ext block a retained donor
before sched_change_begin() records its queued state.

Tao Cui reported [1] that rt_mutex_setprio() has no such hook: an EXT
task that is PI-boosted into RT/DL and blocks on a second mutex while
boosted is retained by RT/DL, and when the boost goes away it is handed
back to sched_ext as a queued blocked donor that the BPF scheduler never
admitted.

The same can happen in __sched_setscheduler(). It calls
scx_prepare_setscheduler() to block a retained donor, but only when the
requested policy is SCHED_EXT. When the BPF scheduler takes over all
tasks (no SCX_OPS_SWITCH_PARTIAL), switching an RT/DL task to
SCHED_NORMAL, e.g., via sched_setscheduler(2) or sysrq-n, also moves it
into EXT without blocking the donor. In both cases, a BPF scheduler
without SCX_OPS_ENQ_BLOCKED receives a queued blocked donor it never
admitted: the donor is enqueued without SCX_ENQ_BLOCKED and, once
picked, proxy execution runs the mutex owner on its behalf, even though
the BPF scheduler opted out of it.

As suggested by Peter [2], instead of adding more hooks, let the
incoming class decide: switching_to() now returns whether the class
accepts a retained proxy donor, and sched_change_end() blocks the task
when it doesn't. This handles every class transition into sched_ext,
including PI deboost, and replaces the existing explicit hooks.

Moreover, moving a task between BPF schedulers (sub-sched enable,
rehome, punt) doesn't change its sched_class, so switching_to() doesn't
run there. Rather than keeping a separate hook for these paths, make
SCX_OPS_ENQ_BLOCKED a property of the whole hierarchy: a sub-scheduler
must match the root scheduler's setting or it fails to load, as also
suggested by Peter [3]. This makes the remaining scx-specific donor
blocking, and sched_proxy_block_task(), unnecessary.

Behavior change: a BPF scheduler with SCX_OPS_ENQ_BLOCKED now inherits
retained donors on class entry instead of having them blocked. A queued
donor is passed to ops.enqueue() with SCX_ENQ_BLOCKED as soon as the
scheduler isn't bypassing. The current donor, like any running task
entering sched_ext, keeps running without going through ops.enqueue(),
and gets SCX_ENQ_BLOCKED the next time it does.

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-proxy-donors

Peter, should we route this through the sched_ext tree or would you
prefer that I rebase it onto tip/sched/core?

Thanks,
-Andrea

[1] https://lore.kernel.org/r/20261112144935.583937-3-cui.tao@linux.dev
[2] https://lore.kernel.org/r/20261112160136.GF1922751@noisy.programming.kicks-ass.net
[3] https://lore.kernel.org/r/20261112164149.GE1813469@noisy.programming.kicks-ass.net

Andrea Righi (4):
  sched: Let switching_to() decide whether to keep a retained proxy donor
  sched_ext: Make SCX_OPS_ENQ_BLOCKED a hierarchy-wide setting
  sched: Remove sched_proxy_block_task()
  selftests/sched_ext: Check that blocked donors are never enqueued unadmitted

 kernel/sched/core.c                                | 118 ++++++++++++++-------
 kernel/sched/ext/ext.c                             |  78 +++++---------
 kernel/sched/ext/ext.h                             |   2 -
 kernel/sched/ext/internal.h                        |   4 +-
 kernel/sched/ext/sub.c                             |  12 +--
 kernel/sched/idle.c                                |   2 +-
 kernel/sched/sched.h                               |  16 +--
 kernel/sched/stop_task.c                           |   2 +-
 kernel/sched/syscalls.c                            |   2 -
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   1 -
 tools/sched_ext/include/scx/enums_abi.autogen.h    |   1 -
 tools/sched_ext/scx_qmap.c                         |   2 +-
 .../testing/selftests/sched_ext/enq_blocked.bpf.c  |   9 ++
 tools/testing/selftests/sched_ext/enq_blocked.c    |  18 +++-
 14 files changed, 149 insertions(+), 118 deletions(-)
