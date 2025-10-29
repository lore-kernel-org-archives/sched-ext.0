Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB453358D8
	for <sched-ext@lists.linux.dev>; Wed, 29 Oct 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743340; cv=fail; b=iBWTKMYeLXtreMB2yUjwijfTYWbANJS+zqC44KH9C42hZ6lcBm4DtzupL6YDZW+kiHWk/ls0NCqX39E82Bvw3Npl0nowsP0O7W+kOacoYNhKA7d5ytOoo6MofrrxfUS7R1bHLocVMD0nkgwrxo3X+cvd/QmVrUR2rDi6UQEROAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743340; c=relaxed/simple;
	bh=2HKhwUyFuWAcglSo6ChSmQrY9dycrKngibumPNO+04U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kIL515gtcMjuIYNp/OS2YFoSmtv+L5+t0kjo82g0UIMpoKwrcKx+MxJOWtIcbIxwwgFpsuvoUhQLApw0TVjlSHcfOpOOCywHhR5sHEhbgKa84f05DNMYS2u+BMkMjWuXC5dirVRHoiy5yNkAWQAFZA9tldg/myHE3sUMUScqf1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XL4FD5ne; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XL4FD5ne"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKet3ODlf+ZjFgOSknLu3UpMloWCcpNUIsrii4ufdrYP7GlIzsYSngPrdUaA9Hbw7BFqcX7dFeBq/X17TunDuO6Bx69EXlpU44ecQ3pGemYaUsOlWNz8TXDEVQ5+QhlZeFILxpoxh1z3zHoYJRDeOOizHt5k0ZZhcM8hUtk+NO291o+n8WC/xEReq9qCBgblairD5fz9c3W3XaNDIm1yTL4fg6o0iJqfu8sTw4ShPz/yVXThXiaBfcGg99mku2QNAgIZEveF+LDvmWB0YSnkvfpxsjcNhvtd16ns8z6SjaU92hOTvFKyWU30n+AyuRJRm7fep6wgI4Kzhq4z5GOD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SXJBvPRqFd1JfQTIFwxIsf41niYjhakW/ft1qLCz4Y=;
 b=sIricmUQyMTllzEP5nmjpLqL9tU77Vh+JOOd6laDCrXi7rzTCzaTbdw6HCG9lEJ1C3/mk/qlFTzYTFXl4+KwNZU90OV0aQO2dzo3r/6wv1xvevViDlGyOeU0KkoO71lwR/VyMLRfB/854Hmep2G772SOg8TdXbwEycFIYNehMOvpQLgXeMixJh9ZMoDtexBKFCN3thxawh8hDoM0350oN34T0CqMTpsXf4NBVImAten8kfN+tjcDzjzZZNzgB8syhhDCkRNknLtdMebtwkwlGKszMI/C6MRjtNRvAJ34bpctPGQ1KmxMtrOx8acMU4buQk8YrcBpjurQZfbncRMCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SXJBvPRqFd1JfQTIFwxIsf41niYjhakW/ft1qLCz4Y=;
 b=XL4FD5neMHj+j82Ep1WNXiCM8EQL4QWQJpjLj60wfV5AezxHd/husXtqCoqO3XryU0qmbLL7AzYhpdBpQM7Pqtlgon3bj7KLhoB53a64vMMSNSucLWSbTbI+MTFj5O3aO3oVn83mt5aymb2m4T1NUohGQD9h3GhqgvDf/32Pb31fsCctu5jM1Dx4VTGTBgznnEe0MFRdGB7uOM8BV0rlmSqHmecr76zoUaeZg73fkDW0kDIz4xFcfHVxBy9xvPmnaBHVKSPLFceKo436XquTKwqIb8V8kzXCI05kz0t6EytOA37KDUa0RMN11JzIjdnAwxHK7sPlNkBCO+JM/sOGbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 13:08:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 13:08:54 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Fix use of uninitialized variable in scx_bpf_cpuperf_set()
