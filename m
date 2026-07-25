Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4BF3EC687
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995626; cv=fail; b=GOoDORk5pOYPW4mj/DFTM9UHC9dkxMd+pr6WAOYK7IE+CRhKJYY6yv5wj0NM88IPCcT0cfXSwLZQmHktirG5mMXOm8Lvwm/pk5NEfrg3SoZ3eZIRirKmRvCGsrM86hf/kpmv+j195I24Hd2yHxrzh5cGlVGL4+qCpIaTkX6A8ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995626; c=relaxed/simple;
	bh=AW22c+oIVPm54OunVnTdZfmqlUX7ak5Fx9HZTSaJyuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YeC5SEBtMdQkl4v0BkLrGl5M6j/Td7cMUhNXD1+lJRGgZGKgtf5etyYhpjzXmaxBJJYoyoqMtRdiODdTsyHt9NSPD6SmtM1H22DGI86bd80lve912LBtaZNZxDZ9ymYEzpOXu08RX223TbdZtGL5vfd3o7M4i/gBlC+ZxwtI0lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HJRy+HG7; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJRy+HG7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7Trvq22GHuDg+iziClwbyvgtrgj44kBhG8uE1rUNZJVl9c8AzWYhwWixfabjmPQWFvx3XJr5rAV93SuW0y1Vzz1yUfhBc2FTRKiQGWO3jvGzgr9WiU6mh7SIOMqUwp9lHoEsG/PdCUW2OhIcZnt/IgtYnl5NmYRmkicayBGWs4BOHrABlhi1q+MN5+paRk/bcynu3hIBxbv91gfdSV6arWwFZgdYPYnFX6TR8re4A9yS0axW4vdQdlosoZJm90ADRvGoEIu6AZ/56tIcwx0KqZcQ0Y0sleByC9/DsFgOBQqjL8hfVgYd2KZtO48hTIaNLvfXr1jcLalO/u8zzhX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKBjgsNrAPpclO6ZzyqJNEcASQmIz711P7QoZ9+Jc5Q=;
 b=o31zmx3tyB/YXZvlt9pfbbuH+VOno4tWQR4i/Ci5OQswFntwm42Z0kUraNZuLC31EJynagRkB+0G9PFAr6tLFO9havWeon7vsPH4HmyTtLTkcrZg03x3oFoFGFeXoxvosWq0MG70QWNFoWVo8h7TyON2Jtgnv6ZI9Tlmv/efU2vdnmDMxfYM4l4OhGqqwP/s8Aqmq2ys/kCg3mtOKZUJ8Mh0ee1lFam98g6GvlWKvDgISm+Z9zFivkG959JiDzXQspNZz0RGhuQH+XCgn0XQQuEajb2QR2cx94oBvin7jGA0Ll/5PCTkaNUJ0Kc8vKc4qiPI/nT6oC8KVDFhFFyxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKBjgsNrAPpclO6ZzyqJNEcASQmIz711P7QoZ9+Jc5Q=;
 b=HJRy+HG7PcQr203oul/ag7CRMXQjzZmU+UGoyybwc/ACTxomyjhzPcgbMh8UXbGel41LNRqlH+nl5GsCPP5R9gKs8fgyJGDLOtBSXr+LIiusSKAWZjoRG9pTmlmTHRgKrAPy2uUTls/hY8DdxWMzK1chsxE5UNrVyjc/xhhvmOlKilWNbQjanEiN91aoY2AhUFPCdG+zV3LgLhTmWmShkigJorvh08EMbdRYD2QXalS67/i/nIeFoXT+ZpYQyuOtCwr1adwQlfN4DApA+TXPYrHfiiBw4as7tbkjPwMkWQvSVBtPZo8hH2f5L149NbTz+vjzjrjVyTmhsOXjhdtsIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:06:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:06:58 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
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
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] sched: Allow enabling proxy exec with sched_ext
Date: Sat, 25 Jul 2026 18:04:20 +0200
Message-ID: <20260725160513.57477-15-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:a03:331::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 727b2d0c-6ef2-482c-eba7-08deea66c181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q4b5XcgPkHr1dN6EP4HpEL+4FFzoJh4L+1iau8GG3VX/EoXaCX1ap8N45RdQNXswvR6owJZFuTixKU3uExYiTW/xc885dZVlCv6/B4hL0jmEBDATtluCsqvZhecmbWiAx6d0iJBmSPUu+6iq7LG4nWBSCFCmsGPz42FI+5iBXh1BvH0Y/ZoOk84o8uVGfeUnix9J/Ny1TVbonAzHuoSWfls6ss1myFa8sySC12fm0jHm0HbqRjfebMkYOAzjxpKukA8mgvekzyJ6HFEIy+khcLIzCYRcCYa/0w2tCiG8cWQ+Bl0ecmC8O+ibFxu2Ix6kx3Fyty5WQ4w5AuGX3jqx+w5QxmTAh7xrrLM0OKYUAC5V7tndf6PUs1gEYDK+sF6z7iCkJfhUoUm1wsScpdksB5OOWyGFW4Ms/NnAQeiEu+thUsDuQGcxhSY5Zco45ajwCmFSsBn5fWX+jbpBeFJPoz8TTF70AiINnUKpZjHnqWZ+mslLvLobGITe7r9Ik9uU5tKu3zenoltQHWLIMs/Nz/4eNjDr/p74YKWIU1qtE7u0hcgV0kvqz4mRMlOKI/L6DGmam6wWdJjU9ifN4ElAi1mAAYJGigk5zCmmZzYckXgkB/VLpuZrvnJ37fXHIkgQkpxn/LpnspHjtWimnG8H3qzt/sTzI0wHXaD4W1PsF0U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/vPA+vvGC36790mce/9bDzKw31cIRW0SqMhUyVQ4gHcfy6ABnwhvzHB+370?=
 =?us-ascii?Q?tsCYXt4b3eVumFg9Xn4dCtE4PflFFv6Bcs4M6aZgAQ3+8vT1h7iTpAuM50ix?=
 =?us-ascii?Q?AivYlCOvoicSKK+5ga9pKXyRRm/833QHFWU6Y/oHD0tj2Gw72C2QMUFvA8rf?=
 =?us-ascii?Q?k+pikr4QmC4xSRkBw9MJ+tMRGRIpAuZyGmii8cVEtlKZo4e3I+jD2fWpTU1q?=
 =?us-ascii?Q?HPqgWaF6Dm6Swp1ZspPIMPgKdAPLebXPnh6WcE9tihGXk9T1qzuhxb4OHQqd?=
 =?us-ascii?Q?M5CIBOBi9JnhBi+fOBGn8x24A2wviFPhraqrkFe+PHZHHvyR1QUtbCclwPA7?=
 =?us-ascii?Q?fC1z/LRqkWLtOPDK9a0tyfpfWaHmOxR9p7RbawSyliLMIjMGcxfBvIMHzg46?=
 =?us-ascii?Q?LcVY5tFCJP0NcpchNK20F909Obt496wVdPBS099RUfLqbD/qCN0QMcSjHkR6?=
 =?us-ascii?Q?F38oULFyfVXBaQk1LsVZlc25eRv0gpl8u+a1b1r94q6KFlyS5DXzqMN1SKXE?=
 =?us-ascii?Q?zz1OukRg/OZ0MfEQuYnDvrwvpVdkMM0FzU/1FbU7UD6rW2l7pJks/20kQJGH?=
 =?us-ascii?Q?LlHx1t/cMYsIE43KLyhEkKpeNWCwd1PZQf2BDzEkjzlmyxMfXShOV3l/pOxq?=
 =?us-ascii?Q?6OMTtgWjL2UoATNwzXoiofFP0LKj5wKP/v6qi3TP6ESnUHCUveDS+M1RpwWm?=
 =?us-ascii?Q?wp+1J/n1J20F5WhQ8RVCCgcSpcUmBGnT1yadh8wYPiJzKEJX24en75GO0Isn?=
 =?us-ascii?Q?09tN/tNhxlpiZeL+Nc0PmTZE9sDTH3aWGT8qHZh9BgTsr7xCgZh6PqIEe1xZ?=
 =?us-ascii?Q?DpeDHjjMbSn7tNCbWoxWbNdFKocZFDNE/oGPKAu2MParqKcPmsLN4WFR0J24?=
 =?us-ascii?Q?w190P60Gw7spx8TdG0HEP27XfrUdypHUQhs9l1E4M0CClw2bqWRQ2ISYwEzQ?=
 =?us-ascii?Q?Kq8Oy8a4sGfpIHWJnC3Sii3NUrZFkK6Yo7N8rpu3HfKkTIeW6MiIRuY34RGE?=
 =?us-ascii?Q?O41v/qbirtXwWa+2rN+bOoQ5/5cG3c8OxzLKc1lx0aBBs01OW/YqojBpiVp5?=
 =?us-ascii?Q?dpfae0ThSWgLs8GN45rEn8vaXZIRoa0zIM3w7LkZMzl1qZr9DM9ZY1vvCRw+?=
 =?us-ascii?Q?BUx66ziqoi6DqY04DjMlU6/gbitCam41Kz0njBI1kE7wTBNSUCYcc4251o7l?=
 =?us-ascii?Q?aCzOtmDj4ggtmCvSIXt9mp5qpVuqxOQ840vAFPIRTqWULXfQu9T+cPlr9ddc?=
 =?us-ascii?Q?BAJW3bDws+wLA7KUbnPE+3a8gIR+WurvmwjWx2GsvZEDqni6cMUgR3k7Gxvu?=
 =?us-ascii?Q?hdfu683Zcur+HiYazHqYMQNfwJUK89yyXrV5kOlynaHWCj30JtCDOuS1CHIx?=
 =?us-ascii?Q?Zg+eGuto6ugkpYEq/JHg8KkrL251d6PIf457dVKtZtpT45cUJTU7EM7rfbTK?=
 =?us-ascii?Q?abZU9xX7RqT3WE9sekcGQRS5m7qQ7Uajr+4aVjEHGZsOVBIxBJ5wQMKN/h9t?=
 =?us-ascii?Q?taF4VHPbyGXbKIqasqyg/57USf1ESP5a3giZQGNeu2Voe6XC7DBGci29DZPs?=
 =?us-ascii?Q?L9wpUuzByxN5hfvTLLQvbSTRdaYi9E2crCTmM28voX2PFiSDJzX9UdOlWaYk?=
 =?us-ascii?Q?WGTL9ufpi7vp/j1lFBOw8yCCA5JZ1TjVdgQGkilwImLgKsm7eGSyuDsONcLg?=
 =?us-ascii?Q?LnGKYrsJnp+qy+ecNgV4bmPkDsckAQdyFyGXRugZEdcpbKD04aydUXd9d3CB?=
 =?us-ascii?Q?1AA9Tr/GqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727b2d0c-6ef2-482c-eba7-08deea66c181
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:06:58.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlZ4XajeksL6Xap/rAowGIYRXJefWe0qG7QctRNhm4NIh5vH/BQn6y6ONcWS9c99lgOUv8sSzmpqE51otBmg8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

Now that sched_ext can handle proxy donors and BPF schedulers can opt in
to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
!SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
to be enabled together.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 init/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c8..0817e62266e03 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -934,8 +934,6 @@ config SCHED_PROXY_EXEC
 	bool "Proxy Execution"
 	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
 	depends on !PREEMPT_RT
-	# Need to investigate how to inform sched_ext of split contexts
-	depends on !SCHED_CLASS_EXT
 	# Not particularly useful until we get to multi-rq proxying
 	depends on EXPERT
 	help
-- 
2.55.0

