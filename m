Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089C4302FF
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615693; cv=fail; b=krbGTlH6HrWelyI8wHCANZ3Lp5UHynHMsbajSONIliuR3HWCkh2iZ+Yw1nP4WAvZloJRpnDVMLH2N6p30TUa4OYq829HtqJRyXkK1wiKef61lkSg8ywjjDPtHcgBqQ2hHjdmB+/SB1FqlqV8bgW2Qw9NHIqZ2WqN57RZiYtfFz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615693; c=relaxed/simple;
	bh=1FdUVfSt4RQISHefca2TB+7NxXrzIsbbaqLvHILldGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9M9ajytJufdjywd+tFOkASlkWLjICasV7tyW/fvcvIvJwiWvBhPUq40gyShH4XY69kJwd7O0kstr5w/zD1z4NsdxT/bI8earHpeFlbhsdF63Wf0Z1ZWuohqU0skHbQmi3XNVsiCaaon9iQVGumcFbSdVyOrDpCyYGa+2pjlLMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uFO6jq5+; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uFO6jq5+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtO680cO+AXW5tpt+QDooDpsfOvIaQoFhwGih2438a7mLslrLnnx05lE2zbM2/ETkLe+v+o/gLKhFFsc2noG+qm8lNu/XPks6g63WX1L1UKnq4NPPweEUMqnz/EQDlKICYFPYSltRzjZ2pPFtVcHK8siP+NoFN3/vnseu71QtxcaZVxKA83UBB1CG/1o4aX8QL9Ti6aR7wLa2SR+nQtQelm6JMONwsd6QBeHpXumvgAoRGvd8Di3HM4vZwki4UHXHowDVEjVsKCkxvd49sM+4aAIsCxKAHKK1GxO/35lLXDkH/7vO72HNTruca5sFwdrv50KNNOitzsfrHuKtVgQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=sVzFdZ6iKyyqVJTVWmNI4ylOP72G6ZykkNTQq6L1ADwsEwcQ0MCtLKlbfO6PXyUM2aq+AhumJJD5fOKteswIlSDUffzRvKRle79V+NF602fD0w0mzKHC+rZZgIgHiCXjUfClv+xApZQgkZXJ0ubXBYy2aIjOpuQ5+no0VaaLQr0hd6i98zaO5OSDESYw7yKbmBoAl/EJNL80sVne3DQjv2qjB5ci32VvjBrimFdySqPegP5N2ZqHV//hf0+2026ugu32dTolaCLC9THUFIZJfEXrKi9oaXy5ZWebGy98H5tMWkGGQY96cWlFnD6JqDw0O1qO5iokX3uBbAYI2AlN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=uFO6jq5+hgweet18MNR9EBXInayoeq+Lpkq8Q32XBDuJ+XDVobyfHPciv4NRvhCjugEfIORW+B6HZadu2c47A0pJJ53ZAv/FZrJ0n2N72HtArB9Uzbelj6d3C4T/N0u5Dxv6TDriObyQfCQeoEm7+aiHStf7R+uGTEHfbskmXHpn3xwaDC0eOpmgEMwDTG0BDRpFPmNSDcBmsbh+/ezgj8SRybgzP91wSJOMR/ixgSQj1TT0FFpeNsB02/KSfEa0knQeZjkCu+gLxBkJ9JP0Z2+ONnCySQ5SUA9bIw5WmxYBp334QZk/SgdhQs/PR+bB6v7S4LxIme5taM8jxbgHPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:34:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:34:39 +0000
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
Subject: [PATCH 12/12] sched: Allow enabling proxy exec with sched_ext
Date: Tue, 21 Jul 2026 08:31:33 +0200
Message-ID: <20260721063242.552774-13-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::30) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 48319bb1-8038-4270-e6fd-08dee6f223c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XA2kkqo1AFEjhv5Ts7HU1jE8yjVgxff+yV6N/Ku1VO67q1YU9Vo8rV3OnbM9lusHzALEDAtUwOTGrtShnapWJWdN7q9gylAtm5lj+NYsPRN1k2PXZLgfzFJaXIpdk0Ii5uVvxCOqwHO81l9AoJshw8Bm/UDvsG2QbYLHAcEHmdO/W8YJrvje7XNxjENCgKbxNwulJJUZ/Wcq9BL6TBesYDNrMplkKhkfdmijBSFC3k4ldrOHILhj+oWsB0FRXl+EmDWQu+rQRSivV1brG4xp0xzl7Opm0T8SVFJDxWkaoEFj27IQXS2tIknWvWpOGAzuv98i2PqHMHAYGEFXc+lr/xeljrifQ7DRwLXh9nBGVWlpXmEv4MoIfhysGpbxy6xjs0/my2vFFS+zgrU6/yIKZU4ONKhiYXmYQh/F5DH/yVyNWlaj4mJuYfzKLeU9QJQJ8Poaal7+cVdf0Mly2poQAKnsFIf6opwQug3vFZC9orvTnu0zsdMthJmQlgXlpn5wrkVMO4l7Tr5sQe8zE33aFliw2ishYO14uA+lGTcPAZsltetM/tqHqco5sGRxlWdZq+M6FqSV+XKvHiIK17+/5uZhpvuTHqmMWtGp6lGq9gsz/KED+IX/Xqx5MymA/7821dvQ8J5V61T4mN3eLo3VL+IoJgn345LY0G7IilxlcuQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VfDCsngkKNdR+Aow6wh1JQa8P5Z5+AJ8mJX3mchOlzeyx11zQxFRdZeNzWr9?=
 =?us-ascii?Q?N9eeHbENH6aod77jbuGNktBC+vLtMYSzvnXGi+fsjTU8omZxckI6Gvp4t1ji?=
 =?us-ascii?Q?26luXdF3qdsJHnkkbANzQSNB+9GtfhG3DSquqSQ58WAls2cPdBKTBA44Lfgm?=
 =?us-ascii?Q?N+9vsPLV9rN16bdKQJ6V3vJd34Vi1wdBN94aJpjR6zWSfBwHtOFTkUdxybpk?=
 =?us-ascii?Q?RVa/t867r0Wg29ZAX8vPA18t8gdvWc4+MEWXfUs4t2l3sngcUZxuPMMPSXQ6?=
 =?us-ascii?Q?3V8I9+fk2qqb8+HaJArKXuqHH4Bvino/RJdJE3JAQBFnlNrucjSs0P0Rjgmr?=
 =?us-ascii?Q?AInTgjl7wkqUb/pmRyEcj6r1wsMtgDftKQ4py/xsLO3xNf4new4ZlowfW5kO?=
 =?us-ascii?Q?VGPQAaE4Zr11tmAtGVMAhwN9w0pZvMgjiFgjH29uZjSdShqrSl5qLSfC9Pku?=
 =?us-ascii?Q?MT/vZEVSET6B+nQWT1j2uuVQdhyyFVynJSr/WQoW9VBka5MyWXMEQk+1A4YO?=
 =?us-ascii?Q?8ILcJrE77MrCpJZM9kOWTBg7+CBQ1pg0lQi5R46QbhyhHB0iqVEoD1jrcRSf?=
 =?us-ascii?Q?4a1fTM28iJUFxU66z5XmvgD7SvjIohiCMbZ27tTXOvmjq52NfLy9nSxZNnUx?=
 =?us-ascii?Q?n5NqQ0rd8XwBT4SROVjdpyymc4WBUkX54jc/z9T9YnHs1NZkNHc/J1L6aGj4?=
 =?us-ascii?Q?9yukPryLgTFFwFcfnG9nCxku6EJs3wDqIBW9AZOlp58DQMOF4TFXUPkgkzRM?=
 =?us-ascii?Q?OhG3RszBVQ+UBru5hRsIhs+vXXLWrGXl/5Nx4U5e5usazFsQGpYHQZ5wBU6h?=
 =?us-ascii?Q?mOuOLCBeLLClrjDY5/SuPDXEmg+JgmXgiop1o4DfMi6Vt+nZbF8hgdpEv2Sl?=
 =?us-ascii?Q?xS/zblXtIEywMzXDPHNLBLG4G1x5Lh/rXAzTf5JAltZsN1HnVjvUFiZFJmGU?=
 =?us-ascii?Q?XMaLZQDyY+vyPBKIIeYij9iCXjF15GSTj1mU7wNOMN3Be6TnRknAI+xvBVup?=
 =?us-ascii?Q?Fc5cDpmDJUqT4sm09uIz6qpT7xxK/rcmPSyhs7URMvpsnDU04wLe8VlTpTzO?=
 =?us-ascii?Q?mEZS8Jo9ixCIU/Qe7fbJ1+SaKBdK/1/Nami0rJYHN/4xHupW6jlYeRIUyfaS?=
 =?us-ascii?Q?wN/aLOCGIw7j75WqamGbG0XNuzwiGYY/x5TKwlHsavPPp6B4F5dhkkz00Pah?=
 =?us-ascii?Q?idlbE7Jb5zDJlazJ1UBLsejE1tbyfA8B//cTwgx1bfZ1VsHpsjbEWEPHO6+L?=
 =?us-ascii?Q?EVx1sG6p8BLge+D4wmy8JmcZXsOJP08AuPoVTTtrlo1E81Y85AwRtOjWAuGB?=
 =?us-ascii?Q?YZf1Plj+M4exfHs9hfsl54xla18NXQjbmZkwx9HPkYSw0TUkzxiE/moVrhy3?=
 =?us-ascii?Q?FgbUESiqZ2XPxS5BTdelo0w1K7CYc3Nf5Q9dgfGwDEeg+1tErPJ86a90yEhN?=
 =?us-ascii?Q?mSFiCiDqEKemgtEzf+dAzMpmMCyzhZOh3Q1+MwlJ7fI5gr9YnWqvRAM4guVX?=
 =?us-ascii?Q?gqz/BAZDCjpJIiXYForr8Qz+vj/B7B1HXh6wzrvr1OJwdVDEuqXb/+m/M1RQ?=
 =?us-ascii?Q?VCd/KQCbsN9iJyNnHoSLNWE7I01NLAIbwD/Rq8Hvc2PjaGwmBKdJndKphmRy?=
 =?us-ascii?Q?ebjzjb/4M3OxYlV6Qhywq/yrc1TMezH6SoMoP29gLL6DX+HIIwn8VqFW3XS6?=
 =?us-ascii?Q?fhFpjuSU59yht3naTKCjZ0mLdMjd0chuWka5TD9MkxHBb/MiArn3hP6f/xN6?=
 =?us-ascii?Q?BKhXtdduVQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48319bb1-8038-4270-e6fd-08dee6f223c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:34:39.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RyuaGw+VK8I9gSU1nTQRQQmR87pZTCbtvpxS2EjfDxCyhWBJpFNfKCvMmyWrtQNLIu0LUVpSNw/xa3uGHKxlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

Now that sched_ext can handle proxy donors and BPF schedulers can opt in
to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
!SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
to be enabled together.

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