Date: Wed, 29 Oct 2025 14:08:43 +0100
Message-ID: <20251029130843.2977395-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d96479-6ec2-456a-9d82-08de16ec4faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LX0hy0csW5TlJRD5Xm/CGl4u5DB5ccWtTDxNydIyHu4MWGFPnfimVKmhmur1?=
 =?us-ascii?Q?Wx/WUXgGshOShr8YEXkHvmIG07reGLcx7Jm/HirHRJLtX6ll3mKUMJYM0wxo?=
 =?us-ascii?Q?HfZD/x3qNrnVAus76s59Pgghg++FO6E0gUii5iS3lYjD4NQWWvrC5YTXwYHe?=
 =?us-ascii?Q?GVNzIi5NZHgcbsCJv6HyJqm3F/3zQhTyza/6qBpJsZTmrbqlchDpUZ3+7j+s?=
 =?us-ascii?Q?08x2fm7dtbATbmqBGfpaoZvofy4kQs9VN9I1BIL0GviojUjW5Zde1tiPZ7ag?=
 =?us-ascii?Q?HDXIfHsFHkrjJzM6hbd+BFzleARELX2ncT/KTpf9ales/Yr0Uq3r73x0JtXa?=
 =?us-ascii?Q?h24BZhJe7jKK2pH5p7S5elmqF9LQn7AgXMba2uD9Bhlg766O0K3he+T5bXY3?=
 =?us-ascii?Q?3mSsmyiUCZBbfwx7cf12cMRE+JaIJV8zLuhtDBTJJP089a+wJFCcs8i6tyAw?=
 =?us-ascii?Q?cT6xpDNqzyTHlcWwLZ0IUlcpyvO59zc8S7NZM0ZzxI2AvwqQBuePHbAz2wTJ?=
 =?us-ascii?Q?jDk2biFIjWLj43AGmlP3UT3zWj1Mpg6L0fiR3WQW9Pv6bsdj8ChMzNH8EH/Z?=
 =?us-ascii?Q?oeaxZ4me7ixO8toyaizTkIv7tmaIa5axyiIpi8Qv8chkxqbKKZw34GAH/hzE?=
 =?us-ascii?Q?tut4jvEdLq0FrGBgYInXKPbZ0AUAoXmh2Va2Vwaa0BRfr0g1btAEHjrbXeZr?=
 =?us-ascii?Q?oLbOgztxMl2tYTfXbm707HON/yjUFEm4CPQa/js9CFCzo7o99+HuB1GvRgy7?=
 =?us-ascii?Q?lPir8lzQtZK+AGab/TK/ZvcnGEtmZhdZCab17iam81qmlBlqWLdNhUjQkSeo?=
 =?us-ascii?Q?7UTcW3DBwBSmhPVpdcOlscBj3csc8WD3dOFSYWqvfwyUd/0Vye1RPGJoHnIE?=
 =?us-ascii?Q?IFwlU3ThWCUJzGdbs0EzsnbfoBhaU+OSV8ckrTJ8uulXXMPOo8DD9YfEn7Ie?=
 =?us-ascii?Q?ngiFQIHWa6EsPfW3pWe0GjueqnZQMgttn0yNxBfiGyTlRjC8N906kX0fXUUX?=
 =?us-ascii?Q?L32aQ2y/JLI0L9POOvKh7Lix5EbRmmRhpPIHlpFugm2rXZQO22ONzVNZ4dix?=
 =?us-ascii?Q?92jg0uIAbmeHsnOqrbREKofMn2VheIhFW8Zk3/dUhjH4jnNNYO789VdoIOHy?=
 =?us-ascii?Q?YKfpAA3RCDnv1NYJj3SPYBH3i5I+KgMl1mLjKvy0oZ/5KcdR3dSxMAUI2c7/?=
 =?us-ascii?Q?gNvNT0wkhgNUtqI302cepgbq6GpBQgw2P3bXwz0fUqeIUNAiS6LaAp/gRim+?=
 =?us-ascii?Q?KrpiRD/5TtdAbpTGl4+14nzxac5yYZoz2wrfq2NIy7rynmt3DVf+9Afx96yl?=
 =?us-ascii?Q?FLJFUsGCVt8U7RQPrSCFDq1FHC1oTFxEOTRKKXJDZj4AoSQUUs41Y8ZItU9u?=
 =?us-ascii?Q?8prZB6u0O284pjddrojbDRl2MlfanoNpJOHPHm60ABbQJbjf0FHQzUfVIDM6?=
 =?us-ascii?Q?3Z+lKNF2Z2iGXJfkDLat6aEIWvcTW8H0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJIRqH/gkUvRNTiXKM72ToM/em0u2r9JFwEMpWqMHUq/Y6kYGJVM4doMIlfB?=
 =?us-ascii?Q?uKcT3LaLB44zxQgKg9GC7Nx3BsHfBDKIybn/I3uVP+ge4eHT7pafV67FSiqC?=
 =?us-ascii?Q?8UfhY8HwILU6gE6aKxeRbM/FmmQhQO8FVO8R/bX/EZI5r6LRdmYHqLA9zVkM?=
 =?us-ascii?Q?EYYjsBo/NyanbOc2NHcAdPgRNzH2vPCWcWQseqSgjx6TNch8or78nDbDoWon?=
 =?us-ascii?Q?qnRg81qyt40lEqCULx1tIMf30mEAomzlwjvnXb7Frn5h9fvZPD6agKqqCIn5?=
 =?us-ascii?Q?616oDABWcE40kqwqLpdM2xtZa/6Q3cKU7XfQXApYn3bId8Uze++E275t8XJh?=
 =?us-ascii?Q?uPg+m3oU8EuCTHnQIwjEu/rhDTdMaz1Q/RqqKTB7RTY/dvdPkSh33iH69bLN?=
 =?us-ascii?Q?kyV1nZtuR+HGQcOhKJXJy5rGVNLAgrTmP/Yav6ke9EYv3XyohBpRJBRM5h+Q?=
 =?us-ascii?Q?SOe5HOOfRvPCPe8THq+H3naLPJPK9zUVS+l0LncuhQj6kxKE/23FWjv9vU+3?=
 =?us-ascii?Q?fTmkbgDpsWIc45UkRVkG3anrf0sVBvFPndcfK1e57xQJ45dr2bW90JU+wOZK?=
 =?us-ascii?Q?V8XaAq/md84aFqPf94jThvFTeYAx5nGiHcpP4WlDUfEj6eH+Qk8GxC/aT+5E?=
 =?us-ascii?Q?EdNHzIPluhYRl4BeDTG5BMxmCk79u2E/lCxZVWY9K8EZiE4lRztW3EPYe+0k?=
 =?us-ascii?Q?S5fIQwQXgOVTDLjSzU7v2K148+aCNMzo9VWA9QTJyBd6XP0/cbCdBbX1Ikxa?=
 =?us-ascii?Q?CDbOiZkecjtFbAxgH1EH+b3dwJpLess+1qQJnFiD8gbTokUgHx1bMbXgoKM2?=
 =?us-ascii?Q?JD8voZxYc9mCwtmzn+a9X6R5erbTbcgaLqyMv+xxyvrorIjjxHM+taMYlUF+?=
 =?us-ascii?Q?n7RuosY/7ullyNSa/3Bf4TxUcl8c89PUurPUOBfa1raFI4dV7GjMjoS76PYH?=
 =?us-ascii?Q?YdycGOJjxo6K738+rxiXogMWFUi2UeqJ7CzWqL4ZyKz2bs3knH2CHEZS72X9?=
 =?us-ascii?Q?C/iZu8MmDHM2ZFMq7DOc1CMZSJUsvjlBr0MjwvU1lkf1KebelXHDpHQXnRax?=
 =?us-ascii?Q?+FQK4mqa48cdjrz/wY3XtghBMQBIquKDNmmkV/nkdWBbM52iFcM1Tviue4QB?=
 =?us-ascii?Q?oe0WRIDr+2DvBeP9QJT1TyHJgUoP28VShorZKmF/wlrnpfzvNZ3gGRQQITYm?=
 =?us-ascii?Q?Ezn9edvTcPJbC/KtYew8MAhiqBroDsH2eIVITNYUzFgt2TjON0ZCXnd7yDDu?=
 =?us-ascii?Q?s+M7vNVvynusZJBer94j4hJ8yW1YGj/P2j9saQt2PuSphixMP1pfwYT2P1mf?=
 =?us-ascii?Q?NR94SfzkCky+073p3sroQ5fRY3nB25/ltQVl44g4/sf2DkqalUOS+BsbIoGf?=
 =?us-ascii?Q?KYH18/5NnZTZWhbtC1wPdOB+XYKfZIbGP32h7bIxTCtmJGp1P3yBlA0o8x0w?=
 =?us-ascii?Q?sjZY2lV6bA+f+lG13vyVavQhAV+gwJBM1RMwroMPVTfe0uAIxHi/iiPKv+2s?=
 =?us-ascii?Q?NPjlW/NgXEdc4RlLO3zQnFDxt2Cy6+y5X74BEkvITXPSfBmZ3Px7FWAugq3f?=
 =?us-ascii?Q?rAOCwbS7Eua6PA9OYXp+L8x7AOViH/cxBSeAkVWX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d96479-6ec2-456a-9d82-08de16ec4faf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 13:08:54.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10+37udo3gaXfeVe6llQ1uV5bM3T13CeCnAmclIYQlQslZG+wLw2sxuQJVCJQIQ/nGU9xGt2KebEQDLqrKbaYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704

scx_bpf_cpuperf_set() has a typo where it dereferences the local
variable @sch, instead of the global @scx_root pointer. Fix by
dereferencing the correct variable.

Fixes: 956f2b11a8a4f ("sched_ext: Drop kf_cpu_valid()")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ecb251e883eab..1a019a7728fb2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6401,7 +6401,7 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
 
 	guard(rcu)();
 
-	sch = rcu_dereference(sch);
+	sch = rcu_dereference(scx_root);
 	if (unlikely(!sch))
 		return;
 
-- 
2.51.2

